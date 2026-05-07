<?php
/** @var array $data */
extract($data)
?>

<dialog class="modal-help <?= $data['class_name'] ?>">
    <div class="modal-help__container">
        <div class="modal-help__top">
            <p class="modal-help__title">Не нашли что искали?</p>
            <p class="modal-help__desc">Оставьте свои контакты и мы вам перезвоним в течение 15 минут (в рабочее время)</p>
            <?php App\Layout\UIKit\ButtonModalClose\Layout::draw(); ?>
        </div>
        <form class="modal-help__form" action="/form/" data-validate>

            <div class="modal-help__inputs">
                <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'modal-help__input',
                    'placeholder' => 'Имя*',
                    'name' => 'name',
                    'id' => 'nameQ',
                    'required' => true,
                    'autocomplete' => 'given-name',
                    'validate' => 'required',
                ]) ?>
                <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'modal-help__input',
                    'placeholder' => 'Телефон*',
                    'name' => 'phone',
                    'id' => 'phoneQ',
                    'required' => true,
                    'autocomplete' => 'tel',
                    'validate' => 'required|phone',
                ]) ?>
                <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'modal-help__input',
                    'placeholder' => 'Почта*',
                    'name' => 'email',
                    'id' => 'emailQ',
                    'required' => true,
                    'autocomplete' => 'email',
                    'validate' => 'required|email',
                ]) ?>
            </div>

            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Отправить',
                'style' => 'primary',
                'class_name' => 'modal-help__button',
                'type' => 'submit',
            ]); ?>

            <?php App\Layout\UIKit\CheckboxPolicy\Layout::draw([
                'checked' => true,
                'required' => true,
                'validate' => 'required|checkbox',
            ]); ?>
        </form>
    </div>
</dialog>
