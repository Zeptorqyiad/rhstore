<?php
/** @var array $data */
if (count($data['items'])):
?>

<div class="<?= $data["class_name"] ?> checkbox-list">
    <p class="checkbox-list__text">
        <?= $data["title"] ?>
    </p>

    <?php
    $itemCount = count($data['items']);
    if ($data["is_search"] && $itemCount >= 5) {
        App\Layout\Components\Common\TextField\Layout::draw([
            'class_name' => 'checkbox-list__text-field',
            'placeholder' => 'Поиск'
        ]);
    }
    ?>

    <ul class="checkbox-list__checkboxes">
        <?php
        foreach ($data['items'] as $item): ?>
            <li class="checkbox-list__item">
                <?php
                App\Layout\Components\Common\Checkbox\Layout::draw([
                    'text' => $item['text'],
                    'class_name' => 'checkbox-list__check',
                    'name' => $item['name'],
                    'value' => $item['value'],
                    'checked' => $item['checked'],
                    'link' => $item['link'] ?? null,
                    'path' => $item['path'] ?? null,
                ]); ?>
            </li>
        <?php
        endforeach; ?>
    </ul>

    <?php
    $itemCount = count($data['items']);
    if ($data["is_search"] && $itemCount >= 5): ?>
        <button type="button" class="checkbox-list__button">
            Показать все
        </button>
    <?php
    endif; ?>
</div>
<?php endif; ?>