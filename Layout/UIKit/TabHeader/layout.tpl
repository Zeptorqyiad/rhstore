<?php /** @var array $data */

extract($data);
$tag = $asLink ? 'a' : 'div';
$href = $asLink ? "href='$href'" : '';


?>


<<?= $tag ?> class="tab-header <?= $className ?>" <?= $href ?>>
    <?php if ($iconLeft): ?>
        <i class="tab-header__icon tab-header__icon_left">
            <svg viewBox="<?= $viewBox ?>">
                <use xlink:href="/assets/icons/svg-defs.svg#<?= $iconLeft ?>"></use>
            </svg>
        </i>
    <?php endif; ?>
    <span class="tab-header__text"><?= $text ?></span>
    <?php if ($iconRight): ?>
        <i class="tab-header__icon tab-header__icon_right">
            <svg viewBox="<?= $viewBox ?>">
                <use xlink:href="/assets/icons/svg-defs.svg#<?= $iconRight ?>"></use>
            </svg>
        </i>
    <?php endif; ?>
</<?= $tag ?>>