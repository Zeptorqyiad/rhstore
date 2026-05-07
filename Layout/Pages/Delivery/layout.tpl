<?php
/** @var array $data */
?>

<?php
//App\Layout\Components\Common\RunningLine\Layout::draw();
App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="delivery">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'delivery__breadcrumbs wrapper',
        'text' => 'Доставка'
    ]);

    App\Layout\Components\Common\HelpNavigation\Layout::draw([
        'class_name' => 'delivery__nav',
        'active_nav' => '2'
    ]);

    App\Layout\Components\InformationBlocks\Delivery\DeliveryContent\Layout::draw([
        'class_name' => 'delivery__content',
        'delivery_title' => $data['delivery_title'],
        'conditions' => $data['conditions'],
        'delivery_subtitle_f' => $data['delivery_subtitle_f'],
        'delivery_subtitle_s' => $data['delivery_subtitle_s'],
        'delivery_text' => $data['delivery_text'],

    ]);
    ?>
</main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
