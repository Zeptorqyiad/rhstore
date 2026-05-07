<?php
/** @var array $data */
$prod = $data['prod'];
?>

<div class="<?= $data["class_name"] ?> info-tabs" id="content">
    <div class="info-tabs__container">
        <div class="info-tabs__buttons">
            <?php if ($prod->about): ?>
                <button class="info-tabs__button" type="button" data-content="about">О товаре</button>
            <?php endif; ?>
            <button class="info-tabs__button" type="button" data-content="info">Характеристики</button>
            <button class="info-tabs__button" type="button" data-content="delivery">Оплата и доставка</button>
        </div>

        <ul class="info-tabs__content">
            <?php if ($prod->about): ?>
                <li class="info-tabs__item first__property-content ">
                    <?= $prod->about ?>
                </li>
            <?php endif; ?>

            <li class="info-tabs__item first__property-content">
                <?php \App\Layout\Components\Blocks\Product\Specifications\Layout::draw(['prod' => $prod, 'vis_only' => false]); ?>
            </li>

            <li class="info-tabs__item first__property-content info-tabs__item_delivery">
                <?= $data['delivery'] ?>
            </li>
        </ul>
    </div>
</div>