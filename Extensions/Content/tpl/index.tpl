<?php
/** @var array $content */

?>

<?php App\Layout\Pages\Main\Layout::draw([
    'modal_questions_title' => $content['params']['modal_questions_title'],
    'modal_questions_text' => $content['params']['modal_questions_text'],

    'faq-section_title' => $content['params']['faq-section_title'],
    'faq-section_text' => $content['params']['faq-section_text'],

    'seo_title_1' => $content['params']['seo_title_1'],
    'seo_text_1' => $content['params']['seo_text_1'],
    'seo_title_2' => $content['params']['seo_title_2'],
    'seo_text_2' => $content['params']['seo_text_2'],


    'main-about_title_f' => $content['params']['main-about_title_f'],
    'main-about_text_f' => $content['params']['main-about_text_f'],
    'main-about_title_s' => $content['params']['main-about_title_s'],
    'main-about_text_s' => $content['params']['main-about_text_s'],
    'main-about_title_t' => $content['params']['main-about_title_t'],
    'main-about_text_t' => $content['params']['main-about_text_t'],


]); ?>


