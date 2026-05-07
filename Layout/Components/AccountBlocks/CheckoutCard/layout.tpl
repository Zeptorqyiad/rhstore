<?php
/** @var array $data */

$cart = \App\Extensions\Catalog\SessionAssist::$cart;
$level = \App\Extensions\Catalog2\Model\PriceLevel::getAuto();
$next = $level->getNextLevel();

$ismin = $cart->__sum_actual >= \Simflex\Core\Core::siteParam('min_order');
$tooMuch = $cart->__sum_actual > \Simflex\Core\Core::siteParam('max_order');

?>


<div class="checkout-card">
    <div class="checkout-card__container">
        <div class="checkout-card__headline">
            <p class="checkout-card__title">Ваш заказ</p>
            <p class="checkout-card__quantity">
                <?= \Simflex\Core\Helpers\Str::pluralize($cart->getTotalOrderCount(), 'товар') ?>
            </p>
        </div>
        <div class="checkout-card__check">
            <div class="checkout-card__check-line">
                <span class="checkout-card__line-description">Товары:</span>
                <span class="checkout-card__line-products"><?= $cart->sum_total ?> ₽</span>
            </div>
            <?php if ($cart->getDiscountNum()): ?>
                <div class="checkout-card__check-line">
                    <span class="checkout-card__line-description">Скидка:</span>
                    <span class="checkout-card__line-discount"><?= $cart->getDiscount() ?> ₽</span>
                </div>
            <?php endif; ?>
            <div class="checkout-card__check-line">
                <span class="checkout-card__title">Итого:</span>
                <span class="checkout-card__line-result"><?= $cart->sum_actual ?> ₽</span>
            </div>

            <div class="checkout-card__notify">
                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none">
                    <path fill-rule="evenodd" clip-rule="evenodd"
                          d="M12 6C12 9.31371 9.31371 12 6 12C2.68629 12 0 9.31371 0 6C0 2.68629 2.68629 0 6 0C9.31371 0 12 2.68629 12 6ZM7 3C7 3.55228 6.55228 4 6 4C5.44772 4 5 3.55228 5 3C5 2.44772 5.44772 2 6 2C6.55228 2 7 2.44772 7 3ZM6 5C5.44772 5 5 5.44772 5 6V9C5 9.55229 5.44772 10 6 10C6.55228 10 7 9.55229 7 9V6C7 5.44772 6.55228 5 6 5Z"
                          fill="#FF3838"/>
                </svg>
                <p class="cart-purchase-card__notify--text">
                    Цена не является публичной офертой и может быть изменена. Перед
                    сборкой заказа отправим вам счёт на согласование с актуальными ценами.
                </p>
            </div>
        </div>
        <?php
        $user = \Simflex\Core\Container::getUser();
        $tc = ($user && $user->transcomp_id)
            ? \Simflex\Core\Container::getFactory()->create(
                \App\Extensions\Catalog\Model\Transcomp::class,
                $user->transcomp_id
            )
            : null;
        ?>
        <?php if ($tc && $tc->price): ?>
            <div class="checkout-card__delivery hidden">
                <span class="checkout-card__line-description">Стоимость доставки:</span>
                <?php if (intval($tc->price)): ?>
                    <span class="checkout-card__delivery-price">от <?= $tc->price ?> ₽</span>
                <?php else: ?>
                    <span class="checkout-card__delivery-price"><?= $tc->price ?></span>
                <?php endif; ?>
            </div>
        <?php endif; ?>

        <?php App\Layout\Components\Common\Button\Layout::draw([
            'text' => $data['check_text'],
            'style' => 'primary',
            'class_name' => 'checkout-card__button-cart button-cart',
            'type' => 'submit',
        ]); ?>
        <?php App\Layout\UIKit\CheckboxPolicy\Layout::draw([
            'checked' => false,
            'required' => true,
            'validate' => 'required|checkbox',
        ]); ?>
    </div>
</div>
