<?php
namespace App\Extensions\Catalog2;

use App\Extensions\Catalog\Model\Cart;
use App\Extensions\Catalog2\Model\Price;
use App\Extensions\Catalog2\Model\User;
use Simflex\Core\Container;
use Simflex\Core\DB;
use Simflex\Core\Log;

class PriceAssist
{
    public static function getPrice(int $productId, ?int $variantId): float
    {
        $user = Container::getUser();
        if ($user) {
            $level = Model\PriceLevel::getForUser($user);
        } else {
            $cart = Cart::getOrInsert();
            if (!$cart) {
                $level = Model\PriceLevel::getDefault();
            } else {
                $level = Model\PriceLevel::getForCart($cart);
            }
        }

        $price = Price::findOne([
            'product_id' => $productId,
            'variant_id' => $variantId ?: null,
            'level_id' => $level->level_id
        ]);

        if (!$price) {
            Log::warning('Unable to find price for product {productId}, variant {variantId}, level {level}', [
                'productId' => $productId,
                'variantId' => $variantId,
                'level' => $level->name
            ]);

            return DB::result('select price from catalog_product where product_id = ?', 0, [$productId]);
        }

        return $price->price;
    }
}