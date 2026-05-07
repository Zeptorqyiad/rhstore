<?php

/** @var array $data */
$last = \App\Extensions\Catalog\Model\Order::findAdv()->where(['user_id' => \Simflex\Core\Container::getUser()->user_id]
)->orderBy('order_id desc')->fetchOne();
?>

<div class="order-success">
    <img class="order-success__image" src="/assets/images/common/hand-success.webp" alt="">
    <div class="order-success__text">
        <div class="order-success__heading">
            <h1 class="order-success__title">
                Заказ
<!--                --><?php //= $last->order_id ?><!-- -->
                оформлен!
            </h1>
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                <path fill="#49CC60" fill-rule="evenodd"
                      d="M12 24c6.627 0 12-5.373 12-12S18.627 0 12 0 0 5.373 0 12s5.373 12 12 12Zm-2.329-7.43a1.511 1.511 0 0 1-.13-.113L6.448 13.42a1.483 1.483 0 0 1-.002-2.12 1.536 1.536 0 0 1 2.15 0l2.042 2.013 5.314-5.238a1.535 1.535 0 0 1 2.15 0 1.483 1.483 0 0 1-.003 2.12l-6.405 6.281a1.524 1.524 0 0 1-2.022.095Z"
                      clip-rule="evenodd"/>
            </svg>
        </div>
        <p class="order-success__description">Менеджер с вами свяжется в течение 30 минут для подтверждения заказа (в
            рабочее время)</p>
    </div>
    <div class="order-success__buttons">
        <?php
        App\Layout\Components\Common\ButtonLinks\Layout::draw([
            'text' => 'В каталог',
            'style' => 'primary',
            'class_name' => 'order-success__button',
            'href' => '/catalog/',
        ]); ?>
        <?php
        App\Layout\Components\Common\ButtonLinks\Layout::draw([
            'text' => 'На главную',
            'style' => 'transparent',
            'class_name' => 'order-success__button',
            'href' => '/',
        ]); ?>
    </div>
</div>
