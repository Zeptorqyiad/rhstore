<?php

/** @var array $data */
$prod = $data['prod'];
?>

<section class="<?= $data["class_name"] ?> view-product">
    <div class="view-product__container wrapper">
        <?php
        \App\Layout\Components\Blocks\Product\ProductSlider\Layout::draw([
            'class_name' => 'view-product__slider',
            'prod' => $prod,
            'slides' => array_map(fn($i) => ['image' => $i], $prod->getImages()),
        ]);

        \App\Layout\Components\Blocks\Product\AboutProduct\Layout::draw([
            'class_name' => 'view-product__about-product',
            'prod' => $prod,
            'delivery' => $data['delivery'],
        ]);

        \App\Layout\Components\Blocks\Product\InfoTabs\Layout::draw([
            'class_name' => 'view-product__tabs',
            'prod' => $prod,
            'delivery' => $data['delivery_block'],
        ]);

        ?>
        <div class="view-product__card">
            <?php
            \App\Layout\Components\Blocks\Product\PurchaseCard\Layout::draw([
                'class_name' => 'view-product__purchase-card',
                'prod' => $prod,
            ]); ?>
        </div>
    </div>
</section>