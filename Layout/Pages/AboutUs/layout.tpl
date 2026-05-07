<?php

/** @var array $data */

?>

<?php
App\Layout\Components\HeaderBlock\Header\Layout::draw();
?>

<main class="about-us">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'about-us__breadcrumbs wrapper',
        'text' => 'О нас'
    ]);
    App\Layout\Components\Blocks\AboutUs\AboutUsBanner\Layout::draw([
        'about-us_title' => $data['about-us_title'],
        'about-us_description' => $data['about-us_description'],
        'about-us_img' => $data['about-us_img'],
        'class_name' => 'about-us__a-banner',
    ]);
    App\Layout\Components\Blocks\AboutUs\AboutUsApproach\Layout::draw([
        'approach_title' => $data['approach_title'],
        'approach_description_f' => $data['approach_description_f'],
        'approach_description_s' => $data['approach_description_s'],
        'approaches' => $data['approaches'],
        'class_name' => 'about-us__approach',
        'approach__f-top' => $data['approach__f-top'],
        'approach__f-middle' => $data['approach__f-middle'],
        'approach__f-bottom' => $data['approach__f-bottom'],
        'approach__s-top' => $data['approach__s-top'],
        'approach__s-middle' => $data['approach__s-middle'],
        'approach__s-bottom' => $data['approach__s-bottom'],
        'approach__t-top' => $data['approach__t-top'],
        'approach__t-middle' => $data['approach__t-middle'],
        'approach__t-bottom' => $data['approach__t-bottom'],
        'f_slide_right' => $data['f_slide_right'],
        's_slide_right' => $data['s_slide_right'],
        'f_slide_left' => $data['f_slide_left'],
        's_slide_left' => $data['s_slide_left'],
        'approach_img' => $data['approach_img'],
    ]);
    App\Layout\Components\Common\Advantages\Layout::draw([
        'class_name' => 'about-us__advantages',
        'advantages' => $data['advantages'],
        'advantages_title' => $data['advantages_title'],
    ]);
    App\Layout\Components\Blocks\AboutUs\Manufacturer\Layout::draw([
        'class_name' => 'about-us__manufacturer',
        'manufacturers' => $data['manufacturers'],
        'manufacturer_title' => $data['manufacturer_title'],
        'manufacturer_text' => $data['manufacturer_text'],
        'manufacturer_f-img' => $data['manufacturer_f-img'],
        'manufacturer_s-img' => $data['manufacturer_s-img'],

    ]);
    if (!empty($data['slides'])) {
    App\Layout\Components\Blocks\AboutUs\AbouUsSlider\Layout::draw([
        'class_name' => 'about-us__slider',
        'slides' => $data['slides'],
        'about-us-slider_title' => $data['about-us-slider_title'],
    ]);
    }
    App\Layout\Components\Common\FaqSection\Layout::draw([
        'class_name' => 'about-us__faq',
        'faq-section_title' => $data['faq-section_title'],
        'faq-section_text' => $data['faq-section_text'],
    ]);
    ?>
</main>
<?php
App\Layout\Components\Common\SeoSection\Layout::draw([
    'seo_title' => $data['about-us_seo_title'],
    'seo_text' => $data['about-us_seo_text'],
    'seo_title-s' => $data['about-us_seo_title-s'],
    'seo_text-s' => $data['about-us_seo_text-s'],
]); ?>
<?php
App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php
App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
<?php App\Layout\Components\Modals\ModalQuestions\Layout::draw([
    'modal_questions_title' => $data['modal_questions_title'],
    'modal_questions_text' => $data['modal_questions_text'],
]); ?>
