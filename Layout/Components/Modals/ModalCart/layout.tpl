<?php
/** @var array $data */

?>

<div class="modal-cart">
    <div class="modal-cart__container">
        <?php App\Layout\Components\Blocks\Cart\CartPurchaseCard\Layout::draw([
            'class_name' => '',
            'button_text' => 'В корзину',
            'button_link' => '/cart/',
        ]); ?>
    </div>
</div>