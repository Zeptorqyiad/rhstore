<?php
/** @var array $data */

?>

<ul class="<?= $data["class_name"] ?> toggle-list-mobile">
    <?php
    foreach ($data['items'] as $item): ?>

        <li class="toggle-list-mobile__item">
            <div class="toggle-list-mobile__text <?= ($item["style_variant"] ? " toggle-list__text_color_red" : '') ?>">
                <span class="toggle-list-mobile__first"><?= $item["text"] ?></span>
                <?php
                if ($item["hint"]): ?>
                    <p class="toggle-list-mobile__subtext"><?= $item["hint"] ?></p>
                <?php
                endif; ?>
            </div>
            <?php
            App\Layout\Components\Common\Toggle\Layout::draw([
                'name' => $item['name'],
                'checked' => $item['active'],
                'value' => $item['value'],
            ]); ?>
        </li>

    <?php
    endforeach; ?>
</ul>