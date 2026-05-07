<?php

/** @var array $data */
$user = \Simflex\Core\Container::getUser();
?>

<form action="" method="post" id="my-account-forms">
    <ul class="<?= $data["class_name"] ?> my-account-forms">
        <li class="my-account-forms__card my-account-forms__first-card">
            <p class="my-account-forms__card-title">
                Персональные данные
            </p>
            <p class="my-account-forms__card-text">
                Эти данные нужны, чтобы мы знали, кому отправлять заказ
            </p>

            <div class="my-account-forms__inputs">
                <?php
                App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'my-account-forms__input',
                    'placeholder' => 'Имя*',
                    'val' => $user->name,
                    'name' => 'name',
                    'required' => true,
                ]) ?>
                <?php
                App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'my-account-forms__input',
                    'placeholder' => 'Фамилия*',
                    'val' => $user->last_name,
                    'name' => 'last_name',
                    'required' => true,
                ]) ?>
                <?php
                App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'my-account-forms__input',
                    'placeholder' => 'Е-mail*',
                    'val' => $user->email,
                    'name' => 'email',
                    'required' => true,
                ]) ?>
                <?php
                App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'my-account-forms__input',
                    'placeholder' => 'Телефон*',
                    'val' => $user->phone,
                    'name' => 'phone',
                    'required' => true,
                ]) ?>
            </div>

            <?php App\Layout\UIKit\OrganizationSelect\Layout::draw(); ?>
        </li>

        <li class="my-account-forms__card my-account-forms__second-card">
            <p class="my-account-forms__card-title">
                Получатель
            </p>
            <p class="my-account-forms__card-text">
                Эти данные нужны, чтобы мы знали, кому отправлять заказ
            </p>

            <div class="my-account-forms__inputs">
                <?php
                App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'my-account-forms__input',
                    'placeholder' => 'Фамилия*',
                    'val' => $user->other_last_name,
                    'name' => 'other_last_name',
                ]) ?>
                <?php
                App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'my-account-forms__input',
                    'placeholder' => 'Имя*',
                    'val' => $user->other_name,
                    'name' => 'other_name',
                ]) ?>
                <?php
                App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'my-account-forms__input',
                    'placeholder' => 'Телефон*',
                    'val' => $user->other_phone,
                    'name' => 'other_phone',
                ]) ?>
                <?php
                App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'my-account-forms__input',
                    'placeholder' => 'E-mail*',
                    'val' => $user->other_email,
                    'name' => 'other_email',
                ]) ?>
            </div>
        </li>

        <li class="my-account-forms__card my-account-forms__third-card">
            <p class="my-account-forms__card-title">
                Реквизиты
            </p>

            <div class="my-account-forms__inputs">
                <?php
                App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'my-account-forms__input',
                    'placeholder' => 'Р/С*',
                    'name' => 'org_account',
                    'val' => $user->org_account,
                ]) ?>
                <?php
                App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'my-account-forms__input',
                    'placeholder' => 'БИК банка*',
                    'name' => 'org_bic',
                    'val' => $user->org_bic,
                ]) ?>
            </div>
        </li>

        <li class="my-account-forms__card my-account-forms__fourth-card">
            <p class="my-account-forms__card-title">
                Адрес доставки
            </p>

            <div class="my-account-forms__inputs">

                <?php App\Layout\UIKit\CitySelector\Layout::draw(); ?>

                <?php
                App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'my-account-forms__input',
                    'placeholder' => 'Адрес*',
                    'val' => $user->address,
                    'name' => 'address',
                ]) ?>
            </div>
        </li>

        <li class="my-account-forms__card my-account-forms__fifth-card">
            <p class="my-account-forms__card-title">
                Изменить пароль
            </p>
            <p class="my-account-forms__card-text">
                Придумайте пароль: минимум 6 символов, обязательно цифры и буквы на любом языке
            </p>

            <div class="my-account-forms__inputs">
                <?php
                App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'my-account-forms__input my-account-forms__input_pass',
                    'placeholder' => 'Пароль*',
                    'name' => 'password',
                    'autocomplete' => 'new-password',
                ]) ?>
                <?php
                App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'my-account-forms__input my-account-forms__input_pass_confirm',
                    'placeholder' => 'Подтвердите пароль*',
                    'name' => 'password_check',
                    'autocomplete' => 'new-password',
                ]) ?>
            </div>
        </li>

        <li class="my-account-forms__box-bottom">
            <h3 class="my-account-forms__box-bottom-text">
                Подписки
            </h3>

            <div class="my-account-forms__box-bottom-checkbox">
                <?php
                App\Layout\Components\Common\Checkbox\Layout::draw([
                    'class_name' => 'my-account-forms__checkbox',
                    'text' => 'Хочу получать уведомления про акции и новинки',
                    'value' => 1,
                    'checked' => $user->in_mailing,
                    'name' => 'in_mailing'
                ]); ?>
            </div>

            <div class="my-account-forms__box-bottom-buttons">
                <?php
                App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Сохранить',
                    'style' => 'primary',
                    'class_name' => 'my-account-forms__button my-account-forms__submit ',
                    'type' => 'submit'
                ]); ?>
                <p class="my-account-forms__changes hidden">Есть изменения</p>
            </div>
        </li>
    </ul>
</form>