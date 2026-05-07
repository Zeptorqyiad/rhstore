<?php

namespace App\Extensions\Import;

use App\Extensions\Catalog\CacheGen;
use App\Extensions\Catalog\CategoryAssist;
use App\Extensions\Catalog\ConsoleCatalog;
use App\Extensions\Catalog\ProductAssist;
use App\Extensions\Catalog2\Model\Product;
use App\Extensions\Import\Parser\ParserInterface;
use Simflex\Admin\Fields\FieldAlias;
use Simflex\Admin\Fields\FieldBool;
use Simflex\Admin\Fields\FieldDouble;
use Simflex\Admin\Fields\FieldInt;
use Simflex\Admin\Fields\FieldMultiKey;
use Simflex\Admin\Fields\FieldNPP;
use Simflex\Admin\Fields\FieldRelation;
use Simflex\Admin\Fields\FieldTable;
use Simflex\Admin\Fields\FieldVirtual;
use Simflex\Admin\Plugins\Alert\Alert;
use Simflex\Core\DB;
use Simflex\Core\Helpers\Str;
use Simflex\Core\Log;

class Import
{
    /** @var callable|null */
    protected $onImported = null;

    protected array $multiKeyPass = [];

    protected int $nppCounter = 0;
    protected string $curTable = '';

    protected array $ppProd = [];
    protected array $ppValues = [];

    public function __construct(protected ParserInterface $parser)
    {
    }

    public function setOnImported($cbk): void
    {
        $this->onImported = $cbk;
    }

    protected function gen($s, $n): array
    {
        $o = [];
        for ($i = 0; $i < $n; ++$i) {
            $o[] = $s;
        }
        return $o;
    }

    protected function processField(int $tableId, &$row, &$key, &$value, string $iid)
    {
        if (str_starts_with($key, '#')) {
            if ($key == '#catalog_param') {
                Log::info('inserting ppProd {iid}', ['iid' => $iid]);

                foreach ($value as $item) {
                    $this->ppProd[$iid][] = [
                        'iid' => $item['Ид'],
                        'value' => $item['Значение']
                    ];
                }
            } elseif ($key == '#catalog_param_value') {
                Log::info('inserting ppValues {iid}', ['iid' => $iid]);

                foreach ($value as $item) {
                    $this->ppValues[$iid][] = [
                        'iid' => $item['ИдЗначения'],
                        'value' => $item['Значение']
                    ];
                }
            }

            $key = null;
            return;
        }

        $fieldName = explode('.', $key);
        $field = DB::assoc(
            'select sf.class, sd.params from struct_field sf left join struct_data sd using (field_id) where sd.name = ? and sd.table_id = ?',
            false,
            false,
            [
                $fieldName[0],
                $tableId
            ]
        );

        if ($field) {
            $field = $field[0];
        }

        $field['class'] = trim($field['class'], '\\');
        if ($field['class'] == FieldTable::class) {
            if (!$value) {
                $key = $fieldName[0];
                Log::warning('FieldTable: no value set (key - {k})', ['k' => $key]);
                return;
            }

            $struct = unserialize($field['params'])['main'] ?? [];
            $struct = json_decode($struct['struct'] ?? '', true) ?? [];
            $value = json_encode([
                's' => $struct['v'] ?? [],
                'v' => [
                    [$fieldName[1] => '/uf/files/' . $value] // todo: fix
                ]
            ]);

            $key = $fieldName[0];

            Log::info('fixing FieldTable (key: {k}, val {v})', ['k' => $key, 'v' => $value]);
        } elseif ($field['class'] == FieldAlias::class) {
            $value = Str::translite($row['name']);
            Log::info('fixing FieldAlias');
        } elseif ($field['class'] == FieldInt::class) {
            $struct = unserialize($field['params'])['main'] ?? [];
            if ($struct['is_fk']) {
                $value = DB::result('select id from mp_import where table_id = ? and iid = ?', 0, [
                    DB::result('select table_id from struct_table where name = ?', 0, [$struct['fk_table']]),
                    $value
                ]);

                if ($value === false) {
                    $value = $tableId == 49 ? null : 0;
                }
            }

            Log::info('fixing FieldInt');
        } elseif ($field['class'] == FieldMultiKey::class) {
            if (!$value) {
                $key = null;
                return;
            }

            $struct = unserialize($field['params'])['main'] ?? [];
            $rid = DB::result('select id from mp_import where table_id = ? and iid = ?', 0, [
                DB::result('select table_id from struct_table where name = ?', 0, [$struct['table_values']]),
                $value
            ]);

            $pkName = '';
            $fields = DB::query('select name, params from struct_data where table_id = ?', [$tableId]);
            while ($r = DB::fetch($fields)) {
                if ((unserialize($r['params'])['main'] ?? [])['pk']) {
                    $pkName = $r['name'];
                    break;
                }
            }

            $this->multiKeyPass[] = [
                'i_id' => $iid,
                'r_id' => $rid,
                'table' => $struct['table_relations'],
                'r_key' => $struct['key'],
                'i_key' => $pkName,
                'table_id' => $tableId,
            ];

            Log::info('fixing FieldMultiKey');
            $key = null;
        } elseif ($field['class'] == FieldVirtual::class) {
            $key = null;
        } elseif ($field['class'] == FieldRelation::class) {
            Log::warning('relations are not yet supported');
            $key = null;
        }
    }

