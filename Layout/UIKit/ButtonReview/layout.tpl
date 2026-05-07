<?php
/** @var array $data */ ?>

<?php
extract($data);
$cn = ($style ? "btn-review_style-$style " : '') . $className;
?>

<div
    <?php
    foreach ($attrs as $key => $val): ?>
        <?= "$key='$val'" ?><?php
    endforeach; ?>

        class="btn-review <?= $cn ?>">
    <a href="<?= $href ?>" class="btn-review__link"></a>
    <i class="btn-review__icon btn-review__icon_star">
        <svg viewBox="0 0 20 20">
            <use xlink:href="/assets/icons/svg-defs.svg#star"></use>
        </svg>
    </i>
    <span class="btn-review__rating"><?= $rating ?></span>
    <span class="btn-review__divider"></span>
    <i class="btn-review__icon btn-review__icon_review">
        <svg viewBox="0 0 20 20">
            <use xlink:href="/assets/icons/svg-defs.svg#reviews-mini"></use>
        </svg>
    </i>
    <span class="btn-review__value"><?= $value ?></span>
</div>