<?php
/** @var array $data */
extract($data)
?>

<dialog class="modal-logout">
    <div class="modal-logout__container">
        <div class="modal-logout__text">
            <div class="modal-logout__top">
                <p class="modal-logout__title">Выйти из профиля?</p>
                <?php App\Layout\UIKit\ButtonModalClose\Layout::draw(); ?>
            </div>
            <p class="modal-logout__desc">Вы уверены, что хотите выйти из профиля?</p>
        </div>
        <div class="modal-logout__bottom">
            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Выйти из профиля',
                'style' => 'primary',
                'class_name' => 'modal-logout__button',
                'type' => 'button',
                'onclick' => 'logout()',
            ]); ?>
            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Не выходить',
                'style' => 'gray',
                'class_name' => 'modal-logout__button modal-logout__button_close',
                'type' => 'button',
            ]); ?>
        </div>
    </div>
</dialog>
