<?php
/** @var array $data */
/** @var \App\Extensions\Catalog2\Model\Price $price */
/** @var \App\Extensions\Catalog2\Model\Product $p */

use App\Extensions\Catalog2\Model\PriceLevel;

$p = $data['prod'];

$prices = $p->getPrices();
usort($prices, fn($a, $b) => $a->level->level_ord <=> $b->level->level_ord);

$curLevel = PriceLevel::getAuto();
$price = null;
foreach ($prices as $pr) {
    if ($pr->level->level_ord == $curLevel->level_ord) {
        $price = $pr;
        break;
    }
}
if (!$price) {
    $price = $prices[0] ?? null;
}
$other = array_values(array_filter($prices, fn($pr) => $pr !== $price));
$other = array_slice($other, 0, 2);
?>

<div class="<?= $data["class_name"] ?> purchase-card">
    <div class="purchase-card__top-line">
        <div class="purchase-card__price">
            <span class="purchase-card__discounted-price">
                <?= $price->hasPrice()
                    ? \Simflex\Core\Helpers\Str::price($price->getPrice())
                    : 'По уточнению'
                ?>
            </span>
            <?php if ($price->hasOldPrice()): ?>
                <span class="purchase-card__old-price">
                    <?= \Simflex\Core\Helpers\Str::price($price->getOldPrice()) ?>
                </span>
            <?php endif; ?>
        </div>
        <div class="purchase-card__badge purchase-card__badge_color-<?= $p->formatStockColor() ?>">
            <?= $p->formatStock() ?>
        </div>
    </div>
    <div class="purchase-card__line-box js--price">
        <div class="purchase-card__for-you">
            <span class="purchase-card__for-you-text">Для вас стоимость по прайсу: </span>

            <?php
            App\Layout\Components\Common\SaleInfo\Layout::draw([
                'text' => $price->level->name,
                'hint_text' => $price->level->desc,
                'secondary' => true,
                'class_name' => 'purchase-card__sale-info'
            ]); ?>
        </div>
        <div class="purchase-card__sale-info-text">
            <p>
                <?= $price->level->desc ?>
            </p>
        </div>
    </div>
    <?php
    $firstPass = false;
    /** @var \App\Extensions\Catalog2\Model\Price $otherPrice */
    foreach ($other as $otherPrice):
        if (!$otherPrice->hasPrice()) continue;
        ?>
        <div class="purchase-card__line-box<?= $firstPass ? '-2' : '' ?> js--price">
            <div class="purchase-card__price-list<?= $firstPass ? '-2' : '' ?>">
                <div class="purchase-card__price-list-box">
                    <span class="purchase-card__price-list-text">
                        Стоимость по прайсу:
                    </span>
                    <?php
                    App\Layout\Components\Common\SaleInfo\Layout::draw([
                        'text' => $otherPrice->level->name,
                        'secondary' => true,
                        'class_name' => 'purchase-card__sale-info',
                        'hint_text' => $otherPrice->level->desc
                    ]); ?>
                </div>
                <span class="purchase-card__price-list-price">
                    <?= \Simflex\Core\Helpers\Str::price($otherPrice->getPrice()) ?>
                </span>

            </div>
            <div class="purchase-card__sale-info-text">
                <p>
                    <?= $otherPrice->level->desc ?>
                </p>
            </div>
        </div>
        <?php
        $firstPass = true;
    endforeach; ?>

    <?php
    \App\Layout\Components\Common\Button\Layout::draw([
        'text' => 'Как купить дешевле?',
        'style' => 'gray',
        'class_name' => 'purchase-card__button-savings',
        'modal' => 'price-info',
    ]); ?>

    <div class="purchase-card__buttons-bottom" data-id="<?= $p->product_id ?>" data-variant="<?= $p->variantId ?>"
         data-qty="<?= $cnt = \App\Extensions\Catalog\SessionAssist::$cart->getProductQty(
             $p->product_id,
             $p->variantId
         ) ?>">
        <?php
        App\Layout\Components\Common\QuantityInput\Layout::draw([
            'val' => $cnt,
        ]); ?>

        <?php
        App\Layout\Components\Common\Button\Layout::draw([
            'text' => $cnt ? 'В корзине' : 'В корзину',
            'style' => 'primary',
            'class_name' => 'purchase-card__button-cart ' . ($cnt ? 'purchase-card__button-cart--active' : ''),
        ]); ?><?php
        ?>
    </div>
    <?php
    if ($p->bulk_amount): ?>
        <div class="purchase-card__add-info" data-conditions="<?= $p->bulk_amount ?>">
            <span>В упаковке <?= $p->bulk_amount ?> шт.</span>
        </div>
    <?php
    endif; ?>
</div>


