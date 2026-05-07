<?php
/** @var array $data */

/** @var \App\Extensions\Catalog\Model\Category $cat */
$cat = $data['cat'];
$pag = $_REQUEST['page'] ?? 0;
$pag = (int)$pag;
$count = $cat->getProductCount($data['f']);
?>

<section class="<?= $data["class_name"] ?> catalog-box">
    <div class="wrapper">
        <h1 class="catalog-box__title">
            <?= $data["title"] ?>
            <span class="catalog-box__title-quantity"><?= \Simflex\Core\Helpers\Str::pluralize(
                    $count,
                    'товар'
                ) ?></span>
        </h1>

        <?php if ($count == 0): ?>
            <?php App\Layout\Components\Other\SearchNotFound\Layout::draw(); ?>
        <?php endif; ?>

        <?php
        if ($count !== 0): ?>
            <div class="catalog-box__grid">
                <?php
                App\Layout\Components\Blocks\Catalog\CatalogFilters\Layout::draw([
                    'class_name' => 'catalog-box__filters',
                    'cat' => $cat,
                    'fav' => $data['fav'],
                    'minp' => $data['minp'],
                    'maxp' => $data['maxp'],
                    'is_search' => $data['is_search'],
                    'hide_cats' => $data['hide_cats'],
                    'th' => $data['th'],
                ]); ?>
                <div class="catalog-box__view">
                    <div class="catalog-box__view-top">
                        <?php
                        if ($cat->banner_enable) {
                            $banner = $cat->accumulateBanners()[0];
                            App\Layout\Components\Common\BrandBanner\Layout::draw([
                                'text' => $banner['text'],
                                'button_text' => $banner['btn_text'],
                                'button_link' => $banner['btn_link'],
                                'img' => $banner['img']
                            ]);
                        }
                        ?>

                        <div class="catalog-box__view-top-line">
                            <div class="catalog-box__view-badges-wrap">
                                <?php
                                $shouldShowFilters = false;
                                foreach ($_REQUEST as $k => $v) {
                                    if (str_starts_with(
                                            $k,
                                            'param_'
                                        ) || $k == 'price_min' || $k == 'price_max' || $k == 'brand' || $k == 'new' || $k == 'stock' || $k == 'discount' || $k == 'popular') {
                                        if ($v) {
                                            $shouldShowFilters = true;
                                            break;
                                        }
                                    }
                                }
                                ?>
                                <?php
                                if ($shouldShowFilters): ?>
                                    <div class="catalog-box__view-badges-box">
                                        <ul class="catalog-box__view-badges">
                                            <?php
                                            if ($_REQUEST['popular'] ?? false) {
                                                \App\Layout\Components\Blocks\Catalog\CatalogBadge\Layout::draw([
                                                    'first_text' => 'Хиты',
                                                    'dt' => 'data-tags="popular"',
                                                ]);
                                            }
                                            if ($_REQUEST['new'] ?? false) {
                                                \App\Layout\Components\Blocks\Catalog\CatalogBadge\Layout::draw([
                                                    'first_text' => 'Новинки',
                                                    'dt' => 'data-tags="new"',
                                                ]);
                                            }

                                            if ($_REQUEST['discount'] ?? false) {
                                                \App\Layout\Components\Blocks\Catalog\CatalogBadge\Layout::draw([
                                                    'first_text' => 'Распродажа',
                                                    'dt' => 'data-tags="discount"',
                                                ]);
                                            }

                                            ?>
                                            <?php
                                            foreach ($_REQUEST['brand'] ?? [] as $vv):
                                                ?><?php
                                                \App\Layout\Components\Blocks\Catalog\CatalogBadge\Layout::draw([
                                                    'first_text' => 'Совместимость',
                                                    'second_text' => (new \App\Extensions\Catalog\Model\Brand(
                                                        $vv
                                                    ))->name,
                                                    'dt' => 'data-brand="' . $vv . '"',
                                                ]); ?><?php
                                            endforeach; ?><?php
                                            foreach ($_REQUEST as $k => $v):
                                                if (!str_starts_with($k, 'param_')) {
                                                    continue;
                                                }

                                                foreach ($v as $vv):
                                                    $param = \App\Extensions\Catalog\Model\Param::findOne([
                                                        'param_id' => (int)substr(
                                                            $k,
                                                            strlen('param_')
                                                        )
                                                    ])
                                                    ?><?php
                                                    \App\Layout\Components\Blocks\Catalog\CatalogBadge\Layout::draw([
                                                        'first_text' => $param->name,
                                                        'second_text' => $vv == '1' ? '' : $vv,
                                                        'dt' => 'data-param="' . (int)substr(
                                                                $k,
                                                                strlen('param_')
                                                            ) . '" data-pval="' . $vv . '"',
                                                    ]); ?><?php
                                                endforeach; endforeach; ?>

                                            <?php
                                            if (isset($_REQUEST['price_min']) || isset($_REQUEST['price_max'])):
                                                $minText = ($_REQUEST['price_min'] ?? '') ? ('от ' . \Simflex\Core\Helpers\Str::price(
                                                        $_REQUEST['price_min']
                                                    )) : '';
                                                $maxText = ($_REQUEST['price_max'] ?? '') ? ('до ' . \Simflex\Core\Helpers\Str::price(
                                                        $_REQUEST['price_max']
                                                    )) : '';
                                                if ($minText || $maxText) {
                                                    \App\Layout\Components\Blocks\Catalog\CatalogBadge\Layout::draw([
                                                        'first_text' => 'Цена',
                                                        'second_text' => "$minText $maxText",
                                                        'dt' => 'data-price="price"',
                                                    ]);
                                                } ?><?php
                                            endif; ?>

                                            <?php
                                            \App\Layout\Components\Blocks\Catalog\CatalogBadge\Layout::draw([
                                                'first_text' => 'Очистить всё',
                                                'dt' => 'data-reset="reset"',
                                                'style' => 'secondary',
                                            ]); ?>
                                        </ul>
                                    </div>
                                <?php
                                endif; ?>
                            </div>

                            <div class="catalog-box__sort-wrap">
                                <?php
                                App\Layout\Components\Common\Dropdown\Layout::draw([
                                    'class_name' => 'catalog-box__dropdown',
                                    'placeholder' => 'Сортировать',
                                    'items' => [
                                        'pmin' => 'Сначала дешевле',
                                        'pmax' => 'Сначала дороже',
                                        'aup' => 'По алфавиту: А — Я',
                                        'adown' => 'По алфавиту: Я — А',
                                    ]
                                ]); ?>

                                <div class="catalog-box__sort-wrap-divider"></div>

                                <button class="catalog-box__filters-button">
                                    <span class="catalog-box__filters-text">Фильтры</span>
                                    <svg class="catalog-box__filters-icon"
                                         xmlns="http://www.w3.org/2000/svg"
                                         viewBox="0 0 24 24"
                                         fill="none">
                                        <path d="M3 8L15 8M15 8C15 9.65686 16.3431 11 18 11C19.6569 11 21 9.65685 21 8C21 6.34315 19.6569 5 18 5C16.3431 5 15 6.34315 15 8ZM9 16L21 16M9 16C9 17.6569 7.65685 19 6 19C4.34315 19 3 17.6569 3 16C3 14.3431 4.34315 13 6 13C7.65685 13 9 14.3431 9 16Z"
                                              stroke="#404040"
                                              stroke-width="2"
                                              stroke-linecap="round"
                                              stroke-linejoin="round"/>
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="catalog-box__cards-box">
                        <?php
                        \App\Layout\Components\Blocks\Catalog\CatalogHeadlines\Layout::draw([
                            'class_name' => 'catalog-box__headlines'
                        ]); ?>

                        <ul class="catalog-box__cards">
                            <?php
                            $cp = $cat->getProducts('50 offset ' . ($pag * 50), $data['s'], $data['f']);
                            /** @var \App\Extensions\Catalog2\Model\Product $prod */
                            foreach ($cp

                            as $prod): ?>
                            <li class="catalog-box__card">
                                <?php
                                \App\Layout\Components\Blocks\Catalog\CatalogCard\Layout::draw([
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
                                    ], (function () use ($prod) {
                                        $prices = $prod->getPrices();
                                        usort($prices, fn($a, $b) => $a->level->level_ord <=> $b->level->level_ord);
                                        return $prices;
                                    })()),
                                    'class_name' => '',
                                    'id' => $prod->product_id,
                                    'variant' => $prod->variantId,
                                    'fav' => $prod->inFav(),
                                    'cartc' => \App\Extensions\Catalog\SessionAssist::$cart->getProductQty(
                                        $prod->product_id,
                                        $prod->variantId
                                    ),
                                ]);
                                ?><?php
                                endforeach; ?>
                            </li>
                        </ul>
                        <?php
                        $user = \Simflex\Core\Container::getUser();
                        $l = $user ? $user->getLevel() : null;
                        if ($l && $l->getNextLevel()): ?>
                            <div class="catalog-box__transparent-column" data-open="price-info">
                                <div class="catalog-box__transparent-sticky">
                                    <div class="catalog-box__transparent-question">
                                        <svg xmlns="http://www.w3.org/2000/svg"
                                             width="25"
                                             height="24"
                                             viewBox="0 0 25 24"
                                             fill="none">
                                            <path d="M11.0969 16C11.0969 14.65 11.2177 13.6792 11.4594 13.0875C11.701 12.4958 12.2135 11.85 12.9969 11.15C13.6802 10.55 14.201 10.0292 14.5594 9.5875C14.9177 9.14583 15.0969 8.64167 15.0969 8.075C15.0969 7.39167 14.8677 6.825 14.4094 6.375C13.951 5.925 13.3135 5.7 12.4969 5.7C11.6469 5.7 11.001 5.95833 10.5594 6.475C10.1177 6.99167 9.80521 7.51667 9.62188 8.05L7.04688 6.95C7.39688 5.88333 8.03854 4.95833 8.97188 4.175C9.90521 3.39167 11.0802 3 12.4969 3C14.2469 3 15.5927 3.4875 16.5344 4.4625C17.476 5.4375 17.9469 6.60833 17.9469 7.975C17.9469 8.80833 17.7677 9.52083 17.4094 10.1125C17.051 10.7042 16.4885 11.375 15.7219 12.125C14.9052 12.9083 14.4094 13.5042 14.2344 13.9125C14.0594 14.3208 13.9719 15.0167 13.9719 16H11.0969ZM12.4969 22C11.9469 22 11.476 21.8042 11.0844 21.4125C10.6927 21.0208 10.4969 20.55 10.4969 20C10.4969 19.45 10.6927 18.9792 11.0844 18.5875C11.476 18.1958 11.9469 18 12.4969 18C13.0469 18 13.5177 18.1958 13.9094 18.5875C14.301 18.9792 14.4969 19.45 14.4969 20C14.4969 20.55 14.301 21.0208 13.9094 21.4125C13.5177 21.8042 13.0469 22 12.4969 22Z"/>
                                            <path d="M11.0969 16C11.0969 14.65 11.2177 13.6792 11.4594 13.0875C11.701 12.4958 12.2135 11.85 12.9969 11.15C13.6802 10.55 14.201 10.0292 14.5594 9.5875C14.9177 9.14583 15.0969 8.64167 15.0969 8.075C15.0969 7.39167 14.8677 6.825 14.4094 6.375C13.951 5.925 13.3135 5.7 12.4969 5.7C11.6469 5.7 11.001 5.95833 10.5594 6.475C10.1177 6.99167 9.80521 7.51667 9.62188 8.05L7.04688 6.95C7.39688 5.88333 8.03854 4.95833 8.97188 4.175C9.90521 3.39167 11.0802 3 12.4969 3C14.2469 3 15.5927 3.4875 16.5344 4.4625C17.476 5.4375 17.9469 6.60833 17.9469 7.975C17.9469 8.80833 17.7677 9.52083 17.4094 10.1125C17.051 10.7042 16.4885 11.375 15.7219 12.125C14.9052 12.9083 14.4094 13.5042 14.2344 13.9125C14.0594 14.3208 13.9719 15.0167 13.9719 16H11.0969ZM12.4969 22C11.9469 22 11.476 21.8042 11.0844 21.4125C10.6927 21.0208 10.4969 20.55 10.4969 20C10.4969 19.45 10.6927 18.9792 11.0844 18.5875C11.476 18.1958 11.9469 18 12.4969 18C13.0469 18 13.5177 18.1958 13.9094 18.5875C14.301 18.9792 14.4969 19.45 14.4969 20C14.4969 20.55 14.301 21.0208 13.9094 21.4125C13.5177 21.8042 13.0469 22 12.4969 22Z"/>
                                        </svg>
                                    </div>
                                    <p class="catalog-box__transparent-text">Как открыть? </p>
                                </div>
                            </div>
                        <?php
                        endif; ?>
                    </div>

                    <ul class="catalog-box__mob-cards">
                        <?php
                        foreach ($cp as $prod): ?><?php
                            /** @var \App\Extensions\Catalog2\Model\Product $prod */
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
                                'prices' => array_map(fn($p) => [
                                    'has_discount' => $p->hasOldPrice(),
                                    'has_price' => $p->hasPrice(),
                                    'price' => \Simflex\Core\Helpers\Str::price($p->getPrice()),
                                    'old_price' => \Simflex\Core\Helpers\Str::price($p->getOldPrice()),
                                    'level' => $p->level->level_ord,
                                ], (function () use ($prod) {
                                        $prices = $prod->getPrices();
                                        usort($prices, fn($a, $b) => $a->level->level_ord <=> $b->level->level_ord);
                                        return $prices;
                                    })()),
                                'level' => $price->level->name,
                                'level_desc' => $price->level->desc,
                                'stock' => $prod->formatStock(),
                                'stock_color' => $prod->formatStockColor(),
                                'new' => $prod->is_new,
                                'popular' => $prod->is_popular,
                                'discount' => $prod->getDiscountPercent(),
                                'fav' => $prod->inFav(),
                                'cartc' => \App\Extensions\Catalog\SessionAssist::$cart->getProductQty(
                                    $prod->product_id,
                                    $prod->variantId
                                ),
                            ]);
                            ?><?php
                        endforeach; ?>
                    </ul>
                    <?php
                    $paginationLink = \Simflex\Core\Container::getRequest()->getPath() ?: '/catalog/';
                    $pagesTotal = (int)ceil($count / 50);
                    App\Layout\UIKit\Pagination\Layout::draw([
                        'link' => $paginationLink,
                        'page' => $pag,
                        'hasPrev' => !!$pag,
                        'pages' => $pagesTotal,
                        'hasNext' => $pag < ($pagesTotal - 1),
                        'className' => 'catalog-pagination'
                    ]); ?>
                </div>
            </div>
        <?php
        endif; ?>
    </div>
</section>
