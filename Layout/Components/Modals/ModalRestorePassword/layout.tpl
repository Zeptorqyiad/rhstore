<?php
/** @var array $data */
?>

<dialog class="modal-restore-pass">
    <form class="modal-restore-pass__form" data-validate>
        <div class="modal-restore-pass__text">
            <div class="modal-restore-pass__top">
                <p class="modal-restore-pass__title">Восстановить пароль</p>
                <?php App\Layout\UIKit\ButtonModalClose\Layout::draw(); ?>
            </div>
            <p class="modal-restore-pass__desc">Введите свой e-mail, и мы отправим ссылку на восстановление пароля</p>
        </div>
        <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
            'class_name' => 'modal-restore-pass__input',
            'placeholder' => 'E-mail*',
            'name' => 'email',
            'id' => 'emailRestore',
            'required' => true,
            'autocomplete' => 'email',
            'validate' => 'required|email',
        ]); ?>
        <div class="modal-restore-pass__bottom">
            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Отправить подтверждение',
                'style' => 'primary',
                'class_name' => 'modal-restore-pass__submit',
                'type' => 'button',
            ]); ?>
            <?php App\Layout\UIKit\ButtonArrow\Layout::draw([
                    'class_name' => 'modal-restore-pass__back'
            ]); ?>
        </div>
    </form>
</dialog>
