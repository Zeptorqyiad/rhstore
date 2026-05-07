<?php
namespace App\Extensions\Onec\Import;

use Simflex\Core\DB;

class CatalogStock
{
    public function import(array $stocks, ?callable $logger = null): void
    {
        $log = $logger ?? static function (string $msg, bool $isError = false): void {};

        $created = 0;
        $updated = 0;
        $skipped = 0;

        DB::transactionStart();
        try {
            foreach ($stocks as $stock) {
                $extId = trim($stock['ID'] ?? '');
                $inStock = (int)($stock['in_stock'] ?? 0);
                $inOrder = (int)($stock['on_the_way'] ?? 0);
                $isActive = 1;

                if ($extId === '') {
                    $skipped++;
                    continue;
                }

                $res = DB::query(
                    'SELECT product_id FROM catalog_product WHERE external_id = ? LIMIT 1',
                    [$extId]
                );
                $product = DB::fetch($res);
                $productId = $product ? (int)$product['product_id'] : null;
                if (!$productId) {
                    $skipped++;
                    $log("Пропуск: нет product_id для external_id {$extId}", true);
                    continue;
                }

                $res = DB::query(
                    'SELECT stock_id FROM catalog_stock WHERE external_id = ? LIMIT 1',
                    [$extId]
                );
                $exists = DB::fetch($res);

                if ($exists) {
                    $ok = DB::query(
                        'UPDATE catalog_stock SET product_id = ?, available = ?, in_orders = ? WHERE stock_id = ?',
                        [$productId, $inStock, $inOrder, $exists['stock_id']]
                    );
                    if ($ok) {
                        $updated++;
                    } else {
                        $skipped++;
                        $log('Ошибка UPDATE: ' . DB::errno() . ' ' . DB::error(), true);
                    }
                } else {
                    $ok = DB::query(
                        'INSERT INTO catalog_stock (product_id, is_active, available, in_orders, external_id) VALUES (?, ?, ?, ?, ?)',
                        [$productId, $isActive, $inStock, $inOrder, $extId]
                    );
                    if ($ok) {
                        $created++;
                    } else {
                        $skipped++;
                        $log('Ошибка INSERT: ' . DB::errno() . ' ' . DB::error(), true);
                    }
                }
            }

            DB::transactionCommit();

            $log("Создано: $created | Обновлено: $updated | Пропущено: $skipped");
            $log('Импорт успешно завершён!');
        } catch (\Throwable $e) {
            DB::transactionRollback();
            $log('ОШИБКА: ' . $e->getMessage(), true);
            $log('Последний запрос: ' . DB::getLastQuery(), true);
            throw $e;
        }
    }
}
