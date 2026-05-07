<?php
/** @var array $content */

$brands_cards = self::getTableFrom('brands_cards', $content);

$index = $content->loadFrom('/');
App\Layout\Pages\Brands\Layout::draw([
    'brands_title' => $content['params']['brands_title'],
    'brands_text' => $content['params']['brands_text'],

    'brands_cards' => $brands_cards,

    'brands_seo_title' => $content['params']['brands_seo_title'],
    'brands_seo_text' => $content['params']['brands_seo_text'],
    'brands_seo_title-s' => $content['params']['brands_seo_title-s'],
    'brands_seo_text-s' => $content['params']['brands_seo_text-s'],
]);