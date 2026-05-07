<?php

namespace App\Extensions\Catalog2\Model;

use App\Extensions\Catalog\Model\Product;
use App\Extensions\Catalog\Model\ProductVariant;
use Simflex\Core\DB;
use Simflex\Core\Log;

class Cart extends \App\Extensions\Catalog\Model\Cart
{
    public function rebuildData(bool $updateDelivery = false)
    {
        $curLevel = PriceLevel::getAuto();
        $prevLevel = $curLevel->getPrevLevel() ?? $curLevel;
        $nextLevel = $curLevel->getNextLevel();

        // calculate totals
        $totalPrev = 0;
        $totalCur = 0;
        $items = $this->getProducts()['items'];
        foreach ($items as $pi) {
            /** @var Product $prod */
            $prod = $pi['product'];
            $price = $prod->getPrice($prevLevel->level_id);
            $totalPrev += $price->getPrice() * $pi['qty'];
            $price = $prod->getPrice($curLevel->level_id);
            $totalCur += $price->getPrice() * $pi['qty'];
        }

//        Log::info('Price by prev: {prev}, cur: {cur}', ['prev' => $totalPrev, 'cur' => $totalCur]);

        $levelOrd = $curLevel->level_ord;
        $level = $curLevel;

        if (!$curLevel->is_by_total) {
            if ($totalPrev < $curLevel->min) {
                $levelOrd = $prevLevel->level_ord;
                $level = $prevLevel;
                Log::info('Prev less than cur level, switching to {level}', ['level' => $level->name]);

                $curLevel = $prevLevel;
                while ($prevLevel = $curLevel->getPrevLevel()) {
                    $totalPrev = 0;
                    foreach ($items as $pi) {
                        /** @var Product $prod */
                        $prod = $pi['product'];
                        $price = $prod->getPrice($prevLevel->level_id);
                        $totalPrev += $price->getPrice() * $pi['qty'];
                    }

                    if ($totalPrev < $curLevel->min) {
                        $levelOrd = $prevLevel->level_ord;
                        $level = $prevLevel;
                        $curLevel = $prevLevel;

                        Log::info('Prev less than prev level, switching to {level}', ['level' => $level->name]);
                    } else {
                        break;
                    }
                }
            } elseif ($nextLevel && $totalCur >= $nextLevel->min) {
                $levelOrd = $nextLevel->level_ord;
                $level = $nextLevel;
                Log::info('Cur more than next level, switching to {level}', ['level' => $level->name]);

                $curLevel = $nextLevel;
                while ($nextLevel = $curLevel->getNextLevel()) {
                    $totalCur = 0;
                    foreach ($items as $pi) {
                        /** @var Product $prod */
                        $prod = $pi['product'];
                        $price = $prod->getPrice($curLevel->level_id);
                        $totalCur += $price->getPrice() * $pi['qty'];
                    }

                    if ($totalCur > $nextLevel->min) {
                        $curLevel = $nextLevel;
                        $levelOrd = $nextLevel->level_ord;
                        $level = $nextLevel;
                        Log::info('Next more than next level, switching to {level}', ['level' => $level->name]);
                    } else {
                        break;
                    }
                }
            } elseif ($totalCur == $totalPrev && $totalCur == 0) {
                $level = PriceLevel::getDefault();
                $levelOrd = $level->level_ord;
                Log::info('Reset, switching to {level}', ['level' => $level->name]);
            }
        }

        foreach ($items as $pi) {
            /** @var Product $prod */
            $prod = $pi['product'];
            $price = $prod->getPrice($level->level_id);
            DB::query('update catalog_cart_product set sum_actual = ?, sum_total = ? where cart_product_id = ?', [
                $price->getPrice() * $pi['qty'],
                $price->getOldPrice() * $pi['qty'],
                $pi['id']
            ]);
        }

        $this->update([
            'level' => $levelOrd
        ]);
        parent::rebuildData($updateDelivery);
    }

    public function hasAnyUnavailable(): bool
    {
        foreach ($this->getProducts()['items'] as $p) {
            if (!$p['product']->is_active) {
                return true;
            }
        }

        return false;
    }

    public function getProduct(int $id)
    {
        $q = DB::query('select * from catalog_cart_product where cart_id = ? and product_id = ?', [$this->cart_id, $id]
        );
        return DB::fetch($q);
    }

    public function addOrUpdateProduct(
        int $id,
        int $variantId,
        int $qty,
        bool $ignoreStock = false,
        bool $clampAmount = false
    ): bool {
        $prod = new Product($id);
        if (!$prod->product_id) {
            // oh, no! we don't have a product!
            Log::error('Product {id} not found or out of stock', ['id' => $id]);
            return false;
        }

        // check var stock
        if ($variantId) {
            $var = new ProductVariant($variantId);
            $prod->price = $var->price;
            $prod->price_old = $var->price_old;
        }

        $q = DB::query(
            'select cart_product_id from catalog_cart_product where cart_id = ? and product_id = ? and variant_id = ?',
            [$this->cart_id, $id, $variantId]
        );
        $r = DB::fetch($q);

        $total = (!$prod->__price_old || $prod->__price_old == $prod->__price || $prod->__price_old < $prod->__price) ? $prod->__price : $prod->__price_old;
        Log::info('Total price for product {id} is {total}', ['id' => $id, 'total' => $total]);

        if (!$r) {
            DB::query(
                'insert into catalog_cart_product (cart_id, product_id, sum_total, sum_actual, qty, variant_id) values (?, ?, ?, ?, ?, ?)',
                [
                    $this->cart_id,
                    $id,
                    (float)($total) * $qty,
                    $prod->__price * $qty,
                    $qty,
                    $variantId
                ]
            );
        } else {
            DB::query(
                'update catalog_cart_product set sum_total = ?, sum_actual = ?, qty = ? where cart_id = ? and product_id = ? and variant_id = ?',
                [
                    (float)($total) * $qty,
                    $prod->__price * $qty,
                    $qty,
                    $this->cart_id,
                    $id,
                    $variantId
                ]
            );
        }

        $this->rebuildData();
        return true;
    }
}