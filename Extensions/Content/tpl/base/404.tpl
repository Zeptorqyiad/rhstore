<?php App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main>
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'wrapper',
        'text' => 'Новости'
    ]);
    ?>
    <?php App\Layout\Components\Other\NotFound\Layout::draw(); ?>

</main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>