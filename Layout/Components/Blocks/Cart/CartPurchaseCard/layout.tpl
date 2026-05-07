<?php
/** @var array $data */

$cart = \App\Extensions\Catalog\SessionAssist::$cart;
$level = \App\Extensions\Catalog2\Model\PriceLevel::getAuto();
$next = $level->getNextLevel();

$user = \Simflex\Core\Container::getUser();

$isMin = $cart->__sum_actual >= \Simflex\Core\Core::siteParam('min_order');
$tooMuch = $cart->__sum_actual > \Simflex\Core\Core::siteParam('max_order');
?>

<div class="<?= $data["class_name"] ?> cart-purchase-card">
    <div class="cart-purchase-card__t-line">
        <div class="cart-purchase-card__t-left">
            Ваш заказ
        </div>
        <div class="cart-purchase-card__t-right">
            <?= \Simflex\Core\Helpers\Str::pluralize($cart->getTotalOrderCount(), 'товар') ?>
        </div>
    </div>
    <div class="cart-purchase-card__lines">
        <div class="cart-purchase-card__line">
            <span class="cart-purchase-card__line-description">Товары:</span>
            <span class="cart-purchase-card__line-products"><?= $cart->sum_total ?> ₽</span>
        </div>
        <div class="js--prices-min <?= !$isMin ? 'hidden' : '' ?>">
            <div class="cart-purchase-card__line js--discount <?= $cart->getDiscountNum() ? '' : 'hidden' ?>">
                <span class="cart-purchase-card__line-description">Скидка:</span>
                <span class="cart-purchase-card__line-discount"><?= $cart->getDiscount() ?> ₽</span>
            </div>
            <div class="cart-purchase-card__line cart-purchase-card__total">
                <span class="cart-purchase-card__line-description">Итого:</span>
                <span class="cart-purchase-card__line-result"><?= $cart->sum_actual ?> ₽</span>
            </div>
        </div>
        <div class="cart-purchase-card__notify">
            <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none">
                <path fill-rule="evenodd" clip-rule="evenodd" d="M12 6C12 9.31371 9.31371 12 6 12C2.68629 12 0 9.31371 0 6C0 2.68629 2.68629 0 6 0C9.31371 0 12 2.68629 12 6ZM7 3C7 3.55228 6.55228 4 6 4C5.44772 4 5 3.55228 5 3C5 2.44772 5.44772 2 6 2C6.55228 2 7 2.44772 7 3ZM6 5C5.44772 5 5 5.44772 5 6V9C5 9.55229 5.44772 10 6 10C6.55228 10 7 9.55229 7 9V6C7 5.44772 6.55228 5 6 5Z" fill="#FF3838"/>
            </svg>
            <p class="cart-purchase-card__notify--text">
                Цена не является публичной офертой и может быть изменена.
                Перед сборкой заказа отправим вам счёт на согласование с актуальными ценами.
            </p>
        </div>
    </div>
    <div class="cart-purchase-card__wholesale-line-unavailable js--purchase-min <?= $isMin ? 'hidden' : '' ?>">
        <div class="cart-purchase-card__wholesale-line-unavailable-wrapper">
            <div class="cart-purchase-card__wholesale-text cart-purchase-card__wholesale-text-short">
                Минимальная сумма заказа:
            </div>
            <span class="cart-purchase-card__amount min"><?= \Simflex\Core\Helpers\Str::price(
                    \Simflex\Core\Core::siteParam('min_order')
                ) ?></span>
        </div>
        <div class="cart-purchase-card__wholesale-line-unavailable-line"></div>
        <div class="cart-purchase-card__wholesale-line-unavailable-wrapper">
            <div class="cart-purchase-card__wholesale-text cart-purchase-card__wholesale-text_bold">
                Закажите ещё на:
            </div>

            <span class="cart-purchase-card__amount discount"><?= \Simflex\Core\Helpers\Str::price(
                    \Simflex\Core\Core::siteParam('min_order') - $cart->__sum_actual
                ) ?></span>
        </div>
    </div>
    <div class="js--purchase-price">
        <div class="cart-purchase-card__wholesale-wrap">
            <div class="cart-purchase-card__wholesale-text js--calc <?= !$isMin ? 'hidden' : '' ?>">
                <div class="cart-purchase-card__wholesale-line">
                    <div class="cart-purchase-card__wholesale-text">
                        Стоимость для вас рассчитывается по прайсу:
                    </div>
                    <?php
                    App\Layout\Components\Common\SaleInfo\Layout::draw([
                        'text' => $level->name,
                        'secondary' => true,
                        'class_name' => 'cart-purchase-card__sale-info',
                        'hint_text' => $level->desc
                    ]); ?>
                </div>

                <div class="cart-purchase-card__conditions js--purchase-next <?= !$next || $next->is_by_total ? 'hidden' : '' ?>">
                    <div class="cart-purchase-card__conditions-text">
                        Для расчёта товаров по прайсу:
                    </div>
                    <?php
                    App\Layout\Components\Common\SaleInfo\Layout::draw([
                        'text' => $next ? $next->name : '',
                        'secondary' => true,
                        'class_name' => 'cart-purchase-card__sale-info-2',
                        'hint_text' => $next ? $next->desc : '',
                    ]); ?>
                </div>

                <div class="cart-purchase-card__conditions js--purchase-pers <?= $next && $next->is_by_total ? '' : 'hidden' ?>">
                    <div class="cart-purchase-card__conditions-text">
                        Для персонального расчёта:
                    </div>

                    <?php
                    App\Layout\Components\Common\SaleInfo\Layout::draw([
                        'text' => $next ? $next->name : '',
                        'secondary' => true,
                        'class_name' => 'cart-purchase-card__sale-info-2',
                        'hint_text' => $next ? $next->desc : '',
                    ]); ?>
                </div>

                <div class="cart-purchase-card__bottom-line <?= !!$next ? '' : 'hidden' ?>">
                    <div class="cart-purchase-card__bottom-line-text">
                        Закажите ещё на:
                    </div>
                    <div class="cart-purchase-card__bottom-line-price">
                        <?= $next ? \Simflex\Core\Helpers\Str::price($next->min - $cart->__sum_actual) : 0; ?>
                    </div>
                </div>
            </div>

