<?php
/** @var array $data */ ?>

<?php
extract($data);
$checkedAttr = $checked ? 'checked' : '';
$nameAttr = $name ? "name='$name'" : '';
$requiredAttr = $required ? 'required' : '';

?>
<label class="check-field <?= $className ?>"
    <?php
    foreach ($attrs as $key => $val): ?>
        <?= "$key='$val'" ?><?php
    endforeach; ?>

>
    <input class="check-field__input" type="checkbox" value="<?= $value ?>" <?php
    foreach ($attrs as $key => $val): ?>
        <?= "$key='$val'" ?><?php
    endforeach; ?> <?= $requiredAttr ?> <?= $checkedAttr ?> <?= $nameAttr ?>>
    <?php if ($text): ?>
        <span class="check-field__label"><?= $text ?></span>
    <?php endif; ?>
</label>
