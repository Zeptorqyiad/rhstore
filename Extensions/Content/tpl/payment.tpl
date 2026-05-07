<?php
/** @var array $content */

$reqs = self::getTableFrom('reqs', $content);
?>

<?php
App\Layout\Pages\Payment\Layout::draw([
    'payment_title' => $content['params']['payment_title'],
    'payment_subtitle_f' => $content['params']['payment_subtitle_f'],
    'payment_text_f' => $content['params']['payment_text_f'],
    'payment_req_title' => $content['params']['payment_req_title'],
    'reqs' => $reqs,
    'payment_subtitle_s' => $content['params']['payment_subtitle_s'],
    'payment_text_s' => $content['params']['payment_text_s'],
]);