    protected function prepareUnfilled(int $tableId, &$row)
    {
        $q = DB::query('select * from struct_data where table_id = ?', [$tableId]);
        while ($r = DB::fetch($q)) {
            if (!isset($row[$r['name']])) {
                $val = '';

                $s = unserialize($r['params'])['main'] ?? [];
                if ($s['pk']) {
                    continue;
                }

                if ($s && $s['defaultValue']) {
                    $val = $s['defaultValue'];
                }

                if (!$val) {
                    $cls = trim(DB::result('select class from struct_field where field_id = ?', 0, [$r['field_id']]),
                        '\\');
                    if ($cls == FieldInt::class || $cls == FieldBool::class || $cls == FieldDouble::class) {
                        $val = 0;
                    }

                    if ($cls == FieldNPP::class) {
                        $val = $this->nppCounter++;
                    }
                }

                $row[$r['name']] = $val;
            }
        }
    }

    protected function prepareValues(int $tableId, &$row): array
    {
        $iid = $row['__iid'];
        $id = DB::result('select id from mp_import where table_id = ? and iid = ?', 0, [$tableId, $iid]
        );
        unset($row['__iid']);

        $this->prepareUnfilled($tableId, $row);

        $nr = [];
        foreach ($row as $k => &$v) {
            $key = $k;
            $val = $v;

            // had this key already?
            if (isset($nr[$key])) {
                continue;
            }

            $this->processField($tableId, $row, $key, $val, $iid);
            if ($key) {
                $nr[$key] = $val;
            }
        }

        Log::info('insert data: {nr}', ['nr' => $nr]);

        $row = $nr;

        // todo: patch this out
        if ($this->curTable == 'catalog_category') {
            $row['path'] = 'catalog/' . $row['alias'];
            $row['is_active'] = 1; // force enable
        }

        return ['iid' => $iid, 'id' => $id];
    }

    protected function insert(string $table, array $ks, array $vs, array $insert = []): bool
    {
        $ret = DB::query(
            'insert into ' . $table . ' (' . implode(
                ', ',
                array_map(fn($k) => DB::wrapName($k), $ks)
            ) . ') values (' . implode(
                ', ',
                $this->gen('?', count($vs))
            ) . ')',
            $vs
        );

        if (!$ret) {
            Log::error('failure: {err}', ['err' => DB::error()]);
            Log::error('query: {q}', [
                'q' => 'insert into ' . $table . ' (' . implode(', ', $ks) . ') values (' . implode(
                        ', ',
                        $this->gen('?', count($vs))
                    ) . ')'
            ]);

            exit;
        }

        if ($ret && $insert) {
            Log::info('inserting to import table');
            DB::query('insert into mp_import (table_id, id, iid, parser_id) values (?, ?, ?, ?)', [
                $insert['tableId'],
                DB::insertId(),
                $insert['iid'],
                DB::result('select parser_id from mp_parser where class = ?', 0, [$this->parser::class])
            ]);
        }

        return !!$ret;
    }

