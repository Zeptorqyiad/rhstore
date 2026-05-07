<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> authorization-form" id="sign-in-form-<?= $data['form_id'] ?>">
    <form class="authorization-form__form" action="" novalidate data-validate>
        <h3 class="authorization-form__title">
            Вход в личный кабинет
        </h3>

        <div class="authorization-form__inputs">
            <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                'class_name' => 'authorization-form__input',
                'placeholder' => 'E-mail*',
                'name' => 'email',
                'id' => 'emailSignIn',
                'required' => true,
                'autocomplete' => 'email',
                'validate' => 'required|email',
            ]) ?>
            <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                'class_name' => 'authorization-form__input',
                'placeholder' => 'Пароль*',
                'name' => 'password',
                'type' => 'password',
                'id' => 'passSignIn',
                'required' => true,
                'autocomplete' => 'current-password',
                'validate' => 'required|password',
            ]) ?>
        </div>

        <?php App\Layout\Components\Common\Button\Layout::draw([
            'text' => 'Войти',
            'style' => 'primary',
            'class_name' => 'authorization-form__button',
            'type' => 'submit',
        ]); ?>

        <div class="authorization-form__links">
            <a href="/sign-up/" class="authorization-form__first-link">
                Регистрация
            </a>
            <button type="button" id="switch-to-sign-up-<?= $data['form_id'] ?>" class="authorization-form__first-link authorization-form__first-link_modal">
                Регистрация
            </button>
            <button type="button" class="authorization-form__second-link" onclick="restoreModal(event)">
                Забыли пароль?
            </button>
        </div>
        <div class="authorization-form__bottom">
            <p class="authorization-form__bottom-text">
                Или войдите через соцсети
            </p>

            <?php App\Layout\Components\Common\SocialNetworkToLogin\Layout::draw(); ?>
        </div>

    </form>
</div>