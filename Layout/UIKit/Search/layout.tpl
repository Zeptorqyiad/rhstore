<?php
/** @var array $data */ ?>

<?php
extract($data);


?>
<form class="search <?= $className ?>" <?= $noAct ? '' : 'action="/search/"' ?>>
    <i class="search__icon search__icon_search">
        <svg viewBox="0 0 24 24">
            <use xlink:href="/assets/icons/svg-defs.svg#search"></use>
        </svg>
    </i>
    <label class="search__label">
        <input placeholder="<?= $placeholder ?>" value="<?= e($value) ?>" name="q" type="search" class="search__input">
    </label>
    <button type="reset" class="search__icon search__icon_reset">
        <svg viewBox="0 0 24 24">
            <use xlink:href="/assets/icons/svg-defs.svg#close"></use>
        </svg>
    </button>
</form>