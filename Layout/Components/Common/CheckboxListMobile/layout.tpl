<?php
/** @var array $data */
?>
<?php foreach ($data['items'] as $item): ?>
<div class="<?= $data["class_name"] ?> checkbox-list-mobile">
    <p class="checkbox-list__text">
        <?= $item["text"] ?>
    </p>

    <ul class="checkbox-list-mobile__checkboxes">

            <li class="checkbox-list-mobile__item">
                <?php App\Layout\Components\Common\Checkbox\Layout::draw([
                    'text' => $item['text'],
                    'class_name' => 'checkbox-mobile-list__check',
                    'name' => $item['name'],
                    'value' => $item['value'],
                    'checked' => $item['checked'],
                ]); ?>
            </li>
    </ul>

</div>
<?php endforeach; ?>