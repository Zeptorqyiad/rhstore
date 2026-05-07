<?php
namespace App\Extensions\Catalog2\Admin;

use App\Extensions\Catalog\Model\Product as ProductModel;
use App\Extensions\Catalog2\Model\Price;

class Product extends \App\Extensions\Catalog\Admin\Product
{
    protected function afterCopyItem(ProductModel $old, ProductModel $new)
    {
        foreach (Price::find(['product_id' => $old->product_id, 'variant_id' => null]) as $p) {
            $pr = new Price();
            $pr->product_id = $new->product_id;
            $pr->variant_id = null;
            $pr->level_id = $p->level_id;
            $pr->price = $p->price;
            $pr->save();
        }

        foreach ($this->varToId as $v => $i) {
            foreach (Price::find(['product_id' => $old->product_id, 'variant_id' => $v]) as $p) {
                $pr = new Price();
                $pr->product_id = $new->product_id;
                $pr->variant_id = $i;
                $pr->level_id = $p->level_id;
                $pr->price = $p->price;
                $pr->save();
            }
        }
    }
}