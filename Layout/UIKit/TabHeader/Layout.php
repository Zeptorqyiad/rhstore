<?php

namespace App\Layout\UIKit\TabHeader;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function out(string $text, string $iconRight, string $viewBox = '0 0 16 16', string $className = '')
    {
        self::draw(compact($text, $iconRight, $viewBox, $className));
    }
}