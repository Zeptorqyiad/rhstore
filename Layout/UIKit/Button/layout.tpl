<?php
/** @var array $data */ ?>

<?php
/*
 * Props:
 *    Style: Gray | Secondary
 *    Size: Small | Medium
 */

extract($data);

$cn = "$className btn btn_style-$style btn_size-$size " . ($iconCenter ? 'btn_icon-center ' : '') . ($iconRight ? 'btn_icon-right ' : '') . ($iconLeft ? 'btn_icon-left ' : '');
$disabledAttr = $disabled ? 'disabled' : '';
$typeAttr = $type ? "type='$type'" : '';
$tooltipAttr = $tooltip ? "data-tip='$tooltip'" : '';
$tooltipPosAttr = $tooltipPos ? "data-tip-pos='$tooltipPos'" : '';

?>

<?php
if (!$asLink): ?>
    <button
        <?php
        foreach ($attrs as $key => $val): ?>
            <?= "$key='$val'" ?><?php
        endforeach; ?>
        class="<?= $cn ?>" <?= $tooltipAttr ?>  <?= $tooltipPosAttr ?> <?= $disabledAttr ?> <?= $typeAttr ?>>
        <?php
        if ($iconCenter): ?>
            <i class="btn__icon btn__icon_center">
                <svg viewBox="<?= $viewBox ?>">
                    <use xlink:href="/assets/icons/svg-defs.svg#<?= $iconCenter ?>"></use>
                </svg>
            </i>
        <?php
        else: ?><?php
            if ($iconLeft): ?>
                <i class="btn__icon btn__icon_left">
                    <svg viewBox="<?= $viewBox ?>">
                        <use xlink:href="/assets/icons/svg-defs.svg#<?= $iconLeft ?>"></use>
                    </svg>
                </i>
            <?php
            endif; ?>
            <span class="btn__text"><?= $text ?></span>
            <?php
            if ($iconRight): ?>
                <i class="btn__icon btn__icon_right">
                    <svg viewBox="<?= $viewBox ?>">
                        <use xlink:href="/assets/icons/svg-defs.svg#<?= $iconRight ?>"></use>
                    </svg>
                </i>
            <?php
            endif; ?><?php
        endif; ?>
    </button>
<?php
else: ?>
    <a class="btn <?= $cn ?>" <?= $tooltipAttr ?> <?= $tooltipPosAttr ?> <?= $disabledAttr ?> <?= $typeAttr ?> <?php
    foreach ($attrs as $key => $val): ?>
        <?= "$key='$val'" ?><?php
    endforeach; ?>
       href="<?= $href ?>">
        <?php
        if ($iconCenter): ?>
            <i class="btn__icon btn__icon_center">
                <svg viewBox="<?= $viewBox ?>">
                    <use xlink:href="/assets/icons/svg-defs.svg#<?= $iconCenter ?>"></use>
                </svg>
            </i>
        <?php
        else: ?><?php
            if ($iconLeft): ?>
                <i class="btn__icon btn__icon_left">
                    <svg viewBox="<?= $viewBox ?>">
                        <use xlink:href="/assets/icons/svg-defs.svg#<?= $iconLeft ?>"></use>
                    </svg>
                </i>
            <?php
            endif; ?>
            <span class="btn__text"><?= $text ?></span>
            <?php
            if ($iconRight): ?>
                <i class="btn__icon btn__icon_right">
                    <svg viewBox="<?= $viewBox ?>">
                        <use xlink:href="/assets/icons/svg-defs.svg#<?= $iconRight ?>"></use>
                    </svg>
                </i>
            <?php
            endif; ?><?php
        endif; ?>
    </a>
<?php
endif; ?>
