<?php
/** @var array $content */

$refunds = self::getTableFrom('refunds', $content);
?>

<?php App\Layout\Pages\Refund\Layout::draw([
    'refund_title' => $content['params']['refund_title'],
    'refunds' => $refunds,
]);