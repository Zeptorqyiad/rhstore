<?php
/** @var array $data */

App\Layout\Components\Common\RunningLine\Layout::draw();
App\Layout\Components\HeaderBlock\Header\Layout::draw();
?>

<main class="main">
    <?php
    App\Layout\Components\Blocks\Main\MainBanner\Layout::draw([
        'class_name' => 'main__banner',
        'title' => 'Скидка 20%',
        'red_title' => 'на первый заказ',
        'text' => 'Совершите свой первый оптовый заказ защитных стёкол и получите скидку 20%',
        'button_text' => 'Получить скидку'
    ]);

    App\Layout\Components\Promo\PromoSlider\Layout::draw();

    App\Layout\Components\Blocks\Main\MainBrands\Layout::draw([
        'class_name' => 'main__brands',
        'title' => 'Комплектующие на все популярные модели',
        'text' => 'В нашем каталоге есть все комплектующие на актуальные модели устройств',
        'badges' =>
            array_map(fn($b) => ['text' => $b->name, 'link' => '/catalog/?brand[]=' . $b->brand_id],
                array_filter(\App\Extensions\Catalog\Model\Brand::all(), function ($b) {
                    return \Simflex\Core\DB::result(
                        'select count(*) from catalog_product where brand_id = ?',
                        0,
                        [$b->brand_id]
                    );
                })),
    ]);

    App\Layout\Components\Blocks\Main\MainCategory\Layout::draw([
//        'cat' => $cat,
        'class_name' => 'main__category',
    ]);

    App\Layout\Components\Blocks\Main\MainAbout\Layout::draw([
        'class_name' => 'main__about',
        'main-about_title_f' => $data['main-about_title_f'],
        'main-about_text_f' => $data['main-about_text_f'],
        'main-about_title_s' => $data['main-about_title_s'],
        'main-about_text_s' => $data['main-about_text_s'],
        'main-about_title_t' => $data['main-about_title_t'],
        'main-about_text_t' => $data['main-about_text_t'],
    ]);

    $q = App\Extensions\Blog\Model\Blog::findAdv();
    $items = $q->select('*')->limit(15)->orderBy('npp desc')->all();
    App\Layout\Components\Blocks\Main\MainNewsSlider\Layout::draw([
        'class_name' => 'main__news-slider',
        'title' => 'Новости и статьи',
        'cards' => $items,
    ]);
    App\Layout\Components\Blocks\Main\MainInfo\Layout::draw([
        'class_name' => 'main__info'
    ]);
    App\Layout\Components\Common\FaqSection\Layout::draw([
        'class_name' => 'main__faq',
        'faq-section_title' => $data['faq-section_title'],
        'faq-section_text' => $data['faq-section_text'],
    ]);
    App\Layout\Components\Common\SeoSection\Layout::draw([
        'seo_title_1' => $data['seo_title_1'],
        'seo_text_1' => $data['seo_text_1'],
        'seo_title_2' => $data['seo_title_2'],
        'seo_text_2' => $data['seo_text_2'],
    ]); ?>
</main>

<?php
App\Layout\Components\Common\Footer\Layout::draw(); ?>

<?php
App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw([
    'active_nav' => '1'
]); ?>

<?php
App\Layout\Components\Modals\ModalQuestions\Layout::draw([
    'modal_questions_title' => $data['modal_questions_title'],
    'modal_questions_text' => $data['modal_questions_text'],
]); ?>

