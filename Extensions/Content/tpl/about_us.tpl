<?php

$advantages = self::getTableFrom('advantages_cards', $content);
$manufacturers = self::getTableFrom('manufacturers_cards', $content);
$slides = self::getTableFrom('slides', $content);
$index = $content->loadFrom('/');

App\Layout\Pages\AboutUs\Layout::draw([
    'about-us_title' => $content['params']['about-us_title'],
    'about-us_description' => $content['params']['about-us_description'],

    'approach_title' => $content['params']['approach_title'],
    'approach_description_f' => $content['params']['approach_description_f'],
    'approach_description_s' => $content['params']['approach_description_s'],
    'about-us_f-square' => $content['params']['about-us_f-square'],

    'advantages_title' => $content['params']['advantages_title'],
    'advantages' => $advantages,

    'approach__f-top' => $content['params']['approach__f-top'],
    'approach__f-middle' => $content['params']['approach__f-middle'],
    'approach__f-bottom' => $content['params']['approach__f-bottom'],
    'approach__s-top' => $content['params']['approach__s-top'],
    'approach__s-middle' => $content['params']['approach__s-middle'],
    'approach__s-bottom' => $content['params']['approach__s-bottom'],
    'approach__t-top' => $content['params']['approach__t-top'],
    'approach__t-middle' => $content['params']['approach__t-middle'],
    'approach__t-bottom' => $content['params']['approach__t-bottom'],
    'f_slide_right' => '/uf/images/source/' . $content['params']['f_slide_right'],
    's_slide_right' => '/uf/images/source/' . $content['params']['s_slide_right'],
    'f_slide_left' => '/uf/images/source/' . $content['params']['f_slide_left'],
    's_slide_left' => '/uf/images/source/' . $content['params']['s_slide_left'],
    'approach_img' => '/uf/images/source/' . $content['params']['approach_img'],

    'manufacturer_title' => $content['params']['manufacturer_title'],
    'manufacturer_text' => $content['params']['manufacturer_text'],
    'manufacturers' => $manufacturers,
    'manufacturer_f-img' => '/uf/images/source/' . $content['params']['manufacturer_f-img'],
    'manufacturer_s-img' => '/uf/images/source/' . $content['params']['manufacturer_s-img'],

    'about-us-slider_title' => $content['params']['about-us-slider_title'],
    'slides' => $slides,

    'faq-section_title' => $index['params']['faq-section_title'],
    'faq-section_text' => $index['params']['faq-section_text'],

    'about-us_seo_title' => $content['params']['about-us_seo_title'],
    'about-us_seo_text' => $content['params']['about-us_seo_text'],
    'about-us_seo_title-s' => $content['params']['about-us_seo_title-s'],
    'about-us_seo_text-s' => $content['params']['about-us_seo_text-s'],

    'modal_questions_title' => $index['params']['modal_questions_title'],
    'modal_questions_text' => $index['params']['modal_questions_text'],
]);