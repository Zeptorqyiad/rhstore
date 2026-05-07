<?php
/** @var array $data */ ?>

<?php
extract($data);
$cn = "$className " . ($active ? 'btn-menu_active' : '');

?>

<?php if ($href): ?>
    <div class="btn-menu <?= $cn ?>"
        <?php if ($tooltip): ?>
            data-tip="<?= e($tooltip) ?>"
        <?php endif; ?>

        <?php
        foreach ($attrs as $key => $val): ?>
            <?= "$key='$val'" ?><?php
        endforeach; ?>
    >
        <a href="<?= $href ?>" class="btn-menu__link"></a>

        <?php
        if ($badge): ?>
            <?php
            App\Layout\UIKit\Badge\Layout::draw([
                'text' => $badge,
                'style' => 'red',
                'className' => 'btn-menu__badge',
                'attrs' => [
                    'data-badge' => '',
                ]
            ]); ?><?php
        endif; ?>

        <div class="btn-menu__wrapper">
            <i class="btn-menu__icon">
                <svg viewBox="<?= $viewBox ?>">
                    <use xlink:href="/assets/icons/svg-defs.svg#<?= $icon ?>"></use>
                </svg>
            </i>
            <?php
            if ($text): ?>
                <span class="btn-menu__text"><?= e($text) ?></span>
            <?php
            endif; ?>
        </div>
    </div>
<?php else: ?>
    <button class="btn-menu <?= $cn ?>"
        <?php if ($tooltip): ?>
            data-tip="<?= e($tooltip) ?>"
        <?php endif; ?>

        <?php
        foreach ($attrs as $key => $val): ?>
            <?= "$key='$val'" ?><?php
        endforeach; ?>
     >
        <?php
        if ($badge): ?><?php
            App\Layout\UIKit\Badge\Layout::draw([
                'text' => $badge,
                'style' => 'red',
                'className' => 'btn-menu__badge'
            ]); ?><?php
        endif; ?>
        <span class="btn-menu__wrapper">
            <i class="btn-menu__icon">
                <svg viewBox="<?= $viewBox ?>">
                    <use xlink:href="/assets/icons/svg-defs.svg#<?= $icon ?>"></use>
                </svg>
            </i>
            <?php
            if ($text): ?>
                <span class="btn-menu__text"><?= e($text) ?></span>
            <?php
            endif; ?>
        </span>
    </button>
<?php endif; ?>


