<?php
/** @var array $data */
extract($data)

?>

<dialog class="modal-feedback <?= $data['class_name'] ?>">
    <div class="modal-feedback__container">
        <div class="modal-feedback__top">
            <p class="modal-feedback__title">Остались вопросы?</p>
            <p class="modal-feedback__desc">Оставьте свои контакты и мы вам перезвоним в течение 15 минут (в рабочее время)</p>
            <?php App\Layout\UIKit\ButtonModalClose\Layout::draw(); ?>
        </div>
        <form class="modal-feedback__form" action="/form/" data-validate>

            <div class="modal-feedback__inputs">
                <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'modal-feedback__input',
                    'placeholder' => 'Имя*',
                    'name' => 'name',
                    'id' => 'nameQ',
                    'required' => true,
                    'autocomplete' => 'given-name',
                    'validate' => 'required',
                ]) ?>
                <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'modal-feedback__input',
                    'placeholder' => 'Телефон*',
                    'name' => 'phone',
                    'id' => 'phoneQ',
                    'required' => true,
                    'autocomplete' => 'tel',
                    'validate' => 'required|phone',
                ]) ?>
                <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'modal-feedback__input',
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
                'class_name' => 'modal-feedback__button',
                'type' => 'submit',
            ]); ?>

            <?php App\Layout\UIKit\CheckboxPolicy\Layout::draw([
                'checked' => false,
                'required' => true,
                'validate' => 'required|checkbox',
            ]); ?>
        </form>
    </div>
</dialog>
