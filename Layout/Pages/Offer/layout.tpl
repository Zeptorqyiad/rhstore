<?php
/** @var array $data */
?>

<?php //App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="offer">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'offer__breadcrumbs wrapper',
        'text' => 'Оферта'
    ]);

    App\Layout\Components\Common\HelpNavigation\Layout::draw([
        'class_name' => 'offer__nav',
        'active_nav' => '6'
    ]);

    App\Layout\Components\InformationBlocks\Offer\OfferContent\Layout::draw([
        'class_name' => 'offer__content',
        'offer_title' => $data['offer_title'],
        'offer_items' => $data['offer_items'],
        'offer_blocks' => $data['offer_blocks'],
    ]);
    ?>
</main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
