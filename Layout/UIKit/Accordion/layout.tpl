<?php
/** @var array $data */ ?>

<?php
extract($data);
$cn = " $className " . ($active ? 'accordion_active' : '');
?>
<div class="accordion <?= $cn ?>">
    <div class="accordion__top">
        <h4 class="accordion__title"><?= $title ?></h4>
        <button class="accordion__toggle">
            <svg viewBox="0 0 24 24">
                <use xlink:href="/assets/icons/svg-defs.svg#arrow"></use>
            </svg>
        </button>
    </div>
    <div class="accordion__body">
        <div>
            <?= $text ?>
        </div>
    </div>
</div>
