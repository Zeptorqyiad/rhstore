<?php

$cart = \App\Extensions\Catalog\SessionAssist::$cart;
$u = \Simflex\Core\Container::getUser();

?>

<?php
App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php
App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

    <main class="order-active">
        <div class="order-active__back">
            <div class="order-active__wrap">
                <?php
                App\Layout\Components\Common\NavAside\Layout::draw([
                    'class_name' => 'order-active__aside',
                    'active' => '2'
                ]); ?>

                <div class="order-active__column">
                    <?php
                    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
                        'class_name' => 'order-active__breadcrumbs',
                        'text' => 'Активные заказы'
                    ]); ?>

                    <div class="order-active__body">
                        <div class="order-active__details" data-id="<?= $data['number'] ?>">
                            <h3 class="order-active__number">Заказ <?= $data['number'] ?></h3>
                            <p class="order-active__date"><?= $data['date'] ?></p>
                            <div class="order-active__status order-active__status_<?= $data['badge_color'] ?>"><?= $data['status'] ?></div>
                            <?php
                            if ($data['track_link']): ?>
                                <a href="<?= $data['track_link'] ?>" class="order-active__link">Отслеживание заказа</a>
                            <?php
                            endif; ?>
                            <div class="order-active__sum">Сумма: <?= $data['sum'] ?> ₽</div>
                            <div class="order-active__count">Товаров: <?= $data['count'] ?> шт.</div>

                            <?php
                            if ($data['is_repeat'] === true): ?>
                                <button class="order-active__repeat">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                              d="M12 4C7.58172 4 4 7.58172 4 12C4 16.4183 7.58172 20 12 20C15.7912 20 18.9664 17.3629 19.7914 13.8229L19.407 14.2072C19.0164 14.5977 18.3832 14.5976 17.9927 14.207C17.6023 13.8164 17.6024 13.1833 17.9929 12.7928L19.9935 10.7928C20.1811 10.6053 20.4355 10.5 20.7007 10.5C20.9659 10.5 21.2202 10.6054 21.4078 10.793L23.4072 12.793C23.7976 13.1836 23.7975 13.8167 23.407 14.2072C23.0164 14.5977 22.3832 14.5976 21.9927 14.207L21.7976 14.0118C20.8665 18.5704 16.8338 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C15.67 2 18.8771 3.97759 20.6155 6.92048C20.8964 7.39599 20.7386 8.00919 20.2631 8.29009C19.7876 8.57098 19.1744 8.41322 18.8935 7.9377C17.5 5.57869 14.9338 4 12 4ZM12 6C12.5523 6 13 6.44772 13 7V11.4648L15.5547 13.1679C16.0142 13.4743 16.1384 14.0952 15.8321 14.5547C15.5257 15.0142 14.9048 15.1384 14.4453 14.8321L11.4453 12.8321C11.1671 12.6466 11 12.3344 11 12V7C11 6.44772 11.4477 6 12 6Z"
                                              fill="white"/>
                                    </svg>
                                    <span>Повторить заказ</span>
                                </button>
                            <?php endif;  ?>

                            <?php if (!($data['archived'] || $data['status'] !== 'Ожидает оплаты')): ?>
                                <?php
                                App\Layout\Components\Common\Button\Layout::draw([
                                    'text' => 'Отменить',
                                    'style' => 'gray',
                                    'class_name' => 'order-active__cancel',
                                    'link' => '',
                                ]); ?>
                            <?php endif; ?>

                        </div>

                        <?php
                        if ($docs = json_decode($data['order']->documents, true)['v'] ?? []): ?>
                            <div class="order-active__documents">
                                <h3 class="order-active__title">Документы</h3>
                                <ul class="order-active__doc-list">
                                    <?php
                                    foreach ($docs as $item): ?>
                                        <li class="order-active__doc-item">
                                            <p class="order-active__doc-item-name"><?= $item['name'] ?></p>
                                            <p class="order-active__doc-item-date"><?= $item['date'] ?></p>
                                            <p class="order-active__doc-item-price"><?= $item['sum'] ?></p>
                                            <?php
                                            App\Layout\UIKit\ButtonDownload\Layout::draw([
                                                'class_name' => 'order-active__doc-item-download',
                                                'link' => $item['file'],
                                            ]); ?>
                                        </li>
                                    <?php
                                    endforeach; ?>
                                </ul>
                                <button class="order-active__show-more">
                                    <span>Развернуть</span>
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="#999" viewBox="0 0 24 24">
                                        <path fill-rule="evenodd"
                                              d="M8.293 10.293a1 1 0 0 1 1.414 0L12 12.586l2.293-2.293a1 1 0 1 1 1.414 1.414l-3 3a1 1 0 0 1-1.414 0l-3-3a1 1 0 0 1 0-1.414Z"
                                              clip-rule="evenodd"/>
                                    </svg>
                                </button>
                            </div>
                        <?php
                        endif; ?>

                        <div class="order-active__cards-wrapper">
                            <div class="order-active__sort-wrap">
                                <form>
                                    <?php
                                    App\Layout\Components\Common\Dropdown\Layout::draw([
                                        'class_name' => 'order-active__dropdown',
                                        'placeholder' => 'Сортировать',
                                        'name' => 'sort',
                                        'items' => [
                                            'pmin' => 'Сначала дешевле',
                                            'pmax' => 'Сначала дороже',
                                            'aup' => 'По алфавиту: А — Я',
                                            'adown' => 'По алфавиту: Я — А',
                                        ]
                                    ]); ?>
                                </form>

                                <button class="order-active__filters-button">
                                    <svg class="order-active__filters-icon"
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

                            <?php
                            \App\Layout\Components\Blocks\Catalog\CatalogHeadlines\Layout::draw([
                                'class_name' => 'order-active__headlines'
                            ]); ?>
                            <ul class="order-active__cards">
                                <?php
                                $sort = 'catalog_product.name asc';
                                switch ($_REQUEST['sort'] ?? '') {
                                    case 'pmin':
                                        $sort = 'catalog_order_product.price';
                                        break;
                                    case 'pmax':
                                        $sort = 'catalog_order_product.price desc';
                                        break;
                                    case 'aup':
                                        $sort = 'catalog_product.name asc';
                                        break;
                                    case 'adown':
                                        $sort = 'catalog_product.name desc';
                                        break;
                                }


                                $ci = $data['order']->getProducts('', $sort);
                                foreach ($ci as $pi):
                                    /** @var \App\Extensions\Catalog2\Model\Product $p */
                                    $prod = $pi['product'];
                                    ?>
                                    <li class="order-active__card">
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
                                            ], array_reverse($prod->getPrices())),
                                            'class_name' => 'order-active__catalog-card',
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
                            <ul class="order-active__mobile-cards">
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
                                        'class_name' => 'order-active__product-card',
                                        'horizontal' => true,
                                    ]);
                                    ?>
                                <?php
                                endforeach; ?>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
    </main>

<?php
App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php
App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw([
    'active_nav' => '4'
]); ?>