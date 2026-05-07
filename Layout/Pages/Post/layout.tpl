<?php
/** @var array $data */
$rows = json_decode($data['content'], true)['v'] ?? [];
$firstRow = $rows[0];
$post = $data['post'];
?>

<?php //App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main>
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'delivery__breadcrumbs wrapper',
        'text' => 'статья'
    ]); ?>
    <?php
    App\Layout\Components\Other\Post\Layout::draw([
        'title' => $post->name,
        'description' => $post->short,
        'image_big' => '/uf/images/source/' . $post->photo_big,
        'image_mob' => '/uf/images/source/' . $post->photo_mob,
        'content' => $post->content,
        'date' => $post->date,
        'label' => $post->category->name,
    ]); ?>

    <?php App\Layout\Components\Common\FaqSection\Layout::draw([
        'class_name' => 'post__faq',
    ]); ?>

</main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
<?php App\Layout\Components\Modals\ModalQuestions\Layout::draw([
    'modal_questions_title' => $data['modal_questions_title'],
    'modal_questions_text' => $data['modal_questions_text'],
]); ?>
