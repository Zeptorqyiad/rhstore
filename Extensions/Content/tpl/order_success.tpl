<?php App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="sign-in">
    <div class="sign-in__container wrapper">
        <?php
        App\Layout\Components\Common\BreadCrumbs\Layout::draw([
            'class_name' => 'sign-in-breadcrumbs',
            'text' => 'Заказ оформлен'
        ]);
        ?>

        <?php App\Layout\Components\AccountBlocks\OrderSuccess\Layout::draw() ?>
    </div>
</main>

<script>
    window.onload = function() {
        history.replaceState(null, '', '/user/order/success');

        window.addEventListener('popstate', function() {
            window.location.href = '/';
        });
    };
</script>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
