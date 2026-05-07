<?php

/** @var array $data */
extract($data);
$cn = " " . ($active ? 'tab-u-menu_active' : '') . " $className ";

?>

<a href="<?= $href ?>" class="tab-u-menu <?= $cn ?>">
    <?php if ($icon): ?>
        <i class="tab-u-menu__icon tab-u-menu__icon_custom">
            <svg viewBox="<?= $viewBox || '0 0 20 20' ?>">
                <use xlink:href="/assets/icons/svg-defs.svg#<?= $icon ?>"></use>
            </svg>
        </i>
    <?php endif; ?>
    <span class="tab-u-menu__text"><?= $text ?></span>
    <?php
    if ($active): ?>
        <span class="tab-u-menu__dot"></span>
    <?php
    endif; ?>
    <i class="tab-u-menu__icon tab-u-menu__icon_chevron">
        <svg viewBox="0 0 24 24">
            <use xlink:href="/assets/icons/svg-defs.svg#arrow"></use>
        </svg>
    </i>
</a>