<!--            <div class="cart-purchase-card__large-order js--personal --><?php //= $level < 6 ? 'hidden' : '' ?><!--">-->
<!--                <span class="cart-purchase-card__large-order-text">Спасибо за&nbsp;крупный заказ! Мы&nbsp;расчитаем ваш заказ индивидуально</span>-->
<!--            </div>-->

            <?php
//            if ($user): ?>
<!--                --><?php
//                \App\Layout\Components\Common\ButtonLinks\Layout::draw([
//                    'text' => $data['button_text'] ?? 'Перейти к оформлению',
//                    'style' => 'primary',
//                    'class_name' => 'cart-purchase-card__button-cart button-cart js--cartbtn ' . (!$isMin ? 'hidden' : ''),
//                    'type' => 'submit',
//                    'href' => $data['button_link'] ?? '/user/order/'
//                ]); ?>
            <?php if ($_SERVER['REQUEST_URI'] == '/cart/'):
                App\Layout\Components\Common\ButtonLinks\Layout::draw([
                    'text' => 'Перейти к оформлению',
                    'style' => 'primary',
                    'class_name' => 'cart-purchase-card__button-cart button-cart js--cartbtn ' . (!$isMin ? 'hidden' : ''),
                    'type' => 'submit',
//                    'href' => '/sign-in/'
//                    'href' => '/user/order/'
                    'href' => '/checkout/'
                ]);
                ?>
            <?php else: ?>
                <?php App\Layout\Components\Common\ButtonLinks\Layout::draw([
                    'text' => 'Перейти в корзину',
                    'style' => 'primary',
                    'class_name' => 'cart-purchase-card__button-cart button-cart js--cartbtn ' . (!$isMin ? 'hidden' : ''),
                    'type' => 'submit',
                    'href' => '/cart/'
                ]); ?>
            <?php
            endif; ?>

            <a href="/catalog/" class="cart-purchase-card__link">
                К покупкам
            </a>

        </div>
    </div>
</div>