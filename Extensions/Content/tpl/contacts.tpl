<?php
/** @var array $content */
$index = $content->loadFrom('/');

App\Layout\Pages\Contacts\Layout::draw([
    'faq-section_title' => $index['params']['faq-section_title'],
    'faq-section_text' => $index['params']['faq-section_text'],

    'modal_questions_title' => $index['params']['modal_questions_title'],
    'modal_questions_text' => $index['params']['modal_questions_text'],

    'contacts_title' => $content['contacts_title'],
    'connections_text' => $content['params']['connections_text'],
    'contacts_bottom_text' => $content['params']['contacts_bottom_text'],

    'map_title' => $content['params']['map_title']
]);


