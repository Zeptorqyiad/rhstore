<?php
/** @var array $data */

$cn = "button-" . $data["style"];
$cn .= $data["class_name"] ? ' ' . $data["class_name"] : '';
?>

<div class="<?= $cn ?> quantity-input product__quantity-input">
    <button type="button" class="quantity-input__button-minus" data-action="minus">
        <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10" viewBox="0 0 10 10">
            <rect y="6" width="2" height="10" rx="1" transform="rotate(-90 0 6)"/>
        </svg>
    </button>

    <label for="" class="quantity-input__label product__purchase-label">
        <input type="text" placeholder="Кол-во" value="<?= $data['val'] ?>" data-qty>
    </label>

    <button type="button" class="quantity-input__button-plus" data-action="plus">
        <svg xmlns="http://www.w3.org/2000/svg" width="10" height="10" viewBox="0 0 10 10">
            <rect x="4" width="2" height="10" rx="1"/>
            <rect y="6" width="2" height="10" rx="1" transform="rotate(-90 0 6)"/>
        </svg>
    </button>

    <span class="quantity-input__amount <?= $data['sum'] ? 'visible' : '' ?>">
        Стоимость: <span class="quantity-input__amount-total"
                         data-amount="<?= $data['sum'] ?>"><?= $data['sum'] ? \Simflex\Core\Helpers\Str::price(
                $data['sum']
            ) : '' ?></span>
    </span>
</div>

