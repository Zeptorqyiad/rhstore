<?php App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

    <main class="sign-in">
        <div class="sign-in__container wrapper">
            <?php App\Layout\Components\Common\BreadCrumbs\Layout::draw([
                'class_name' => 'sign-in-breadcrumbs',
                'text' => 'Авторизация'
            ]); ?>


            <div class="sign-in__content">
<!--                --><?php //App\Layout\Components\Common\StepsLine\Layout::draw([
//                    'step' => '1',
//                    'class_name' => 'sign-in__steps'
//                ]); ?>

                <?php \App\Layout\Components\AccountBlocks\SignIn\AuthorizationForm\Layout::draw([
                    'class_name' => 'sign-in__card'
                ]);
                ?>
            </div>
        </div>
    </main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>