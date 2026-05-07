<?php
/** @var array $data */
extract($data);
?>

<div class="orders-not-found">
    <p class="orders-not-found__text">Вы не сделали ни одного заказа</p>
    <?php App\Layout\Components\Common\Button\Layout::draw([
        'text' => 'В каталог',
        'style' => 'primary',
        'class_name' => 'orders-not-found__button',
        'type' => 'button',
        'link' => '/catalog/',
    ]); ?>
</div>