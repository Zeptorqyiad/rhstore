<?php

namespace App\Extensions\Catalog2\Model;

use App\Extensions\Catalog\Model\Product;
use App\Extensions\Catalog\Model\ProductVariant;
use App\Extensions\Catalog\Price\PriceManager;
use Simflex\Core\Buffer;
use Simflex\Core\Container;
use Simflex\Core\ModelBase;

/**
 * @property int price_id
 * @property int product_id
 * @property int variant_id
 * @property int level_id
 * @property double price
 *
 * @property Product product
 * @property PriceLevel level
 * @property ProductVariant|null variant
 */
class Price extends ModelBase
{
    protected static $table = 'catalog_price';
    protected static $primaryKeyName = 'price_id';

    public function offsetGetProduct(): Product
    {
        return Product::findOne(['product_id' => $this->product_id]);
    }

    public function offsetGetLevel(): PriceLevel
    {
        return Buffer::getOrSet(
            'price.level.' . $this->level_id,
            fn() => PriceLevel::findOne(['level_id' => $this->level_id])
        );
    }

    public static function find($where, $orderBy = null, $limit = null, $assocKey = false)
    {
        return Buffer::getOrSet(
            'price.find.' . print_r($where, true),
            fn() => parent::find($where, $orderBy, $limit, $assocKey)
        );
    }

    public static function findOne($where, $returnModelIfNotFound = false)
    {
        return Buffer::getOrSet(
            'price.findone.' . print_r($where, true),
            fn() => parent::findOne($where, $returnModelIfNotFound)
        );
    }

    public function offsetGetVariant(): ?ProductVariant
    {
        return ProductVariant::findOne(['variant_id' => $this->variant_id]);
    }

    public function getPrice(): float
    {
        /** @var PriceManager $pm */
        $pm = Container::getPrice();
        return $pm->getPrice($this->product_id, $this->variant_id, $this->price);
    }

    public function getOldPrice(): float
    {
        /** @var PriceManager $pm */
        $pm = Container::getPrice();
        return $pm->getOldPrice($this->product_id, $this->variant_id, $this->price);
    }

    public function hasOldPrice(): bool
    {
        return $this->getPrice() != $this->getOldPrice();
    }

    public function hasPrice(): bool
    {
        return $this->getPrice() != '0.00';
    }
}