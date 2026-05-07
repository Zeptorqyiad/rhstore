<?php
/** @var array $data */
$prod = $data['prod'];
?>

<div class="<?= $data["class_name"] ?> about-product">
    <ul class="about-product__container">

        <?php if ($prod->desc): ?>
            <li class="about-product__item about-product__item_line">
                <div class="about-product__item-top">
                    <p class="about-product__item-name">О товаре</p>
                    <a data-id="about" href="#content" class="about-product__item-link
                 first__property-anchor first-anchor" data-id="about">Подробнее</a>
                </div>
                <div class="about-product__item-bottom">
                    <?= $prod->desc ?>
                </div>

                <div class="about-product__item-button-box">
                    <?php App\Layout\Components\Common\Button\Layout::draw([
                        'text' => 'Подробнее о товаре',
                        'style' => 'gray',
                        'class_name' => 'about-product__item-button about-button',
                        'icon' => true,
                        'modal' => 'modal-property-about'
                    ]); ?>
                </div>
            </li>
        <?php endif; ?>

        <li class="about-product__item">
            <div class="about-product__item-top">
                <p class="about-product__item-name">Характеристики</p>
                <a href="#content" class="about-product__item-link" data-id="info">Подробнее</a>
            </div>
            <div class="about-product__item-bottom">
                <?php \App\Layout\Components\Blocks\Product\Specifications\Layout::draw([
                    'prod' => $prod
                ]); ?>
            </div>

            <div class="about-product__item-button-box about-product__item-button-box_no-border">
                <?php App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Подробные характеристики',
                    'style' => 'gray',
                    'class_name' => 'about-product__item-button info-button',
                    'icon' => true,
                    'modal' => 'modal-property-info'
                ]); ?>
            </div>
        </li>

        <li class="about-product__item about-product__item_line">
            <div class="about-product__item-top">
                <p class="about-product__item-name">Доставка</p>
                <a href="#content" class="about-product__item-link" data-id="delivery">Подробнее</a>
            </div>
            <div class="about-product__item-bottom">
                <?= $data['delivery'] ?>
            </div>

            <div class="about-product__item-button-box">
                <?php App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Подробнее о доставке и оплате',
                    'style' => 'gray',
                    'class_name' => 'about-product__item-button delivery-button',
                    'icon' => true,
                    'modal' => 'modal-property-delivery'
                ]); ?>
            </div>
        </li>


    </ul>
</div>