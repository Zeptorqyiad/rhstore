<?php

/** @var array $data */
extract($data);

$checkedAttr = $checked ? 'checked' : '';
$inputValue = $value ?? '';

$filename = basename($template);

$trimmedTemplate = str_replace('.tpl', '', $filename);

$trimmedTemplate = pathinfo($template, PATHINFO_FILENAME);
?>

<div class="order-type-card card-type_<?= $trimmedTemplate ?>">
    <div class="order-type-card__wrapper">
        <label class="order-type-card__radio-button order-type-card_<?= $type ?>">
            <input data-id="<?= $value ?>" <?= $checkedAttr ?> type="radio"
                   name="<?= $input_name ?>"
                   value="<?= $inputValue ?>">
            <span class="order-type-card__radio-mark"></span>
            <div class="order-type-card__radio-item-wrapper">
                <span class="order-type-card__radio-item-type"><?= $name ?></span>
                <span class="order-type-card__radio-item-description"><?= $desc ?></span>

                <?php
                if (!empty($price)): ?>
                    <span class="order-type-card__radio-item-price"><?= $price ?></span>
                <?php
                endif; ?>
            </div>
        </label>
    </div>

    <?php
    if ($template) {
        include SF_ROOT_PATH . '/Layout/' . $template;
    } ?>
</div>
