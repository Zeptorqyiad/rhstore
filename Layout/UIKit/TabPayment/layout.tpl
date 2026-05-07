<?php

/** @var array $data */
extract($data);
$cn = ($active ? 'tab-payment_active' : '') . ' ' . $className;

?>
<div
    <?php
    foreach ($attrs as $key => $val): ?>
        <?= "$key='$val'" ?><?php
    endforeach; ?>
    class="tab-payment <?= $cn ?>">
    <?php
    if ($icon): ?>
        <i class="tab-payment__icon">
            <svg viewBox="<?= $viewBox ?: '0 0 24 24' ?>">
                <use xlink:href="/assets/icons/svg-defs.svg#<?= $icon ?>"></use>
            </svg>
        </i>
    <?php
    endif; ?>
    <span class="tab-payment__text">
        <?= $text ?>
    </span>
</div>