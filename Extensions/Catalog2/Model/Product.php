<?php

namespace App\Extensions\Catalog2\Model;

use App\Extensions\Catalog\SessionAssist;
use App\Extensions\Catalog2\Helpers\Format;
use Simflex\Core\Buffer;
use Simflex\Core\Container;
use Simflex\Core\DB;

class Product extends \App\Extensions\Catalog\Model\Product
{
    public function formatStock(): string
    {
        $stock = $this->stockData;
        return Format::stock($stock ? $stock->getAvailable() : 0);
    }

    public function formatStockColor(): string
    {
        $stock = $this->stockData;
        return Format::stockColor($stock ? $stock->getAvailable() : 0);
    }

    public static function find($where, $orderBy = null, $limit = null, $assocKey = false)
    {
        return Buffer::getOrSet(
            'prod.find.' . md5((string)print_r($where, true) . '.' . (string)$orderBy . '.' . (string)$limit),
            fn() => parent::find($where, $orderBy, $limit, $assocKey)
        );
    }

    public function getPrice(int $level = 0): Price
    {
        return Buffer::getOrSet('prod.level.' . $this->product_id . '.' . $level, function () use ($level) {
            if (!$level) {
                $level = PriceLevel::getAuto()->level_id;
            }

            $price = Price::findOne(
                ['level_id' => $level, 'product_id' => $this->id, 'variant_id' => $this->variantId ?: null]
            );
            if (!$price) {
                $price = Price::findOne(['product_id' => $this->id, 'variant_id' => $this->variantId ?: null]);
            }

            return $price;
        });
    }

    public function getImages()
    {
        $imgs = parent::getImages();
        if (str_contains($imgs[0], 'default-img')) {
            $cat = $this->getFirstCategory();
            if (!$cat || !$cat->photo) {
                return $imgs;
            }

            return ['/uf/images/source/' . $cat->photo];
        }

        return $imgs;
    }

    public function getPrices(int $fromLevel = 0): array
    {
        return Buffer::getOrSet(
            'prices.' . $this->product_id . '.' . $this->variantId . '.' . $fromLevel,
            function () use ($fromLevel) {
                $q = Price::findAdv()->where(['product_id' => $this->id, 'variant_id' => $this->variantId ?: null]);
                if ($fromLevel > 0) {
                    $q->leftJoin('catalog_price_level', 'level_id')
                        ->andWhere('catalog_price_level.level_ord >= ?')->bind([$fromLevel])->orderBy('level_ord');
                }

                return $q->all();
            }
        );
    }
}
