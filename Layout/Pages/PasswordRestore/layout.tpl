<?php App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="password-restore">
    <form class="password-restore__form wrapper" action="" method="post" data-validate>
        <h1 class="password-restore__title">Восстановление пароля</h1>
        <div class="password-restore__inputs">
            <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                'class_name' => 'password-restore__input password-restore__input-pass',
                'placeholder' => 'Введите новый пароль*',
                'type' => 'password',
                'name' => 'password',
                'id' => 'passRestore',
                'required' => true,
                'autocomplete' => 'new-password',
                'validate' => 'required|password',
            ]); ?>
            <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                'class_name' => 'password-restore__input password-restore__input-check',
                'placeholder' => 'Подтвердите пароль*',
                'type' => 'password',
                'name' => 'password_check',
                'id' => 'passRestoreCheck',
                'required' => true,
                'autocomplete' => 'new-password',
                'validate' => 'required|passwordMatch',
            ]); ?>
            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Подтвердить',
                'style' => 'primary',
                'class_name' => 'password-restore__submit submit-disabled',
                'type' => 'submit',
                'disabled' => true,
            ]); ?>
        </div>
    </form>
</main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>