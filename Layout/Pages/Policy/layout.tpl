<?php
/** @var array $data */

//App\Layout\Components\Common\RunningLine\Layout::draw();
App\Layout\Components\HeaderBlock\Header\Layout::draw();
?>

<main class="policy">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'policy__breadcrumbs wrapper',
        'text' => 'Политика'
    ]);

    App\Layout\Components\Common\HelpNavigation\Layout::draw([
        'class_name' => 'policy__nav',
        'active_nav' => '7'
    ]);

    App\Layout\Components\InformationBlocks\Politics\PoliticsContent\Layout::draw([
        'class_name' => 'policy__content',
        'policy_title' => $data['policy_title'],
        'policy_content' => $data['policy_content'],
    ]);
    ?>
</main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