    protected function update(string $table, array $ks, array $vs, string $idName, int $id)
    {
        $kvs = implode(', ', array_map(fn($n) => DB::wrapName($n) . ' = ?', $ks));
        $ret = !!DB::query(
            'update ' . $table . ' set ' . $kvs . ' where ' . $idName . ' = ' . $id,
            array_values($vs)
        );

        if (!$ret) {
            Log::error('failure: {err}', ['err' => DB::error()]);
        }

        return $ret;
    }

    protected function runMultiKeyPass(array $passInfo)
    {
        [
            'i_id' => $iid,
            'r_id' => $rid,
            'table' => $table,
            'r_key' => $rk,
            'i_key' => $ik,
            'table_id' => $tableId
        ] = $passInfo;

        Log::info('mkey pass: {iid} => {id}', ['iid' => $iid, 'id' => $rid]);
        $id = DB::result('select id from mp_import where iid = ? and table_id = ?', 0, [$iid, $tableId]);

        Log::info('will move delete {ik} = {id}, then add {ik}, {rk} = {id}, {rid}', [
            'ik' => $ik,
            'id' => $id,
            'rk' => $rk,
            'rid' => $rid,
        ]);
        DB::query("delete from $table where $ik = ?", [$id]);
        DB::query("insert into $table ($ik, $rk) values (?, ?)", [$id, $rid]);
    }

    // todo: patch this out
    // idea: maybe add a callback for per row basis?
    // need to figure out what to do with p2cs
    protected function fixProductPaths()
    {
        foreach (Product::all() as $p) {
            $cat = $p->getFirstCategory();
            if (!$cat) {
                // Log::warning('no category set for product {prod}', ['prod' => $p->name]);
                continue;
            }

            $p->path = $cat->path . '/' . $p->alias;
            $p->save();

            Log::info('fixed path for {prod}', ['prod' => $p->name]);
        }
    }

    protected function importPrices(array $data)
    {
        foreach ($data as $dt) {
            $id = DB::result('select id from mp_import where iid = ? and table_id = ?', 0, [
                $dt['__iid'],
                DB::result('select table_id from struct_table where name = ?', 0, ['catalog_product'])
            ]);

            if (!$id) {
                continue;
            }

            Log::info('updating price information for {id}', ['id' => $id]);

            DB::query('delete from catalog_price where product_id = ?', [$id]);
            $i = 1;
            foreach ($dt['price'] as $p) {
                DB::query(
                    'insert into catalog_price (product_id, variant_id, level_id, price) values (?, null, ?, ?)',
                    [
                        $id,
                        $i++,
                        $p
                    ]
                );
            }

            DB::query(
                'insert into catalog_price (product_id, variant_id, level_id, price) values (?, null, 6, 0)',
                [$id]
            );
        }
    }

    protected function importStock(array $data)
    {
        foreach ($data as $dt) {
            $id = DB::result('select id from mp_import where iid = ? and table_id = ?', 0, [
                $dt['__iid'],
                DB::result('select table_id from struct_table where name = ?', 0, ['catalog_product'])
            ]);

            if (!$id) {
                continue;
            }

            Log::info('updating stock information for {id}', ['id' => $id]);

            $stockId = DB::result('select stock_id from catalog_stock where product_id = ?', 0, [$id]);
            if (!$stockId) {
                DB::query(
                    'insert into catalog_stock (product_id, is_active, available, in_orders, variant_id) values (?, 1, ?, 0, 0)',
                    [
                        $id,
                        $dt['available']
                    ]
                );
            } else {
                DB::query('update catalog_stock set available = ? where product_id = ?', [
                    $dt['available'],
                    $id
                ]);
            }
        }
    }

