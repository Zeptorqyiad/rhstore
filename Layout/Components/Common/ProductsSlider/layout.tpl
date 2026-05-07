<?php

/** @var array $data */
$items = $data['items'] ?? [];
?>

<section class="<?= $data["class_name"] ?> products-slider">
    <div class="products-slider__container wrapper">

        <h2 class="products-slider__title"><?= $data['title'] ?></h2>

        <?php
        App\Layout\Components\Common\SliderButtons\Layout::draw([
            'class_name' => 'products-slider__buttons',
            'prev_class_name' => 'products-slider__button-prev',
            'next_class_name' => 'products-slider__button-next',
            'secondary' => true
        ]); ?>

        <div class="products-slider__slider">
            <div class="swiper-wrapper">
                <?php
                /** @var \App\Extensions\Catalog2\Model\Product $prod */
                foreach ($items as $prod): ?>
                    <div class="swiper-slide">
                        <?php
                        $price = $prod->getPrice();
                        App\Layout\Components\Common\ProductCard\Layout::draw([
                            'href' => '/' . $prod->path . '/',
                            'image' => $prod->getPrimaryImage(),
                            'id' => $prod->product_id,
                            'variant' => $prod->variantId,
                            'title' => $prod->name,
                            'article' => $prod->sku,
                            'conditions' => $prod->bulk_amount,
                            'bulk_desc' => \Simflex\Core\Core::siteParam(
                                'bulk_desc',
                                null,
                                ['amount' => $prod->bulk_amount]
                            ),
                            'discounted_price' => $price->getPrice(),
                            'old_price' => $price->getOldPrice(),
                            'level' => $price->level->name,
                            'level_desc' => $price->level->desc,
                            'stock' => $prod->formatStock(),
                            'stock_color' => $prod->formatStockColor(),
                            'prices' => array_map(fn($p) => [
                                'has_discount' => $p->hasOldPrice(),
                                'has_price' => $p->hasPrice(),
                                'price' => \Simflex\Core\Helpers\Str::price($p->getPrice()),
                                'old_price' => \Simflex\Core\Helpers\Str::price($p->getOldPrice()),
                                'level' => $p->level->level_ord,
                            ], array_reverse($prod->getPrices())),
                            'new' => $prod->is_new,
                            'popular' => $prod->is_popular,
                            'discount' => $prod->getDiscountPercent(),
                            'fav' => $prod->inFav(),
                            'cartc' => \App\Extensions\Catalog\SessionAssist::$cart->getProductQty(
                                $prod->product_id,
                                $prod->variantId
                            ),
                            'class_name' => 'product-card__mobile-cart'
                        ]); ?>

                    </div>

                <?php
                endforeach; ?>
            </div>
        </div>
    </div>
</section>