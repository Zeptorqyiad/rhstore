<?php App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="my-account">
    <div class="my-account__back">
        <div class="my-account__wrap">
            <?php App\Layout\Components\Common\NavAside\Layout::draw([
                'class_name' => 'my-account__aside',
                'active' => '1'
            ]); ?>

            <div class="my-account__column">
                <?php
                App\Layout\Components\Common\BreadCrumbs\Layout::draw([
                    'class_name' => 'my-account__breadcrumbs',
                    'text' => 'Мой аккаунт'
                ]);
                ?>

                <?php \App\Layout\Components\AccountBlocks\MyAccount\MyAccountContent\Layout::draw([
                    'class_name' => 'my-account__content',
                ]); ?>
            </div>
        </div>
    </div>
</main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw([
    'active_nav' => '4'
]); ?>