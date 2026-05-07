<?php
/** @var array $content */

$guarantees = self::getTableFrom('guarantees', $content);

?>

<?php
App\Layout\Pages\Guarantees\Layout::draw([
    'guarantees_title' => $content['params']['guarantees_title'],
    'guarantees' => $guarantees,
]);