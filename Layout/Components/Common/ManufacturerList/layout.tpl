<?php
/** @var array $data */
?>

<ul class="manufacturer__list">
    <?php
    foreach ($data['manufacturers'] as $manufacturer)
        App\Layout\Components\Common\ManufacturerCard\Layout::draw([
            'class_name' => 'advantages__card',
            'title' => $manufacturer['title'],
            'text' => $manufacturer['text'],
        ]);
    ?>
</ul>
