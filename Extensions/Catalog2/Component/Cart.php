<?php

namespace App\Extensions\Catalog2\Component;

use App\Extensions\Catalog2\Model\PriceLevel;
use Simflex\Core\Core;
use Simflex\Core\Helpers\Str;

class Cart extends \App\Extensions\Catalog\Component\Cart
{
    protected function getCartInfo()
    {
        $this->cart->rebuildData();
        $data = parent::getCartInfo();

        $data['items'] = [];
        foreach ($this->cart->getProducts()['items'] as $pi) {
            $prod = $pi['product'];
            $data['items'][$prod->product_id . '.' . $pi['variant_id']] = Str::price($pi['sum_actual']);
        }

        $data['info']['sum'] = Str::price(is_null($this->cart->__sum_actual) ? 0 : $this->cart->__sum_actual);
        $data['info']['sum_total'] = Str::price(is_null($this->cart->__sum_total) ? 0 : $this->cart->__sum_total);
        $data['info']['discount'] = Str::price($this->cart->getDiscountNum() ?? 0);

        $level = PriceLevel::getAuto();
        $nextLevel = $level->getNextLevel();

        $data['info']['level'] = $level->level_ord;
        $data['level']['cur'] = $level->name;
        $data['level']['cur_text'] = $level->desc;

        if ($nextLevel) {
            $data['level']['till_next'] = Str::price(max($nextLevel->min - $this->cart->__sum_actual, 0));
            $data['level']['next'] = $nextLevel->name;
            $data['level']['next_text'] = $nextLevel->desc;
            $data['level']['is_personal'] = $nextLevel->is_by_total;
        }

        $data['min'] = $this->cart->__sum_actual < \Simflex\Core\Core::siteParam('min_order');
        $data['min_left'] = Str::price(\Simflex\Core\Core::siteParam('min_order') - $this->cart->__sum_actual);

        $data['max'] = $this->cart->__sum_actual > Core::siteParam('max_order');

        return $data;
    }
}