<?php
/** @var array $data */

?>

<?php //App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="company-news">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'company-news__breadcrumbs wrapper',
        'text' => 'Новости'
    ]);
    ?>

    <h1 class="company-news__title wrapper">
        Новости
    </h1>


    <?php if (!empty($data['blog_news'])) {
        App\Layout\Components\Blocks\CompanyNews\CompanyNewsSlider\Layout::draw([
            'class_name' => 'company-news__slider',
            'blog_news' => $data['blog_news'],
        ]);
    }
    ?>

    <ul class="company-news__cards wrapper">
        <?php foreach ($data['items'] as $c) {
            App\Layout\Components\Common\BlogCard\Layout::draw([
                'type' => $c->category->name,
                'image' => '/uf/images/source/' . $c->photo,
                'text' => $c->short,
                'date' => $c->date,
                'label' => $c->category->name,
                'link' => '/blog/' . $c->alias . '/',
            ]);
        } ?>

    </ul>
    <?php
    App\Layout\UIKit\Pagination\Layout::draw([
        'link' => '/blog/',
        'page' => $data['pag'],
        'hasPrev' => !!$data['pag'],
        'pages' => $data['count'] / 20,
        'hasNext' => $data['pag'] < ($data['count'] / 20) - 2,
        'className' => 'blog-pagination'
    ]); ?>

    <?php App\Layout\Components\Common\FaqSection\Layout::draw([
        'class_name' => 'company-news__faq',
        'faq-section_title' => $data['faq-section_title'],
        'faq-section_text' => $data['faq-section_text'],
    ]); ?>
</main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>

<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
<?php App\Layout\Components\Modals\ModalQuestions\Layout::draw([
    'modal_questions_title' => $data['modal_questions_title'],
    'modal_questions_text' => $data['modal_questions_text'],
]); ?>
