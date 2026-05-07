<?php App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php App\Layout\Components\HeaderBlock\Header\Layout::draw();?>

<main class="sign-up">
    <div class="sign-up__container wrapper">
        <?php
        App\Layout\Components\Common\BreadCrumbs\Layout::draw([
            'class_name' => 'sign-up-breadcrumbs',
            'text' => 'Авторизация'
        ]);
        ?>

        <div class="sign-up__content">
            <?php App\Layout\Components\Common\StepsLine\Layout::draw([
                'step' => '1',
                'class_name' => 'sign-up__steps'
            ]);

            App\Layout\Components\AccountBlocks\SignUp\RegistrationForm\Layout::draw([
                'class_name' => 'sign-up__card'
            ]);
            ?>
        </div>
    </div>
</main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>