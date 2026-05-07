<?php

/** @var \App\Extensions\Catalog2\Model\Product $prod */
$prod = $data['prod'];

App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php
\App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="product"
      data-id="<?= $prod->product_id ?>"
      data-variant="<?= $prod->variantId ?>"
      data-prod="<?= $prod->getPPReadyInfo() ?>">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw(['class_name' => 'wrapper']); ?>
    <div class="product__top">
        <div class="product__top-container wrapper">
            <h2 class="product__top-title"><?= $prod->name ?></h2>

<!--            <div class="product__top-favorites-wrap">-->
<!--                --><?php
//                App\Layout\Components\Common\Favorites\Layout::draw([
//                    'text' => $prod->inFav() ? 'В избранном' : 'В избранное',
//                    'class_name' => 'product__top-favorites ' . ($prod->inFav() ? ' favorites_active' : ''),
//                    'id' => $prod->product_id,
//                    'variant' => $prod->variantId
//                ]); ?>
<!--            </div>-->
        </div>
    </div>

    <?php
    \App\Layout\Components\Blocks\Product\ViewProduct\Layout::draw([
        'class_name' => 'product__view',
        'prod' => $prod,
        'delivery' => $data['delivery'],
        'delivery_block' => $data['delivery_block']
    ]);

    App\Layout\Components\Common\Advantages\Layout::draw([
        'class_name' => 'product__advantages',
        'title' => $data['prod_advantages_title'],
        'advantages_title' => $data['prod_advantages_title'],
        'advantages' => $data['why_us']
    ]);
    ?>
    <section class="product__brand-banner">
        <?php
        $cat = $prod->getFirstCategory();
        if ($cat->banner_enable) {
            $banner = $cat->accumulateBanners()[0];
            App\Layout\Components\Common\BrandBanner\Layout::draw([
                'class_name' => 'wrapper',
                'text' => $banner['text'],
                'button_text' => $banner['btn_text'],
                'button_url' => $banner['btn_link'],
                'img' => $banner['img']
            ]);
        }
        ?>
    </section>

    <?php
    /** @var \App\Extensions\Catalog\Model\Category $cat */
    $cat = $prod->getFirstCategory();
    if ($list = $cat->getProducts('15', '', ['t.product_id <> ' . $prod->product_id])) {
        App\Layout\Components\Common\ProductsSlider\Layout::draw([
            'title' => 'Товары из категории ' . $prod->getFirstCategory()->name,
            'class_name' => 'product__slider',
            'items' => $list,
        ]);
    }

    if ($prod->brand_id && ($list = \App\Extensions\Catalog2\Model\Product::find(
            'brand_id = ' . $prod->brand_id . ' and product_id <> ' . $prod->product_id,
            null,
            '15'
        ))) {
        App\Layout\Components\Common\ProductsSlider\Layout::draw([
            'title' => 'Для тех же брендов',
            'class_name' => 'product__slider',
            'items' => $list
        ]);
    }

    if ($list = \App\Extensions\Catalog2\Model\Product::find(
        'is_new = 1 and product_id <> ' . $prod->product_id,
        null,
        '15'
    )) {
        App\Layout\Components\Common\ProductsSlider\Layout::draw([
            'title' => 'Новинки',
            'items' => $list,
        ]);
    }
    ?>

    <?php
    App\Layout\Components\Common\MailingList\Layout::draw([
        'class_name' => 'product__mailing'
    ]);

    ?>

    <div class="product__purchase-bottom" data-id="<?= $prod->product_id ?>" data-variant="<?= $prod->variantId ?>"
         data-qty="<?= $cnt = \App\Extensions\Catalog\SessionAssist::$cart->getProductQty(
             $prod->product_id,
             $prod->variantId
         ) ?>">
        <div class="product__purchase-buttons">
            <?php
            App\Layout\Components\Common\QuantityInput\Layout::draw([
                'class_name' => 'purchase-card__input',
                'val' => $cnt,
            ]); ?>

            <?php
            App\Layout\Components\Common\Button\Layout::draw([
                'text' => $cnt ? 'В корзине' : 'В корзину',
                'style' => 'primary',
                'class_name' => 'purchase-card__button-cart ' . ($cnt ? 'purchase-card__button-cart--active' : ''),
            ]); ?>
        </div>

        <?php
        if ($prod->bulk_amount): ?>
            <div class="product__purchase-min">
                <span>Минимальный заказ от <span data-min-order="0"><?= $prod->bulk_amount ?></span> шт.</span>
            </div>
        <?php
        endif; ?>
    </div>

</main>

<?php
App\Layout\Components\Common\Footer\Layout::draw(['prod' => $data['prod']]); ?>
<?php
App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
<?php
App\Layout\Components\Modals\ModalPropertyDelivery\Layout::draw([
    'delivery' => $data['delivery_block'],
    'payment' => $data['payment'],
]); ?>
<?php
App\Layout\Components\Modals\ModalPropertyInfo\Layout::draw(['prod' => $data['prod']]); ?>
