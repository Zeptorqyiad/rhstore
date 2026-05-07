<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> textarea">
    <textarea <?= $data['required'] ? 'required' : '' ?>
            id="<?= $data['id'] ?? $data['name'] ?>"
            name="<?= $data['name'] ?>"
            placeholder=" "
            class="textarea__input"><?= trim($data['value'] ?? '') ?></textarea>
    <label class="textarea__label">
        <?= $data["placeholder"] ?>
    </label>
</div>