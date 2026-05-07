<?php
/** @var array $content */

$index = $content->loadFrom('/');

$q = App\Extensions\Blog\Model\Blog::findAdv();

$pag = $_REQUEST['page'] ?? 0;

$count = $q->select('count(*)')->fetchScalar();
$items = $q->select('*')->limit('15 offset ' . ($pag * 15))->all();
$items = array_reverse($items);

$newsSlider = self::getTableFrom('blog_news', $content);

App\Layout\Pages\Blog\Layout::draw([
    'count' => $count,
    'pag' => $pag,
    'items' => $items,

    'blog_news' => $newsSlider,

    'faq-section_title' => $index['params']['faq-section_title'],
    'faq-section_text' => $index['params']['faq-section_text'],

    'modal_questions_title' => $index['params']['modal_questions_title'],
    'modal_questions_text' => $index['params']['modal_questions_text'],
]); ?>