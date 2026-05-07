<?php

$s = '';
$sort = $_REQUEST['sort'] ?? 'new';
switch ($sort) {
    case 'new':
        $s = 'date';
        break;
    case 'old':
        $s = 'date desc';
        break;
    case 'ans':
        $s = 'length(reply) desc';
        break;
    case 'nop':
        $s = 'length(reply)';
        break;
}

$pag = $_REQUEST['page'] ?? 0;
App\Layout\Pages\AskQuestions\Layout::draw([
    'cards' => array_map(fn($q) => [
        'name' => e($q->title),
        'date' => \Simflex\Core\Time::user($q->date),
        'q' => e(strip_tags($q->txt)),
        'a' => $q->reply,
    ],
        \App\Extensions\Catalog\Model\Question::findActive()->where(
            ['user_id' => \Simflex\Core\Container::getUser()->user_id]
        )->limit('5 offset ' . ($pag * 5))->orderBy($s)->all()),
]);