<?php
/** @var array $data */

$cart = \App\Extensions\Catalog\SessionAssist::$cart;
$pag = (int)($_REQUEST['page'] ?? 0);
$count = $cart->getProductCount();
?>

<div class="<?= $data["class_name"] ?> view-cart">
    <div class="wrapper">
        <div class="view-cart__top">
            <h1 class="view-cart__title">
                <?= $data["title"] ?>
            </h1>
            <div class="view-cart__top-line">
                <?php
                if ($cart->hasAnyUnavailable()): ?>
                    <button type="button" class="view-cart__top-button">
                        Удалить неактивные товары
                    </button>
                <?php
                endif; ?>
                <form>
                    <?php
                    App\Layout\Components\Common\Dropdown\Layout::draw([
                        'placeholder' => 'Сортировать',
                        'class_name' => 'view-cart__dropdown',
                        'name' => 'sort',
                        'items' => [
                            'pmin' => 'Сначала дешевле',
                            'pmax' => 'Сначала дороже',
                            'aup' => 'По алфавиту: А — Я',
                            'adown' => 'По алфавиту: Я — А',
                        ]
                    ]); ?>
                </form>
            </div>
        </div>
        <div class="view-cart__box">
            <div class="view-cart__box-left">
                <?php App\Layout\UIKit\PreloaderPulse\Layout::draw(); ?>

                <?php
                App\Layout\Components\Blocks\Catalog\CatalogHeadlines\Layout::draw([
                    'class_name' => 'view-cart__headlines',
                    'cart' => true,
                ]); ?>
                <ul class="view-cart__cards">
                    <?php
                    $sort = '';
                    switch ($_REQUEST['sort'] ?? '') {
                        default:
                            break;
                        case 'pmin':
                            $sort = 'sum_actual';
                            break;
                        case 'pmax':
                            $sort = 'sum_actual desc';
                            break;
                        case 'aup':
                            $sort = 'catalog_product.name';
                            break;
                        case 'adown':
                            $sort = 'catalog_product.name desc';
                            break;
                    }

                    $ci = $cart->getProducts('20 offset ' . $pag, $sort)['items'];
                    foreach ($ci as $pi):
                        /** @var \App\Extensions\Catalog2\Model\Product $p */
                        $prod = $pi['product'];
                        ?>
                        <li class="view-cart__card">
                            <?php
                            App\Layout\Components\Blocks\Catalog\CatalogCard\Layout::draw([
                                'href' => '/' . $prod->path . '/',
                                'image' => $prod->getPrimaryImage(),
                                'title' => $prod->name,
                                'article' => $prod->sku,
                                'conditions' => $prod->bulk_amount,
                                'bulk_desc' => \Simflex\Core\Core::siteParam(
                                    'bulk_desc',
                                    null,
                                    ['amount' => $prod->bulk_amount]
                                ),
                                'new' => $prod->is_new,
                                'popular' => $prod->is_popular,
                                'discount' => $prod->getDiscountPercent(),
                                'stock' => $prod->formatStock(),
                                'stock_color' => $prod->formatStockColor(),
                                'prices' => array_map(fn($p) => [
                                    'has_discount' => $p->hasOldPrice(),
                                    'has_price' => $p->hasPrice(),
                                    'price' => \Simflex\Core\Helpers\Str::price($p->getPrice()),
                                    'old_price' => \Simflex\Core\Helpers\Str::price($p->getOldPrice()),
                                    'level' => $p->level->level_ord,
                                ], array_reverse($prod->getPrices())),
                                'class_name' => '',
                                'id' => $prod->product_id,
                                'variant' => $pi['variant_id'],
                                'fav' => $prod->inFav(),
                                'cartc' => $pi['qty'],
                                'cart' => true,
                            ]);
                            ?>
                        </li>
                    <?php
                    endforeach; ?>
                </ul>
                <ul class="view-cart__mobile-cards">
                    <?php
                    foreach ($ci as $pi): ?>
                        <?php
                        /** @var \App\Extensions\Catalog2\Model\Product $prod */
                        $prod = $pi['product'];
                        $price = $prod->getPrice();
                        App\Layout\Components\Common\ProductCard\Layout::draw([
                            'href' => '/' . $prod->path . '/',
                            'image' => $prod->getPrimaryImage(),
                            'id' => $prod->product_id,
                            'variant' => $pi['variant_id'],
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
                            'new' => $prod->is_new,
                            'popular' => $prod->is_popular,
                            'discount' => $prod->getDiscountPercent(),
                            'fav' => $prod->inFav(),
                            'cartc' => $pi['qty'],
                            'horizontal' => true,
                            'class_name' => 'view-cart__product-card'
                        ]);
                        ?>
                    <?php
                    endforeach; ?>
                </ul>
                <?php
                App\Layout\UIKit\Pagination\Layout::draw([
                    'link' => '/cart/',
                    'page' => $pag,
                    'hasPrev' => !!$pag,
                    'pages' => $count / 20,
                    'hasNext' => $pag < ($count / 20) - 2,
                    'className' => 'cart-pagination'
                ]); ?>
            </div>
            <div class="view-cart__box-right">
                <?php
                App\Layout\Components\Blocks\Cart\CartPurchaseCard\Layout::draw([
                    'class_name' => 'view-cart__purchase-card'
                ]); ?>
            </div>
        </div>
    </div>
</div>