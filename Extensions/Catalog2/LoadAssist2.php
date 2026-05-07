<?php

namespace App\Extensions\Catalog2;

use Simflex\Core\DB;

class LoadAssist2
{
    public static array $levels = [];

    public static function load()
    {
        static::$levels = DB::arr('select * from catalog_price_level', 'level_id');
    }
}