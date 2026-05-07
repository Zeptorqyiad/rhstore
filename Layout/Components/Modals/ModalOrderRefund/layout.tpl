<?php
/** @var array $data */
extract($data)
?>

<dialog class="modal-order-refund">
    <div class="modal-order-refund__container">
        <div class="modal-order-refund__text">
            <div class="modal-order-refund__top">
                <p class="modal-order-refund__title">Заявка на возврат</p>
                <?php App\Layout\UIKit\ButtonModalClose\Layout::draw(); ?>
            </div>
            <p class="modal-order-refund__desc">Напишите нам, что у вас случилось, и какой товар вы хотите вернуть.
                Мы вам
                перезвоним и поможем решить проблему, а если проблема не решится, то оформим возврат в частном
                порядке<</p>
        </div>
        <div class="modal-order-refund__bottom">
            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Отменить заказ',
                'style' => 'primary',
                'class_name' => 'modal-order-refund__button',
                'type' => 'button',
//                'onclick' => 'logout()',
            ]); ?>
            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Не отменять',
                'style' => 'gray',
                'class_name' => 'modal-order-refund__button modal-order-refund__button_close',
                'type' => 'button',
            ]); ?>
        </div>
    </div>
</dialog>
