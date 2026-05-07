<?php
/** @var array $content */
$offer_items = self::getTableFrom('offer_items', $content);

?>

<?php
App\Layout\Pages\Offer\Layout::draw([
    'offer_items' => $offer_items,
    'offer_title' => $content['params']['offer_title'],
    'offer_blocks' => $content['params']['offer_blocks'],
]);