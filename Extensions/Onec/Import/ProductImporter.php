<?php
namespace App\Extensions\Onec\Import;

use Simflex\Core\DB;
use Simflex\Core\Helpers\Str;

class ProductImporter
{
    public function import(array $products, ?callable $logger = null): void
    {
        $log = $logger ?? static function (string $msg, bool $isError = false): void {};

        $created = 0;
        $updated = 0;
        $linked = 0;
        $skipped = 0;
        $nppCounter = 0;

        $catByExternal = [];
        $res = DB::query('SELECT category_id, external_id, path FROM catalog_category');
        while ($row = DB::fetch($res)) {
            $ext = trim($row['external_id'] ?? '');
            if ($ext !== '') {
                $catByExternal[$ext] = [
                    'category_id' => (int)$row['category_id'],
                    'path' => $row['path'] ?? null,
                ];
            }
        }

        DB::transactionStart();
        try {
            foreach ($products as $prod) {
                $extId = trim($prod['ID'] ?? '');
                $name = trim($prod['name'] ?? '');
                $catExtId = trim($prod['CategoryID'] ?? '');

                if ($extId === '' || $name === '') {
                    $skipped++;
                    continue;
                }

                $alias = Str::translite($name);
                if ($alias === '') {
                    $alias = 'prod-' . substr(md5($extId), 0, 8);
                }

                $catInfo = $catExtId !== '' ? ($catByExternal[$catExtId] ?? null) : null;
                $path = $catInfo && !empty($catInfo['path'])
                    ? rtrim($catInfo['path'], '/') . '/' . $alias
                    : 'catalog/' . $alias;

                $desc = $prod['Description'] ?? null;
                $sku = $prod['SKU'] ?? null;
                $weight = $prod['Weight'] ?? null;
                $size = $prod['Volume'] ?? null;
                $bulkAmount = is_numeric($prod['bulk_amount'] ?? null) ? (int)$prod['bulk_amount'] : null;

                $isActive = 1;
                $isNewRaw = trim((string)($prod['is_new'] ?? ''));
                $isPopularRaw = trim((string)($prod['is_popular'] ?? ''));
                $isNew = ($isNewRaw === 'Да') ? 1 : 0;
                $isPopular = ($isPopularRaw === 'Да') ? 1 : 0;

                $res = DB::query(
                    'SELECT product_id FROM catalog_product WHERE external_id = ? LIMIT 1',
                    [$extId]
                );
                $exists = DB::fetch($res);

                if ($exists) {
                    DB::query(
                        'UPDATE catalog_product SET name = ?, alias = ?, path = ?, `desc` = ?, sku = ?, is_active = ?, is_new = ?, is_popular = ?, weight = ?, size = ?, bulk_amount = ? WHERE product_id = ?',
                        [$name, $alias, $path, $desc, $sku, $isActive, $isNew, $isPopular, $weight, $size, $bulkAmount, $exists['product_id']]
                    );
                    $productId = (int)$exists['product_id'];
                    $updated++;
                } else {
                    $npp = $nppCounter++;
                    DB::query(
                        'INSERT INTO catalog_product (external_id, npp, name, alias, path, `desc`, sku, is_active, is_new, is_popular, weight, size, bulk_amount) 
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                        [$extId, $npp, $name, $alias, $path, $desc, $sku, $isActive, $isNew, $isPopular, $weight, $size, $bulkAmount]
                    );
                    $productId = DB::insertId();
                    $created++;
                }

                if ($catInfo && $productId) {
                    DB::query('DELETE FROM catalog_p2c WHERE product_id = ?', [$productId]);
                    DB::query(
                        'INSERT INTO catalog_p2c (category_id, product_id) VALUES (?, ?)',
                        [$catInfo['category_id'], $productId]
                    );
                    $linked++;
                }

                DB::query('DELETE FROM catalog_product_name_cache WHERE product_id = ? AND variant_id IS NULL', [$productId]);
                DB::query(
                    'INSERT INTO catalog_product_name_cache (product_id, variant_id, name) VALUES (?, NULL, ?)',
                    [$productId, $name]
                );
            }

            DB::transactionCommit();

            $log("Создано: $created | Обновлено: $updated | Связи p2c: $linked | Пропущено: $skipped");
            $log('Импорт продуктов успешно завершён!');
        } catch (\Throwable $e) {
            DB::transactionRollback();
            $log('ОШИБКА: ' . $e->getMessage(), true);
            $log('Последний запрос: ' . DB::getLastQuery(), true);
            throw $e;
        }
    }
}
