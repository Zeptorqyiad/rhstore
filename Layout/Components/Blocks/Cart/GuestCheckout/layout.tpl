<?php
/** @var array $data */

?>

<div class="g-checkout">
    <div class="g-checkout__container wrapper">
        <?php
        App\Layout\Components\Common\BreadCrumbs\Layout::draw([
            'class_name' => 'sign-in-breadcrumbs',
        ]);

        App\Layout\Components\AccountBlocks\OrderCheckout\Layout::draw();
        ?>
    </div>
</div>