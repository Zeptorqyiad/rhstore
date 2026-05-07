<?php
/** @var array $data */ ?>

<?php
extract($data);

?>

<button class="btn-info <?= $className ?>">
    <span class="btn-info__text"><?= $text ?></span>

    <?php if ($subtext): ?>
        <span class="btn-info__divider"></span>
        <div class="btn-info__subtext"><?= $subtext ?></div>
    <?php endif; ?>

    <i class="btn-info__icon">
        <svg viewBox="0 0 16 16">
            <use xlink:href="/assets/icons/svg-defs.svg#arrow-mini"></use>
        </svg>
    </i>
</button>