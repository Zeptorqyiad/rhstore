<?php

$pf = $this->makeFilter();
$f = $this->makeSpecialFilter();
if ($f && $pf[0]) {
    $pf[0] = $f . ' AND ' . $pf[0];
}

$index = $content->loadFrom('/');

App\Layout\Pages\Catalog\Layout::draw([
    'cat' => $this->cat,
    'fav' => $this->isFavorite,
    'f' => $pf,
    's' => $this->sort,
    'minp' => $this->min_price,
    'maxp' => $this->max_price,
    'is_search' => $this->isSearch,
    'hide_cats' => $this->isOlder,
    'th' => $this,

    'seo_title_1' => $this->cat->seo_title ?: $content['params']['catalog_seo_title'],
    'seo_text_1' => $this->cat->seo ?: $content['params']['catalog_seo_text'],
    'seo_title_2' => $this->cat->seo_title2 ?: $content['params']['catalog_seo_title-s'],
    'seo_text_2' => $this->cat->seo2 ?: $content['params']['catalog_seo_text-s'],

    'catalog_advantages_title' => $content['params']['catalog_advantages_title'],
    'why_us' => self::getTableFrom('why_us', $index),

    'onboarding_slides' => self::getTableFrom('onboarding_slides', $content),
]);