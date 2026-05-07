<?php
namespace App\Extensions\Onec\Import;

use Simflex\Core\DB;

class PriceLevels
{
    public function import(array $levels, ?callable $logger = null): void
    {
        $log = $logger ?? static function (string $msg, bool $isError = false): void {};

        $created = 0;
        $updated = 0;
        $skipped = 0;

        DB::transactionStart();
        try {
            foreach ($levels as $lvl) {
                $extId = trim($lvl['ID'] ?? '');
                $name = (string)($lvl['name'] ?? '');
                $min = (int)($lvl['min'] ?? 0);
                $level = ((int)($lvl['level'] ?? 0)) - 1;
                if ($level < 0) {
                    $level = 0;
                }
                $isByTotal = 0;

                if ($extId === '') {
                    $skipped++;
                    continue;
                }

                $res = DB::query(
                    'SELECT level_id FROM catalog_price_level WHERE external_id = ? LIMIT 1',
                    [$extId]
                );
                $exists = DB::fetch($res);

                if ($exists) {
                    $ok = DB::query(
                        'UPDATE catalog_price_level SET name = ?, min = ?, is_by_total = ?, level_ord = ? WHERE level_id = ?',
                        [$name, $min, $isByTotal, $level, $exists['level_id']]
                    );
                    if ($ok) {
                        $updated++;
                    } else {
                        $skipped++;
                        $log('Ошибка UPDATE: ' . DB::errno() . ' ' . DB::error(), true);
                    }
                } else {
                    $ok = DB::query(
                        'INSERT INTO catalog_price_level (name, min, is_by_total, level_ord, external_id) VALUES (?, ?, 0, ?, ?)',
                        [$name, $min, $isByTotal, $level, $extId]
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
            $log('Импорт уровней цен успешно завершён!');
        } catch (\Throwable $e) {
            DB::transactionRollback();
            $log('ОШИБКА: ' .  $e->getMessage(), true);
            $log('Последний запрос: ' . DB::getLastQuery(), true);
            throw $e;
        }
    }
}
