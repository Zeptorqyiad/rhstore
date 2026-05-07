<?php

/** @var array $data */
extract($data);
$nameAttr = $name ? "name='$name'" : '';
$checkedAttr = $checked ? 'checked' : '';
?>

<label class="<?= $data["class_name"] ?> toggle">
    <input type="checkbox"
           class="toggle__checkbox" <?= $value ? ('value="' . $value . '"') : '' ?> <?= $nameAttr ?> <?= $checkedAttr ?>>
    <span class="toggle__box"></span>
    <span class="toggle__circle-box">
        <span class="toggle__circle"></span>
    </span>
</label>