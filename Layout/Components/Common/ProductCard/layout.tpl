<?php
/** @var array $data */

$type = $data['horizontal'] ? 'product-card_horizontal' : '';
?>

<li class="<?= $data['class_name'] ?> product-card  <?= $type ?>">
    <div class="product-card__slide-top">
        <div class="product-card__image-block">
            <a href="<?= $data['href'] ?>" target="_blank">
                <?php App\Layout\UIKit\Skeleton\Layout::draw(); ?>
                <img data-src="<?= $data['image'] ?>"
                     alt="sl-1"
                     class="product-card__image lazy-image">
            </a>
            <ul class="product-card__badges">
                <?php
                if ($data['new']): ?>
                    <li class="product-card__badge product-card__badge_color-green">
                        New
                    </li>
                <?php
                endif; ?>
                <?php
                if ($data['discount']): ?>
                    <li class="product-card__badge product-card__badge_color-red">
                        -<?= $data['discount'] ?>%
                    </li>
                <?php
                endif; ?>
                <?php
                if ($data['popular']): ?>
                    <li class="product-card__badge product-card__badge_color-blue">
                        Hit
                    </li>
                <?php
                endif; ?>
            </ul>

<!--            <div class="product-card__favorites-box">-->
<!--                --><?php
//                App\Layout\Components\Common\Favorites\Layout::draw([
//                    'class_name' => 'product-card__favorite',
//                    'id' => $data['id'],
//                    'variant' => $data['variant'],
//                    'active' => $data['fav']
//                ]); ?>
<!--            </div>-->
        </div>

        <?php
        if (!$type): ?>
            <a href="<?= $data['href'] ?>" class="product-card__product-name" title="<?= $data['title'] ?>" target="_blank">
                <?= $data['title'] ?>
            </a>
        <?php
        endif; ?>

    </div>

    <div class="product-card__slide-center">
        <?php
        if ($type): ?>
            <a href="<?= $data['href'] ?>" class="product-card__product-name" title="<?= $data['title'] ?>" target="_blank">
                <?= $data['title'] ?>
            </a>
        <?php
        endif; ?>

        <div class="product-card__line">
            <span class="product-card__quantity product-card__quantity-<?= $data['stock_color'] ?>" title="<?= $data['stock'] ?>">
                <?= $data['stock'] ?>
            </span>
            <?php
            if ($data['article']): ?>
                <div class="product-card__spacer"></div><span class="product-card__article" title="Арт: <?= $data['article'] ?>">
                Арт: <?= $data['article'] ?>
            </span>
            <?php
            endif; ?>
        </div>

        <div class="product-card__conditions" data-conditions="<?= $data['conditions'] ?>">
            <?php
            if ($data['conditions']): ?>
                Продается по <?= $data['conditions'] ?> шт.
            <?php
            endif; ?>
        </div>

        <div class="product-card__line-2">
            <?php
            $emptyPrices = false;

            foreach($data['prices'] as $price) {
                if ($price['has_price']) continue;
                $emptyPrices = true;
                break;
            }

            if (!$emptyPrices) {
                $myl = \App\Extensions\Catalog2\Model\PriceLevel::getAuto();
                $myp = 0;

                foreach ($data['prices'] as $pr) {
                    if ($myl->level_ord == $pr['level']) {
                        $myp = $pr['price'];
                    }
                    ?>
                    <div class="product-card__price <?= $myl->level_ord != $pr['level'] ? 'hidden' : '' ?>"
                         data-level="<?= $pr['level'] ?>">
                    <span class="product-card__<?= $pr['has_discount'] ? 'discounted-' : '' ?>price">
                        <?= $pr['price'] ?>
                    </span>
                        <?php
                        if ($pr['has_discount']): ?>
                            <span class="product-card__old-price">
                        <?= $pr['old_price'] ?>
                    </span>
                        <?php
                        endif; ?>
                    </div>
                    <?php
                }
            } else {
                ?>
                <div class="product-card__price">
                    <span class="product-card__price">По уточнению</span>
                </div>
                <?php
            }
            ?>

            <div>
                <?php
                App\Layout\Components\Common\SaleInfo\Layout::draw([
                    'text' => $data['level'],
                    'hint_text' => $data['level_desc'],
                    'class_name' => 'js--mob'
                ]); ?>
            </div>
        </div>

        <div class="product-card__cart-wrap" data-id="<?= $data['id'] ?>" data-variant="<?= $data['variant'] ?>">
            <?php
            App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'В корзину',
                'style' => 'primary',
                'class_name' => 'product-card__button ' . ($data['cartc'] ? 'product-card__button--active' : ''),
                'val' => $data['cartc']
            ]); ?>

            <?php
            App\Layout\Components\Common\QuantityInput\Layout::draw([
                'val' => $data['cartc'],
                'class_name' => $data['cartc'] ? 'product__quantity-input--active' : ''
            ]); ?>
        </div>

    </div>
    <div class="product-card__result" data-id="<?= $data['id'] ?>" data-variant="<?= $data['variant'] ?>">
        <?php
        if (!$data['cartc']): ?>
            <span class="js--cart-sum"></span>
        <?php
        else: ?>
            <span class="js--cart-sum">Стоимость: <?= \Simflex\Core\Helpers\Str::price(
                    $data['cartc'] * $myp
                ) ?></span>
        <?php
        endif; ?>
    </div>
</li>