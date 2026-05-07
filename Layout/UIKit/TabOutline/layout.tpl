<?php

/** @var array $data */
extract($data);
$cn = ($style ? "tab-outline_style-$style " : 'tab-outline_style-primary ') . ($active ? 'tab-outline_active ' : '') . $className;
$attrs ??= [];

?>
<div class="tab-outline <?= $cn ?>" <?php foreach ($attrs as $k => $v) echo $k, '="', $v, '" ' ?>>
    <?php
    if ($href): ?>
        <a href="<?= $href ?>" class="tab-outline__link"></a>
    <?php
    endif; ?>
    <?php
    if ($icon): ?>
        <i class="tab-outline__icon tab-outline__icon_left">
            <svg viewBox="<?= $viewBox ?>">
                <use xlink:href="/assets/icons/svg-defs.svg#<?= $icon ?>"></use>
            </svg>
        </i>
    <?php
    endif; ?>
    <span class="tab-outline__text"><?= $text ?></span>
    <?php
    App\Layout\UIKit\Badge\Layout::draw([
        'text' => $badge,
        'style' => 'red',
        'attrs' => [
            'style' => $badge ? '' : 'display:none',
        ]
    ]); ?>
    <?php
    if ($chevron): ?>
        <i class="tab-outline__icon tab-outline__icon_right">
            <svg viewBox="0 0 20 20">
                <use xlink:href="/assets/icons/svg-defs.svg#arrow-up"></use>
            </svg>
        </i>
    <?php
    endif; ?>
</div>