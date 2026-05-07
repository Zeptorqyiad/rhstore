<?php

namespace App\Extensions\Catalog2\Helpers;

use Simflex\Core\Core;

class Format
{
    public static function stock(int $stock): string
    {
        $min = Core::siteParam('stock_min');
        $mid = Core::siteParam('stock_mid');
        $max = Core::siteParam('stock_max');

        if ($stock >= $max) {
            return 'Много';
        }

        if ($stock >= $mid) {
            return 'Мало';
        }

        if ($stock >= $min) {
            return 'Крайне мало';
        }

        return 'Нет в наличии';
    }

    public static function stockColor(int $stock): string
    {
        $mid = Core::siteParam('stock_mid');
        $max = Core::siteParam('stock_max');

        if ($stock >= $max) {
            return 'green';
        }

        if ($stock >= $mid) {
            return 'orange';
        }

        return 'red';
    }
}