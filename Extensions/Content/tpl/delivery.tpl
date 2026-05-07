<?php
/** @var array $content */
$conditions = self::getTableFrom('conditions', $content);

?>

<?php
App\Layout\Pages\Delivery\Layout::draw([
    'delivery_title' => $content['params']['delivery_title'],
    'conditions' => $conditions,
    'delivery_subtitle_f' => $content['params']['delivery_subtitle_f'],
    'delivery_subtitle_s' => $content['params']['delivery_subtitle_s'],
    'delivery_text' => $content['params']['delivery_text'],
]);