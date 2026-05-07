<?php
/** @var array $data */

?>

<ul class="<?= $data["class_name"] ?> toggle-list">
    <?php foreach ($data['items'] as $item): ?>

        <li class="toggle-list__item">
            <div class="toggle-list__text <?= ($item["style_variant"] ? " toggle-list__text_color_red" : '') ?>">
                <?= $item["text"] ?>

                <?php
                if ($item["hint"]): ?>
                    <div class="toggle-list__hint">
                        <svg viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                  d="M13 7C13 10.3137 10.3137 13 7 13C3.68629 13 1 10.3137 1 7C1 3.68629 3.68629 1 7 1C10.3137 1 13 3.68629 13 7ZM8 4C8 4.55228 7.55228 5 7 5C6.44772 5 6 4.55228 6 4C6 3.44772 6.44772 3 7 3C7.55228 3 8 3.44772 8 4ZM7 6C6.44772 6 6 6.44772 6 7V10C6 10.5523 6.44772 11 7 11C7.55228 11 8 10.5523 8 10V7C8 6.44772 7.55228 6 7 6Z"
                                  fill="#404040"/>
                        </svg>
                        <div class="toggle-list__hint-box">
                            <p class="toggle-list__hint-text">
                                <?= $item["hint"] ?>
                            </p>
                        </div>
                    </div>
                <?php
                endif; ?>

            </div>
            <?php
            App\Layout\Components\Common\Toggle\Layout::draw([
                'name' => $item['name'],
                'checked' => $item['checked'],
                'value' => $item['value'],
            ]); ?>
        </li>

    <?php endforeach; ?>
</ul>