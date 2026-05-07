<?php
/** @var array $data */ ?>

<?php
extract($data);
?>
<div class="link-file">
    <a href="<?= $path ?>" target="_blank" download class="link-file__link"></a>
    <i class="link-file__icon">
        <svg viewBox="0 0 24 24">
            <use xlink:href="/assets/icons/svg-defs.svg#list-download"></use>
        </svg>
    </i>
    <span class="link-file__title"><?= $text ?></span>
    <span class="link-file__size"><?= $size ?></span>
</div>