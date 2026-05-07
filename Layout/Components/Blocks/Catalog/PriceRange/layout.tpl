<?php
/** @var array $data */

?>

<div class="price-range">
    <span class="price-range__title">Цена</span>
    <div class="price-range__slider">
        <span class="price-range__selected" style="left: 0%; right: 0%;"></span>
    </div>
    <div class="price-range__input">
        <input class="price-range__input--min min"
               type="range" min="<?= round((int)$data['price_min']) ?>"
               max="<?= round((int)($_REQUEST['price_max'] ?: $data['price_max'])) ?>"
               value="<?= round((int)($_REQUEST['price_min'] ?: $data['price_min'])) ?>"
               step="10">
        <input class="price-range__input--max max"
               type="range"
               min="<?= round((int)$data['price_min']) ?>"
               max="<?= round((int)$data['price_max']) ?>"
               value="<?= round((int)($_REQUEST['price_max'] ?: $data['price_max'])) ?>"
               step="10">
    </div>
    <div class="price-range__price">
        <label class="form-control-price">
            <span class="form-control-price__text">от</span>
            <input type="number"
                   name="price_min"
                   min="<?= round((int)$data['price_min']) ?? 0 ?>"
                   value="<?= $_REQUEST['price_min'] ?? '' ?>"
                   placeholder="<?= round((int)($_REQUEST['price_min'] ?: $data['price_min'])) ?>"
                   class="form-control-price__input--min form-control-price__input min">
        </label>
        <label class="form-control-price">
            <span class="form-control-price__text">до</span>
            <input type="number"
                   name="price_max"
                   max="<?= round((int)$data['price_max']) ?>"
                   value="<?= $_REQUEST['price_max'] ?? '' ?>"
                   placeholder="<?= round((int)($_REQUEST['price_max'] ?: $data['price_max'])) ?>"
                   class="form-control-price__input--max form-control-price__input max">
        </label>
    </div>
</div>