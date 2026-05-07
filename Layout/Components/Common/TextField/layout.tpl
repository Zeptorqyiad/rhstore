<?php
/** @var array $data */
$autocomplete = $data['autocomplete'] ? 'autocomplete="' . $data['autocomplete'] . '"' : '';
$required = $data['required'] ? 'required' : '';
$validate = $data['validate'] ?? '';
?>

<div class="<?= $data["class_name"] ?> text-field">
    <label>
        <input
                class="text-field__input"
                type="<?= $data["type"] ?? 'text' ?>"
                placeholder="<?= $data["placeholder"] ?>"
                value="<?= $data['value'] ?>"
                name="<?= $data["name"] ?>"
                tabindex="1"
            <?= $required ?>
            <?= $autocomplete ?>
            <?= $validate ? 'data-validate="' . $validate . '"' : '' ?>
        >
        <?php
        if ($data["hint"]): ?>
            <span class="text-field__span">
                <?= $data["hint"] ?>
            </span>
        <?php
        endif; ?>
    </label>

    <span class="text-field__label">
         <?= $data["label"] ?>
    </span>
</div>