<?php
/** @var array $data */
extract($data)
?>

<dialog class="modal-order-cancel">
    <div class="modal-order-cancel__container">
        <div class="modal-order-cancel__text">
            <div class="modal-order-cancel__top">
                <p class="modal-order-cancel__title">Отменить заказ?</p>
                <?php App\Layout\UIKit\ButtonModalClose\Layout::draw(); ?>
            </div>
            <p class="modal-order-cancel__desc">После отмены, восстановить заказ самостоятельно
                будет нельзя.</p>
        </div>
        <div class="modal-order-cancel__bottom">
            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Отменить заказ',
                'style' => 'primary',
                'class_name' => 'modal-order-cancel__button',
                'type' => 'button',
//                'onclick' => 'logout()',
            ]); ?>
            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Не отменять',
                'style' => 'gray',
                'class_name' => 'modal-order-cancel__button modal-order-cancel__button_close',
                'type' => 'button',
            ]); ?>
        </div>
    </div>
</dialog>
