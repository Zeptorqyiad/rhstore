<?php
/** @var array $content */

App\Layout\Pages\Policy\Layout::draw([
    'policy_title' => $content['params']['policy_title'],
    'policy_content' => $content['params']['policy_content'],
]);