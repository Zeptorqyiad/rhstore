<?php

App\Layout\Components\Common\RunningLine\Layout::draw(); ?>

<?php

/** @var \App\Extensions\Catalog\Model\Category $cat */
$cat = $data['cat'];
$count = $cat->getProductCount($data['f']);

App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="catalog">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'catalog__breadcrumbs wrapper',
        'text' => $cat->name,
    ]);
    ?>

    <?php
    App\Layout\Components\Blocks\Catalog\CatalogBox\Layout::draw([
        'class_name' => 'catalog__box',
        'title' => $cat->name,
        'cat' => $cat,
        'fav' => $data['fav'],
        'f' => $data['f'],
        's' => $data['s'],
        'minp' => $data['minp'],
        'maxp' => $data['maxp'],
        'th' => $data['th'],
        'is_search' => $data['is_search'],
        'hide_cats' => $data['hide_cats'],
    ]); ?>
    <?php
    App\Layout\Components\Common\Advantages\Layout::draw([
    'class_name' => 'catalog__advantages',
    'advantages_title' => $data['catalog_advantages_title'],
        'advantages' => $data['why_us']
    ]);?>

    <?php
    App\Layout\Components\Common\MailingList\Layout::draw([
        'class_name' => 'catalog__mailing'
    ]); ?>

    <?php
    App\Layout\Components\Common\SeoSection\Layout::draw([
        'seo_title_1' => $data['seo_title_1'],
        'seo_text_1' => $data['seo_text_1'],
        'seo_title_2' => $data['seo_title_2'],
        'seo_text_2' => $data['seo_text_2'],
    ]); ?>

    <?php
    App\Layout\Components\Menus\Filter\Layout::draw([
        $cat,
        [
            'pmin' => $data['minp'],
            'pmax' => $data['maxp'],
        ],
        'th' => $data['th'],
    ]); ?>
</main>

<?php
App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php
App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw([
    'active_nav' => '2'
]); ?>

<?php App\Layout\Components\Other\Onboarding\Layout::draw([
        'onboarding_slides' => $data['onboarding_slides'],
]); ?>

