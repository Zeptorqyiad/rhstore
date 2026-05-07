<?php
namespace App\Extensions\Catalog2\Price;

use App\Extensions\Catalog\Price\PriceProxy;
use App\Extensions\Catalog2\PriceAssist;
use Simflex\Core\Log;

class MultiPriceProxy extends PriceProxy
{
    /*
     * price logic:
     * 1, 2, 3 available instantly
     * all of these 3 work for the current cart
     * e.g.
     * 1 = 0 rub
     * 2 = 1000 rub
     * 3 = 2000 rub
     * then, if cart meets 1000, 2 will be used and so on
     * 4, 5, 6 are available only after certain amount of money is spent
     * e.g.
     * 4 = 3000 rub
     * 5 = 4000 rub
     * 6 = 5000 rub
     * when total spent is over 3000, ONLY 4 will be used
     * 1, 2, and 3 will not be available
     * 5, 6 will follow the same logic
     */

    public function proxy(int $productId, ?int $variantId, float $in): float
    {
        if ($in) {
            return $in;
        }

        return PriceAssist::getPrice($productId, $variantId);
    }
}