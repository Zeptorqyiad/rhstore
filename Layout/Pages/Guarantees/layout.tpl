<?php
/** @var array $data */

?>

<?php //App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="guarantees">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'guarantees__breadcrumbs wrapper',
        'text' => 'Гарантии'
    ]);

    App\Layout\Components\Common\HelpNavigation\Layout::draw([
        'class_name' => 'guarantees__nav',
        'active_nav' => '3'
    ]);

    App\Layout\Components\InformationBlocks\Guarantees\GuaranteesContent\Layout::draw([
        'class_name' => 'guarantees__content',
        'guarantees_title' => $data['guarantees_title'],
        'guarantees' => $data['guarantees'],
    ]);
    ?>
</main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
