<?php
/** @var array $data */ ?>

<?php
extract($data);
$cn  = " $className " . ($active ? 'btn-tap_current-active' : '');

?>
<?php if ($asLink): ?>
    <a class="btn-tap <?= $cn ?>" href="<?= $href ?>">
        <span class="btn-tap__bg"></span>
        <?php
        if ($badge) {
            App\Layout\UIKit\Badge\Layout::draw([
                'text' => $badge,
                'style' => 'red',
                'className' => 'btn-tap__badge',
            ]);
        }
        ?>
        <i class="btn-tap__icon">
            <svg viewBox="<?= $viewBox ?>">
                <use xlink:href="/assets/icons/svg-defs.svg#<?= $icon ?>"></use>
            </svg>
        </i>
    </a>
<?php else: ?>
    <button class="btn-tap <?= $cn ?>" type="button">
        <span class="btn-tap__bg"></span>
        <?php
        if ($badge) {
            App\Layout\UIKit\Badge\Layout::draw([
                'text' => $badge,
                'style' => 'red',
                'className' => 'btn-tap__badge'
            ]);
        }
        ?>
        <i class="btn-tap__icon">
            <svg viewBox="<?= $viewBox ?>">
                <use xlink:href="/assets/icons/svg-defs.svg#<?= $icon ?>"></use>
            </svg>
        </i>
    </button>
<?php endif; ?>
