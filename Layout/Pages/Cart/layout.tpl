<?php
App\Layout\Components\Common\RunningLine\Layout::draw(); ?>

<?php

$cart = \App\Extensions\Catalog\SessionAssist::$cart;
$products = array_map(fn($pi) => $pi['product']->brand_id, $cart->getProducts()['items']);

App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="cart">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'cart__breadcrumbs wrapper',
        'text' => 'Корзина'
    ]);
    ?>

    <?php
    if (!$products): ?>
        <?php
        App\Layout\Components\Other\CartEmpty\Layout::draw(); ?>
    <?php
    endif; ?>

    <?php
    if ($products): ?>
        <?php
        App\Layout\Components\Blocks\Cart\ViewCart\Layout::draw([
            'title' => 'Корзина',
            'class_name' => 'cart__view',
        ]); ?>

        <?php
        $brands = array_map(fn($pi) => $pi['product']->brand_id, $cart->getProducts()['items']);
        $brands = array_unique($brands);
        $brands = array_filter($brands, fn($bi) => !!$bi);

        if ($brands && ($list = \App\Extensions\Catalog2\Model\Product::find(
                'brand_id in (' . implode(',', $brands) . ')',
                'is_new desc',
                '20'
            ))) {
            App\Layout\Components\Common\ProductsSlider\Layout::draw([
                'class_name' => 'cart__products-slider',
                'title' => 'Для тех же брендов',
                'items' => $list,
            ]);
        } ?>
        <?php
        if ($list = $cart->getRelativeProducts()) {
            App\Layout\Components\Common\ProductsSlider\Layout::draw([
                'class_name' => 'cart__products-slider',
                'title' => 'Похожие товары',
                'items' => $list,
            ]);
        } ?>
        <?php
        if ($list = \App\Extensions\Catalog2\Model\Product::find(
            'is_new = 1',
            null,
            '15'
        )) {
            App\Layout\Components\Common\ProductsSlider\Layout::draw([
                'class_name' => 'cart__products-slider',
                'title' => 'Новинки',
                'items' => $list,
            ]);
        } ?>

        <div class="js--prices-min cart__bottom">
            <div class="cart__bottom-text">
                <span class="cart__bottom-description">Итого:</span>
                <span class="cart__bottom-result"><?= $cart->sum_actual ?> ₽</span>
            </div>
            <?php
            App\Layout\Components\Common\ButtonLinks\Layout::draw([
                'text' => 'Перейти к оформлению',
                'style' => 'primary',
                'class_name' => 'cart__bottom-button button-cart',
                'type' => 'submit',
//                'href' => '/user/order/'
                'href' => '/checkout/'
            ]); ?>
        </div>

    <?php endif; ?>
</main>

<?php
App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php
App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw([
    'active_nav' => '3'
]); ?>
