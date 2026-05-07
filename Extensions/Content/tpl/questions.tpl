<?php
/** @var array $content */

?>

<?php

App\Layout\Pages\Questions\Layout::draw([
    'questions_title' => $content['params']['questions_title'],
]);