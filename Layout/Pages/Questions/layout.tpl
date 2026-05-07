<?php
/** @var array $data */

?>

<?php //App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="questions">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'questions__breadcrumbs wrapper',
        'text' => 'Доставка'
    ]);

    App\Layout\Components\Common\HelpNavigation\Layout::draw([
        'class_name' => 'questions__nav',
        'active_nav' => '5'
    ]);

    App\Layout\Components\InformationBlocks\Questions\QuestionsContent\Layout::draw([
        'class_name' => 'questions__content',
        'title' => $data['questions_title'],
    ]);

//    App\Layout\Components\InformationBlocks\FrequentQuestions\FrequentQuestionsContent\Layout::draw([
//        'class_name' => 'questions__content',
//    ]);
    ?>
</main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
