<?php
/** @var array $data */ ?>

<?php
extract($data);
$placeholder = isset($placeholder) ? e($placeholder) : '';

$cn = "text-area_size-$size $className";
$placeholderAttr = $placeholder ? "placeholder='$placeholder'" : '';
$nameAttr = $name ? "name='$name'" : '';
$typeAttr = $type ? "type='$type'" : '';
$autocompleteAttr = $autocomplete ? "autocomplete='$autocomplete'" : '';
$requiredAttr = $required ? 'required' : '';
$validateAttr = $validate ? "data-validate='$validate'" : '';
?>
<div class="text-area <?= $cn ?>" <?= $validateAttr ?>>
    <label class="text-area__block">
        <textarea class="text-area__input" <?= $placeholderAttr ?> <?= $requiredAttr ?> <?= $typeAttr ?> <?= $nameAttr ?> <?= $autocompleteAttr ?> ></textarea>
        <?php
        if ($icon): ?>
            <i class="text-area__icon">
                <svg viewBox="<?= $viewBox ?>">
                    <use xlink:href="/assets/icons/svg-defs.svg#<?= $icon ?>"></use>
                </svg>
            </i>
        <?php
        endif; ?>
    </label>
    <small class="text-area__message"></small>
</div>