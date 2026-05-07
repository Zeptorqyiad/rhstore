<?php
/** @var array $data */

?>

<?php
//App\Layout\Components\Common\RunningLine\Layout::draw();
App\Layout\Components\HeaderBlock\Header\Layout::draw();
?>

<main class="contacts">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'contacts__breadcrumbs wrapper',
        'text' => 'Контакты'
    ]);
    ?>
    <div class="contacts__container">
        <h1 class="contacts__title">
            <?= $data["contacts_title"] ?>
        </h1>
        <div class="contacts__box">
            <?php
            App\Layout\Components\Blocks\Contacts\ContactsConnection\Layout::draw([
                'contacts_title' => $data['contacts_title'],
                'connections_text' => $data['connections_text'],
                'contacts_bottom_text' => $data['contacts_bottom_text'],
            ]); ?><?php
            App\Layout\Components\Blocks\Contacts\ContactsMap\Layout::draw([
                'class_name' => 'contacts__map',
                'map_title' => $data['map_title']
            ]); ?>
        </div>
    </div>
    <?php
    App\Layout\Components\Common\FaqSection\Layout::draw([
        'class_name' => 'contacts__faq',
        'faq-section_title' => $data['faq-section_title'],
        'faq-section_text' => $data['faq-section_text'],
    ]); ?>
</main>

<?php
App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php
App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
<?php
App\Layout\Components\Modals\ModalQuestions\Layout::draw([
    'modal_questions_title' => $data['modal_questions_title'],
    'modal_questions_text' => $data['modal_questions_text'],
]); ?>
