<?php
namespace App\Extensions\Onec\Import;

use App\Extensions\Catalog\CategoryAssist;
use App\Extensions\Catalog\CacheGen;
use Simflex\Core\DB;
use Simflex\Core\Helpers\Str;

class CategoryImporter
{
    public function import(array $categories, bool $rebuildCache = false, ?callable $logger = null): void
    {
        $log = $logger ?? static function (string $msg, bool $isError = false): void {};

        $created = 0;
        $updated = 0;
        $linked = 0;
        $nppCounter = 0;

        DB::transactionStart();
        try {
            foreach ($categories as $cat) {
                $extId = trim($cat['ID'] ?? '');
                $name = trim($cat['name'] ?? '');
                $isActive = 1;

                if ($extId === '' || $name === '') {
                    continue;
                }

                $alias = Str::translite($name);
                if ($alias === '') {
                    $alias = 'cat-' . substr(md5($extId), 0, 8);
                }
                $path = 'catalog/' . $alias;
                $npp = $nppCounter++;

                $res = DB::query(
                    'SELECT category_id FROM catalog_category WHERE external_id = ? LIMIT 1',
                    [$extId]
                );
                $exists = DB::fetch($res);

                if ($exists) {
                    $current = DB::fetch(
                        DB::query(
                            'SELECT alias, path FROM catalog_category WHERE category_id = ? LIMIT 1',
                            [$exists['category_id']]
                        )
                    );
                    $aliasToSave = $current['alias'] ?? $alias;
                    $pathToSave = $current['path'] ?? $path;
                    DB::query(
                        'UPDATE catalog_category SET name = ?, alias = ?, path = ?, is_active = ?, npp = ? WHERE category_id = ?',
                        [$name, $aliasToSave, $pathToSave, $isActive, $npp, $exists['category_id']]
                    );
                    $updated++;
                } else {
                    DB::query(
                        'INSERT INTO catalog_category (external_id, pid, npp, name, alias, path, is_active) VALUES (?, 0, ?, ?, ?, ?, ?)',
                        [$extId, $npp, $name, $alias, $path, $isActive]
                    );
                    $created++;
                }
            }

            $log("Создано: $created | Обновлено: $updated");

            $nameToExtId = [];
            $res = DB::query('SELECT category_id, external_id FROM catalog_category');
            while ($row = DB::fetch($res)) {
                $nameToExtId[$row['external_id']] = (int)$row['category_id'];
            }

            foreach ($categories as $cat) {
                $extId = trim($cat['ID'] ?? '');
                $parentId = trim($cat['parent_id'] ?? '');

                if ($parentId === '00000000-0000-0000-0000-000000000000') {
                    $parentId = '';
                }

                if ($extId === '') {
                    continue;
                }

                if ($parentId === '') {
                    DB::query('UPDATE catalog_category SET pid = NULL WHERE external_id = ?', [$extId]);
                    continue;
                }

                $pid = $nameToExtId[$parentId] ?? null;
                if (!$pid) {
                    continue;
                }

                DB::query(
                    'UPDATE catalog_category SET pid = ? WHERE external_id = ? AND (pid IS NULL OR pid != ?)',
                    [$pid, $extId, $pid]
                );

                if (DB::affectedRows() > 0) {
                    $linked++;
                }
            }

            DB::transactionCommit();

            $log("Установлено связей pid: $linked");
            $log('Импорт успешно завершён!');

            if ($rebuildCache) {
                $this->rebuildCaches($log);
            }
        } catch (\Throwable $e) {
            DB::transactionRollback();
            $log('ОШИБКА: ' . $e->getMessage(), true);
            $log('Последний запрос: ' . DB::getLastQuery(), true);
            throw $e;
        }
    }

    public function rebuildCaches(?callable $logger = null): void
    {
        $log = $logger ?? static function (string $msg, bool $isError = false): void {};

        $log('=== ПЕРЕСЧЁТ КЭШЕЙ КАТЕГОРИЙ ===');

        CategoryAssist::generateCountCache();
        (new CacheGen())->updateAll();

        $log('Кэши категорий пересчитаны');
    }
}
