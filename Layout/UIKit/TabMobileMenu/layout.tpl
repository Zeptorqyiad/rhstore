<?php
/** @var array $data */
extract($data);

$cn = "tab-menu_style-$style $className";
$isLink = $asLink ?? false;
?>

<?php if ($isLink): ?>
<a class="tab-menu <?= $cn ?>" href="<?= $href ?>">
    <?php else: ?>
    <div class="tab-menu <?= $cn ?>">
        <?php endif; ?>

        <?php if ($icon): ?>
            <i class="tab-menu__icon tab-menu__icon_custom">
                <svg viewBox="<?= $viewBox ?>">
                    <use xlink:href="/assets/icons/svg-defs.svg#<?= $icon ?>"></use>
                </svg>
            </i>
        <?php endif; ?>

        <span class="tab-menu__text"><?= $text ?></span>

        <?php if ($badge): ?>
            <?php App\Layout\UIKit\Badge\Layout::draw([
                'text' => $badge,
                'style' => 'red',
                'attrs' => [
                    'data-badge' => ''
                ]
            ]); ?>
        <?php endif; ?>

        <?php if ($chevron): ?>
            <i class="tab-menu__icon tab-menu__icon_chevron">
                <svg viewBox="0 0 16 16">
                    <use xlink:href="/assets/icons/svg-defs.svg#chevron"></use>
                </svg>
            </i>
        <?php endif; ?>

        <?php if ($isLink): ?>
</a>
<?php else: ?>
    </div>
<?php endif; ?>