    public function import(array $mapped)
    {
        foreach ($mapped as $table => $data) {
            $this->nppCounter = 0;
            $this->curTable = $table;

            if ($table == 'catalog_price') {
                $this->importPrices($data);
                continue;
            }

            if ($table == 'catalog_stock') {
                $this->importStock($data);
                continue;
            }

            $tableId = DB::result('select table_id from struct_table where name = ?', 0, [$table]);
            $tableNameArr = explode('_', $table);
            $idName = $tableNameArr[count($tableNameArr) - 1] . '_id';

            $si = 0;
            foreach ($data as $dt) {
                $dat = $dt;
                if (!$dat['__iid']) {
                    Log::warning('corrupted row in {tab}', ['tab' => $table]);
                    continue;
                }

                Log::info('{table}: {id}', ['table' => $table, 'id' => $dat['__iid']]);
                ['id' => $id, 'iid' => $iid] = $this->prepareValues($tableId, $dat);

                if ($iid == '81e55fa2-ac4e-11ec-bbee-ac1f6b7679b4' && $tableId == 49) {
                    Log::info('skipped thingy');
                    continue;
                }

                // see if it has the record already
                if ($id) {
                    Log::info('updating row cause has the id');
                    // update row
                    $ret = $this->update($table, array_keys($dat), array_values($dat), $idName, $id);
                } else {
                    Log::info('inserting new one');
                    if ($id !== null) {
                        Log::info('removing old import tag');
                        DB::query('delete from mp_import where iid = ? and id = ? and table_id = ?', [
                            $iid,
                            $id,
                            $tableId
                        ]);
                    }

                    $ret = $this->insert($table, array_keys($dat), array_values($dat), [
                        'tableId' => $tableId,
                        'iid' => $iid
                    ]);
                }

                if ($ret) {
                    ++$si;
                }
            }

            if ($this->onImported) {
                ($this->onImported)($table, $si);
            }
        }

        foreach ($this->multiKeyPass as $p) {
            $this->runMultiKeyPass($p);
        }

        // todo: patch this out
        $this->linkParamValues();
        $this->fixProductPaths();
        $this->fixCaches();
    }

    protected function linkParamValues(): void
    {
        $prodTable = DB::result('select table_id from struct_table where name = ?', 0, ['catalog_product']);
        $paramTable = DB::result('select table_id from struct_table where name = ?', 0, ['catalog_param']);

        foreach ($this->ppProd as $iid => $items) {
            $productId = DB::result('select id from mp_import where iid = ? and table_id = ?', 0, [$iid, $prodTable]);
            DB::query('delete from catalog_param_value where product_id = ?', [$productId]);

            foreach ($items as $item) {
                if ($item['iid'] == '81e55fa2-ac4e-11ec-bbee-ac1f6b7679b4') {
                    Log::info('HIT iid setting val {val}', ['val' => $item['value']]);

                    DB::query(
                        'update catalog_product set bulk_amount = ? where product_id = ?',
                        [$item['value'], $productId]
                    );

                    continue;
                }

                $paramId = DB::result(
                    'select id from mp_import where iid = ? and table_id = ?',
                    0,
                    [$item['iid'], $paramTable]
                );

                $value = $item['value'];
                if (isset($this->ppValues[$item['iid']])) {
                    Log::info(
                        '** Looking for real item value! {iid} (testing {val})',
                        ['iid' => $item['iid'], 'val' => $value]
                    );

                    foreach ($this->ppValues[$item['iid']] as $val) {
                        Log::info('{a} {b} = {r}', ['a' => $value, 'b' => $val['iid'], 'r' => $value == $val['iid']]);

                        if ($val['iid'] == $value) {
                            Log::info('Found {iid}: {val}', ['iid' => $item['iid'], 'val' => $val['value']]);
                            $value = $val['value'];
                            break;
                        }
                    }

                    if (!$value) {
                        continue;
                    }
                }

                if ($value == 'true' || $value == 'false') {
                    $value = $value == 'true' ? '1' : '0';
                }

                DB::query(
                    'insert into catalog_param_value (product_id, param_id, variant_id, value) values (?, ?, ?, ?)',
                    [
                        $productId,
                        $paramId,
                        0,
                        $value
                    ]
                );
            }
        }
    }

    protected function fixCaches()
    {
        $gen = new CacheGen();
        $gen->updateAll();

        foreach (\App\Extensions\Catalog\Model\Product::all() as $p) {
            ProductAssist::bakeNameCache($p);
        }

        CategoryAssist::generateCountCache();
        CategoryAssist::generateBrandCache();

        $cc = new ConsoleCatalog();
        $cc->updateProductCaches();
    }
}