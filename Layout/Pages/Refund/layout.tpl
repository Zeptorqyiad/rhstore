<?php
/** @var array $data */

?>

<?php //App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="refund">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'refund__breadcrumbs wrapper',
        'text' => 'Возврат'
    ]);

    App\Layout\Components\Common\HelpNavigation\Layout::draw([
        'class_name' => 'refund__nav',
        'active_nav' => '4'
    ]);

    App\Layout\Components\InformationBlocks\Refund\RefundContent\Layout::draw([
        'class_name' => 'refund__content',
        'refund_title' => $data['refund_title'],
        'refunds' => $data['refunds'],
    ]);
    ?>
</main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
