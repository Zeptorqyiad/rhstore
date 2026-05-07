<?php
/** @var array $data */
extract($data)
?>

<dialog class="modal-invalid-user">
    <div class="modal-invalid-user__container">
        <div class="modal-invalid-user__top">
            <p class="modal-invalid-user__title">Неверные данные для входа</p>
            <p class="modal-invalid-user__desc">Пожалуйста, проверьте введённые данные и попробуйте снова.</p>
        </div>
        <div class="modal-invalid-user__bottom">
            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Закрыть',
                'style' => 'primary',
                'class_name' => 'modal-invalid-user__button modal-invalid-user__button_close',
                'type' => 'button',
            ]); ?>
        </div>
    </div>
</dialog>
