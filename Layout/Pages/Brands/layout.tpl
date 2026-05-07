<?php
/** @var array $data */

?>

<?php //App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="brands">
<?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'brands__breadcrumbs wrapper',
        'text' => 'Бренды'
    ]);

    App\Layout\Components\Blocks\Brands\BrandsBanner\Layout::draw([
        'class_name' => 'brands__banner',
        'brands_title' => $data['brands_title'],
        'brands_text' => $data['brands_text'],
    ]);

    App\Layout\Components\Blocks\Brands\BrandsCards\Layout::draw([
        'class_name' => 'brands__cards',
        'cards' => $data['brands_cards'],
    ]);
   App\Layout\Components\Common\SeoSection\Layout::draw([
    'seo_title' => $data['brands_seo_title'],
    'seo_text' => $data['brands_seo_text'],
    'seo_title-s' => $data['brands_seo_title-s'],
    'seo_text-s' => $data['brands_seo_text-s'],
    ]);
?>
</main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php
App\Layout\Components\Modals\ModalQuestions\Layout::draw([
    'modal_questions_title' => $data['modal_questions_title'],
    'modal_questions_text' => $data['modal_questions_text'],
]); ?>
