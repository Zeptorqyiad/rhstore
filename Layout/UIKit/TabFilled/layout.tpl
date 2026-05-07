<?php
/** @var array $data */

extract($data);
$cn = "tab-filled_size-$size tab-filled_style-$style tab-filled_icon-$iconPos $className";

?>
<div
    <?php
    foreach ($attrs as $key => $val): ?>
        <?= "$key='$val'" ?><?php
    endforeach; ?>
        class="tab-filled <?= $cn ?>">

    <?php
    if ($href): ?>
        <a class="tab-filled__link" <?= $blank ? 'target="_blank"' : '' ?> href="<?= $href ?>"></a>
    <?php
    endif; ?>

    <?php
    if ($iconPos == 'left'): ?>
        <i class="tab-filled__icon tab-filled__icon_left">
            <svg viewBox="<?= $viewBox ?: '0 0 24 24' ?>">
                <use xlink:href="/assets/icons/svg-defs.svg#<?= $icon ?: 'arrow' ?>"></use>
            </svg>
        </i>
    <?php
    endif; ?>

    <span class="tab-filled__text">
        <?= $text ?>
    </span>

    <?php
    if ($iconPos == 'right'): ?>
        <i class="tab-filled__icon tab-filled__icon_right">
            <svg viewBox="<?= $viewBox ?: '0 0 24 24' ?>">
                <use xlink:href="/assets/icons/svg-defs.svg#<?= $icon ?: 'arrow' ?>"></use>
            </svg>
        </i>
    <?php
    endif; ?>
</div>