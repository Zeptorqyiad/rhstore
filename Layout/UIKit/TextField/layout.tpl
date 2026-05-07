<?php
/** @var array $data */ ?>

<?php
extract($data);

$cn =  ($size ? "text-field_size-$size " : 'text-field_size-md ') . $className . ($readonly ? ' text-field_read-only ' : '');

//$value = isset($value) ? e($value) : '';

$valueAttr = $value ? "value='$value'" : '';
$placeholderAttr = $placeholder ? "placeholder='$placeholder'" : '';
$nameAttr = $name ? "name='$name'" : '';
$typeAttr = $type ? "type='$type'" : 'type=text';
$autocompleteAttr = $autocomplete ? "autocomplete='$autocomplete'" : '';
$requiredAttr = $required ? 'required' : '';
$minAttr = $min ? "min='$min'" : '';
$maxAttr = $max ? "max='$max'" : '';
$readonlyAttr = $readonly ? 'readonly' : '';
$validateAttr = $validate ? "data-validate='$validate'" : '';

?>
<div class="text-field <?= $cn ?>" <?= $validateAttr ?> >
    <label class="text-field__block">
        <input <?= $readonlyAttr ?> <?= $valueAttr ?> <?= $minAttr ?> <?= $maxAttr ?> <?= $placeholderAttr ?>
            <?= $requiredAttr ?> <?= $typeAttr ?> <?= $nameAttr ?> <?= $autocompleteAttr ?> <?= $dataAttr ?>
                class="text-field__input">
        <?php
        if ($icon): ?>
            <i class="text-field__icon">
                <svg viewBox="<?= $viewBox ?>">
                    <use xlink:href="/assets/icons/svg-defs.svg#<?= $icon ?>"></use>
                </svg>
            </i>
        <?php
        endif; ?>
    </label>
    <small class="text-field__message"></small>
</div>