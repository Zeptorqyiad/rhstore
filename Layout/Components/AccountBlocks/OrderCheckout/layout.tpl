<?php
/** @var array $data */

$cart = \App\Extensions\Catalog\SessionAssist::$cart;
$u = \Simflex\Core\Container::getUser();
//$tc = \App\Extensions\Catalog\Model\Transcomp::findOne(['transcomp_id' => $u->transcomp_id]);

$tc = null;
?>

<div class="order-checkout">
    <h1 class="order-checkout__heading">Оформление заказа</h1>
    <form class="order-checkout__form"
          method="post"
          action="/checkout/make"
<!--          action="/user/order/make/" -->
    >
        <div class="order-checkout__container">
<!--            <div class="order-checkout__payment">-->
<!--                <p class="order-checkout__title">Способ оплаты</p>-->
<!--                --><?php
//                foreach (\App\Extensions\Catalog\Model\Payment::findAdv()->orderBy('npp')->all() as $p): ?>
<!--                    --><?php
//                    App\Layout\Components\AccountBlocks\OrderTypeCard\Layout::draw([
//                        'input_name' => 'payment_id',
//                        'value' => '',
//                        'name' => $p->name,
//                        'desc' => $p->desc,
//                        'checked' => true,
//                    ]); ?>
<!--                --><?php
//                endforeach; ?>
<!--                <div class="order-checkout__input-row">-->
<!--                    --><?php
//                    App\Layout\Components\Common\VariantTextField\Layout::draw([
//                        'class_name' => 'order-checkout__input',
//                        'placeholder' => 'Р/С',
//                        'val' => $u->org_account,
//                        'name' => 'org_account',
//                    ]) ?>
<!--                    --><?php
//                    App\Layout\Components\Common\VariantTextField\Layout::draw([
//                        'class_name' => 'order-checkout__input',
//                        'placeholder' => 'БИК банка',
//                        'name' => 'org_bic',
//                        'val' => $u->org_bic,
//                    ]) ?>
<!--                </div>-->
<!--            </div>-->
<!--            <div class="order-checkout__delivery">-->
<!--                <div class="order-checkout__text-wrapper">-->
<!--                    <p class="order-checkout__title">Способ доставки</p>-->
<!--                    <p class="order-checkout__subtitle">--><?php //= $tc->name ?><!--, --><?php //= intval(
//                            $tc->price
//                        ) ? ('от ' . str_replace(' ₽', '', $tc->price) . ' ₽') : $tc->price ?><!--</p>-->
<!--                    <p class="order-checkout__subtitle">--><?php //= $tc->delivery_time ?><!--</p>-->
<!--                </div>-->
<!--                <div class="order-checkout__text-wrapper">-->
<!--                    <p class="order-checkout__title">Получатель</p>-->
<!--                    <p class="order-checkout__subtitle">--><?php //= $u->other_last_name ?><!-- --><?php //= $u->other_name ?>
<!--                        , --><?php //= $u->other_phone ?><!--, --><?php //= $u->other_email ?><!--</p>-->
<!--                </div>-->
<!--                --><?php
//                App\Layout\Components\Common\Button\Layout::draw([
//                    'text' => 'Изменить данные',
//                    'style' => 'gray',
//                    'class_name' => 'order-checkout__card-button',
//                    'icon' => true,
//                    'link' => '/delivery-edit/'
//                ]); ?>
<!--            </div>-->

            <div class="order-checkout__contacts">
                <div class="order-checkout__contacts-top">
                    <div class="order-checkout__contacts-top--title">
                        Ваши данные
                    </div>
                    <div class="order-checkout__contacts-top--text">
                        После оформления с вами свяжется персональный менеджер для подтверждения состава заказа,
                        сроков и актуальных цен. Оплата производится по индивидуальному счёту, который будет
                        сформирован после заказа.
                    </div>
                </div>
                <div class="order-checkout__contacts-inputs">
                    <div class="order-checkout__contacts-inputs--top">
                        <?php
                        App\Layout\Components\Common\VariantTextField\Layout::draw([
                            'type' => 'name',
                            'placeholder' => 'Имя*',
                            'name' => 'name',
                            'id' => 'name',
                            'required' => true,
                        ]);
                        App\Layout\Components\Common\VariantTextField\Layout::draw([
                            'type' => 'tel',
                            'name' => 'phone',
                            'id' => 'phone',
                            'required' => true,
                            'autocomplete' => 'tel',
                            'validate' => 'required|phone',
                        ])
                        ?>
                    </div>
                    <div class="order-checkout__contacts-inputs--label">
                        Необязательно
                    </div>
                    <div class="order-checkout__contacts-inputs--bottom">
                        <?php
                        App\Layout\Components\Common\VariantTextField\Layout::draw([
                            'type' => 'email',
                            'placeholder' => 'E-mail',
                            'name' => 'email',
                            'id' => 'email',
                            'required' => false,
                        ]);
                        App\Layout\Components\Common\DropdownForm\Layout::draw([
                            'class_name' => 'order-checkout__contacts-inputs--select',
                            'placeholder' => 'Где с вами связаться?',
                            'name' => 'callback',
                            'items' => [
                                'tg' => 'Telegram',
                                'wt' => 'WhatsApp',
                                'mail' => 'Почта',
                                'phone' => 'Позвоните',
                            ],
                            'value' => '',
                        ]);
                        ?>
                        <input type="hidden" name="callback_text" value="">
                    </div>
                </div>

                <?php App\Layout\Components\Common\Separator\Layout::draw([
                    'className' => 'steel',
                ]) ?>

                <div class="order-checkout__contacts-bottom">
                    <?php App\Layout\UIKit\OrganizationSelect\Layout::draw(); ?>
                </div>
            </div>

            <div class="order-checkout__cart">
                <div class="order-checkout__text-wrapper">
                    <p class="order-checkout__title">Заказ</p>
                    <p class="order-checkout__subtitle"><?= \Simflex\Core\Helpers\Str::pluralize(
                            $cart->getProductCount(),
                            'товар'
                        ) ?></p>
                </div>
                <?php
                App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Вернуться в корзину',
                    'style' => 'gray',
                    'class_name' => 'order-checkout__card-button',
                    'icon' => true,
                    'link' => '/cart/'
                ]); ?>
                <div class="order-checkout__cards-wrapper">
                    <ul class="order-checkout__cards">
                        <?php
                        $ci = $cart->getProducts()['items'];
                        foreach ($ci as $pi):
                            /** @var \App\Extensions\Catalog2\Model\Product $p */
                            $prod = $pi['product'];
                            ?>
                            <li class="order-checkout__card">
                                <?php
                                \App\Layout\Components\Blocks\Catalog\CatalogCard\Layout::draw([
                                    'href' => '/' . $prod->path . '/',
                                    'image' => $prod->getPrimaryImage(),
                                    'title' => $prod->name,
                                    'article' => $prod->sku,
                                    'conditions' => $prod->bulk_amount,
                                    'bulk_desc' => \Simflex\Core\Core::siteParam('bulk_desc'),
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
                                    'class_name' => 'order-checkout__catalog-card',
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
                    <ul class="order-checkout__mobile-cards">
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
                                'class_name' => 'order-checkout__product-card',
                                'horizontal' => true,
                            ]);
                            ?>
                        <?php
                        endforeach; ?>
                    </ul>

                </div>
            </div>
        </div>
        <?php
        App\Layout\Components\AccountBlocks\CheckoutCard\Layout::draw([
            'check_text' => 'Оформить заказ',
        ]); ?>
    </form>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const form = document.querySelector('.order-checkout__form');
    if (!form) return;

    const callbackTextInput = form.querySelector('input[name="callback_text"]');
    const dropdownInput = form.querySelector('.order-checkout__contacts-inputs--select .dropdown-form__input');

    if (!callbackTextInput || !dropdownInput) return;

    const syncCallbackText = () => {
        callbackTextInput.value = (dropdownInput.value || '').trim();
    };

    form.addEventListener('click', syncCallbackText);
    form.addEventListener('change', syncCallbackText);
    form.addEventListener('submit', syncCallbackText);
});
</script>
