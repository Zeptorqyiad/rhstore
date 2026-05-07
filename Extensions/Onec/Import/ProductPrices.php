<?php

namespace App\Extensions\Onec\Import;

use Simflex\Core\DB;

class ProductPrices
{
    private function getDefaultLevelId(): ?int
    {
        $res = DB::query(
            'SELECT level_id FROM catalog_price_level ORDER BY level_ord ASC, level_id ASC LIMIT 1'
        );
        $row = DB::fetch($res);
        return $row ? (int)$row['level_id'] : null;
    }

    public function import(array $prices, ?callable $logger = null): void
    {
        $log = $logger ?? static function (string $msg, bool $isError = false): void {};

        $created = 0;
        $updated = 0;
        $skipped = 0;
        $missingLevelId = 0;
        $unknownLevelId = 0;
        $unknownLevelIds = [];

        $defaultLevelId = $this->getDefaultLevelId();
        if (!$defaultLevelId) {
            $log('Не найден уровень цен (catalog_price_level). Импорт цен невозможен.', true);
            throw new \RuntimeException('catalog_price_level is empty');
        }

        DB::transactionStart();
        try {
            foreach ($prices as $price) {
                $productExtId = trim($price['ProductID'] ?? '');
                $levelExtId = trim($price['PriceLevelsID'] ?? '');
                $jsonPrice = (float)($price['Price'] ?? 0);

                if ($productExtId === '') {
                    $skipped++;
                    continue;
                }

                $res = DB::query(
                    'SELECT product_id FROM catalog_product WHERE external_id = ? LIMIT 1',
                    [$productExtId]
                );
                $product = DB::fetch($res);
                $productId = $product ? (int)$product['product_id'] : null;

                if (!$productId) {
                    $skipped++;
                    $log("Пропуск: нет product_id для external_id {$productExtId}", true);
                    continue;
                }

                $levelId = null;
                if ($levelExtId !== '') {
                    $resLevel = DB::query(
                        'SELECT level_id FROM catalog_price_level WHERE external_id = ? LIMIT 1',
                        [$levelExtId]
                    );
                    $levelRow = DB::fetch($resLevel);
                    if ($levelRow) {
                        $levelId = (int)$levelRow['level_id'];
                    }
                }

                if ($levelExtId === '') {
                    $missingLevelId++;
                    $levelId = $defaultLevelId;
                } elseif ($levelId === null) {
                    $unknownLevelId++;
                    $unknownLevelIds[$levelExtId] = true;
                    $skipped++;
                    continue;
                }

                $result = DB::query(
                    'SELECT price_id FROM catalog_price WHERE product_id = ? AND level_id = ? LIMIT 1',
                    [$productId, $levelId]
                );
                $exists = DB::fetch($result);

                if ($exists) {
                    $ok = DB::query(
                        'UPDATE catalog_price SET price = ?, external_id = ? WHERE price_id = ?',
                        [$jsonPrice, $productExtId, $exists['price_id']]
                    );
                    $ok ? $updated++ : $skipped++;
                } else {
                    $ok = DB::query(
                        'INSERT INTO catalog_price (product_id, level_id, price, external_id) 
                         VALUES (?, ?, ?, ?)',
                        [$productId, $levelId, $jsonPrice, $productExtId]
                    );
                    $ok ? $created++ : $skipped++;
                }

                if ($levelId === $defaultLevelId) {
                    DB::query(
                        'UPDATE catalog_product SET price = ? WHERE product_id = ?',
                        [$jsonPrice, $productId]
                    );
                }
            }

            DB::transactionCommit();

            $log("Создано: $created | Обновлено: $updated | Пропущено: $skipped");
            if ($missingLevelId > 0) {
                $log("Без PriceLevelsID (использован уровень по умолчанию): $missingLevelId", true);
            }
            if ($unknownLevelId > 0) {
                $list = implode(', ', array_keys($unknownLevelIds));
                $log("Неизвестные PriceLevelsID (пропущено): $unknownLevelId", true);
                $log("Список неизвестных PriceLevelsID: $list", true);
            }
            $log('Импорт цен успешно завершён!');
        } catch (\Throwable $e) {
            DB::transactionRollback();
            $log('ОШИБКА: ' . $e->getMessage(), true);
            $log('Последний запрос: ' . DB::getLastQuery(), true);
            throw $e;
        }
    }
}
