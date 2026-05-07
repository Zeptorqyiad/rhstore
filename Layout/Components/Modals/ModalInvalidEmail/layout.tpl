<?php
/** @var array $data */
extract($data)
?>

<dialog class="modal-invalid-email">
    <div class="modal-invalid-email__container">
        <div class="modal-invalid-email__top">
            <p class="modal-invalid-email__title">Email или номер телефона уже зарегистрован</p>
            <p class="modal-invalid-email__desc">Пожалуйста, проверьте введённые данные и попробуйте снова.</p>
        </div>
        <div class="modal-invalid-email__bottom">
            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Закрыть',
                'style' => 'primary',
                'class_name' => 'modal-invalid-email__button modal-invalid-email__button_close',
                'type' => 'button',
            ]); ?>
        </div>
    </div>
</dialog>
