<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> registration-form" id="sign-up-form-<?= $data['form_id'] ?>">
    <form class="registration-form__form" action="" novalidate data-validate>
        <h3 class="registration-form__title">
            Регистрация
        </h3>

        <div class="registration-form__inputs">
            <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                'class_name' => 'registration-form__input',
                'placeholder' => 'Фамилия*',
                'name' => 'last_name',
                'required' => true,
                'autocomplete' => 'family-name',
                'validate' => 'required',
            ]) ?>
            <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                'class_name' => 'registration-form__input',
                'placeholder' => 'Имя*',
                'name' => 'name',
                'required' => true,
                'autocomplete' => 'given-name',
                'validate' => 'required',
            ]) ?>
            <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                'class_name' => 'registration-form__input',
                'placeholder' => 'E-mail*',
                'name' => 'email',
                'id' => 'emailSignUp',
                'required' => true,
                'autocomplete' => 'email',
                'validate' => 'required|email',
            ]) ?>
            <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                'class_name' => 'registration-form__input',
                'placeholder' => 'Телефон*',
                'name' => 'phone',
                'required' => true,
                'autocomplete' => 'tel',
                'validate' => 'required|phone',
            ]) ?>
            <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                'class_name' => 'registration-form__input',
                'placeholder' => 'Пароль*',
                'type' => 'password',
                'name' => 'password',
                'id' => 'passSignUp',
                'required' => true,
                'autocomplete' => 'new-password',
                'validate' => 'required|password',
            ]) ?>
            <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                'class_name' => 'registration-form__input',
                'placeholder' => 'Подтвердите пароль*',
                'type' => 'password',
                'name' => 'password_confirmation',
                'id' => 'passSignUpMatch',
                'required' => true,
                'autocomplete' => 'new-password',
                'validate' => 'required|passwordMatch',
            ]) ?>
        </div>

        <div class="registration-form__checkbox-box">
            <?php App\Layout\UIKit\CheckboxPolicy\Layout::draw([
                'checked' => true,
                'required' => true,
                'validate' => 'required|checkbox',
            ]); ?>
        </div>

        <?php App\Layout\Components\Common\Button\Layout::draw([
            'text' => 'Зарегистрироваться',
            'style' => 'primary',
            'class_name' => 'registration-form__button',
            'type' => 'submit',
            'disabled' => true,
        ]); ?>

        <div class="registration-form__auth">
            <a href="/sign-in/" class="registration-form__first-link" draggable="false">
                У меня есть аккаунт
            </a>
            <button type="button" id="switch-to-sign-in-<?= $data['form_id'] ?>"
                    class="registration-form__first-link registration-form__first-link_modal" draggable="false">
                У меня есть аккаунт
            </button>
        </div>
        <div class="registration-form__bottom">
            <p class="registration-form__bottom-text">Или войдите через соцсети</p>
            <?php App\Layout\Components\Common\SocialNetworkToLogin\Layout::draw(); ?>
        </div>

    </form>
</div>