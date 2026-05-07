<?php
/** @var array $data */

?>

<div class="<?= $data['class_name'] ?> catalog-card">
    <div class="catalog-card__image-block">
        <a href="<?= $data['href'] ?>" draggable="false" target="_blank">
            <?php App\Layout\UIKit\Skeleton\Layout::draw(); ?>
            <img data-src="<?= $data['image'] ?>"
                 alt="sl-1"
                 class="catalog-card__image lazy-image" draggable="false" loading="lazy">
        </a>
        <ul class="catalog-card__badges">
            <?php
            if ($data['new']): ?>
                <li class="catalog-card__badge catalog-card__badge_color-green">
                    New
                </li>
            <?php
            endif; ?>
            <?php
            if ($data['discount']): ?>
                <li class="catalog-card__badge catalog-card__badge_color-red">
                    -<?= $data['discount'] ?>%
                </li>
            <?php
            endif; ?>
            <?php
            if ($data['popular']): ?>
                <li class="catalog-card__badge catalog-card__badge_color-blue">
                    Hit
                </li>
            <?php
            endif; ?>
        </ul>
    </div>

    <div class="catalog-card__left-text">
        <a href="<?= $data['href'] ?>" class="catalog-card__product-name" title="<?= $data['title'] ?>"
           draggable="false" target="_blank">
            <?= $data['title'] ?>
        </a>

        <div class="catalog-card__line">
            <div class="catalog-card__quantity catalog-card__quantity-<?= $data['stock_color'] ?>"
                 title="<?= $data['stock'] ?>">
                <?= $data['stock'] ?>
            </div>

            <?php
            if ($data['article']): ?>
                <div class="catalog-card__spacer"></div>
                <div class="catalog-card__article" title="Арт: <?= $data['article'] ?>">
                    Арт: <?= $data['article'] ?>
                </div>
            <?php
            endif; ?>
            <?php
            if ($data['conditions']): ?>
                <div class="catalog-card__spacer"></div>
                <div class="catalog-card__conditions" data-conditions="<?= $data['conditions'] ?>">
                    По <?= $data['conditions'] ?> шт.

                    <div class="catalog-card__conditions-hint-box">
                        <svg viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                  d="M13 7C13 10.3137 10.3137 13 7 13C3.68629 13 1 10.3137 1 7C1 3.68629 3.68629 1 7 1C10.3137 1 13 3.68629 13 7ZM8 4C8 4.55228 7.55228 5 7 5C6.44772 5 6 4.55228 6 4C6 3.44772 6.44772 3 7 3C7.55228 3 8 3.44772 8 4ZM7 6C6.44772 6 6 6.44772 6 7V10C6 10.5523 6.44772 11 7 11C7.55228 11 8 10.5523 8 10V7C8 6.44772 7.55228 6 7 6Z"
                                  fill="#404040"/>
                        </svg>
                        <div class="catalog-card__conditions-hint">
                            <p class="catalog-card__conditions-hint-text">
                                Товар отправляется упаковками (по <?= $data['conditions'] ?> шт.)
                            </p>
                        </div>
                    </div>
                </div>
            <?php
            endif; ?>
        </div>
    </div>

    <?php
    $emptyPrices = false;

    foreach($data['prices'] as $price) {
        if ($price['has_price']) continue;
        $emptyPrices = true;
        break;
    }
    ?>

    <?php if (!$emptyPrices): ?>
        <ul class="catalog-card__prices">
            <?php
            $level = \App\Extensions\Catalog2\Model\PriceLevel::getAuto();
            // get levels above
            $levels = \Simflex\Core\Buffer::getOrSet(
                'alllevels',
                fn() => \App\Extensions\Catalog2\Model\PriceLevel::findAdv()->orderBy(
                    'level_ord'
                )->all()
            );

            $user = \Simflex\Core\Container::getUser();
            $ul = $user ? $user->getLevel() : (object)['level_ord' => 0];

            foreach ($data['prices'] as $pd):
                $lvl = $pd['level'];

                $hide = false;
                if (($data['cart'] ?? false) && $level->level_ord != $pd['level']) {
                    $hide = true;
                }

//                $hide = false;
//                if ($data['cart'] ?? false) {
//                    if ($level->level_ord != $lvl) {
//                        $hide = true;
//                    }
//                } else {
//                    if ($lvl == 4 && $level->level_ord < 3) {
//                        $hide = true;
//                    }
//
//                    if ($lvl == 0 && $level->level_ord >= 3) {
//                        $hide = true;
//                    }
//
//                    if ($lvl <= 1 && $level->level_ord == 4) {
//                        $hide = true;
//                    }
//                }

                ?>
                <li data-level="<?= $pd['level'] ?>"
                    class="catalog-card__price
<!--                    --><?php //= $pd['level'] >= 3 && $pd['level'] > $ul->level_ord ? 'blur' : '' ?><!-- -->
                    <?= ($hide ? ' hide ' : '') ?>
                    <?= ($pd['level'] != $level->level_ord ? ' inactive ' : '') ?>"
                >
                    <?php
                    if ($pd['has_discount']): ?>
                        <span class="catalog-card__old-price" title="<?= $pd['old_price'] ?>">
                    <?= $pd['old_price'] ?>
                </span>
                    <?php
                    endif; ?>
                    <span class="catalog-card__<?= $pd['has_discount'] ? 'discounted' : 'primary' ?>-price"
                          title="<?= $pd['price'] ?>">
                    <?= $pd['price'] ?>
                </span>
                </li>
            <?php
            endforeach; ?>
        </ul>
    <?php else: ?>
        <div class="catalog-card__prices-empty">
            <span class="catalog-card__primary-price">По уточнению</span>
        </div>
    <?php endif; ?>

    <div class="catalog-card__controls" data-id="<?= $data['id'] ?>" data-variant="<?= $data['variant'] ?>"
         data-count="<?= $data['cartc'] ?>">
        <?php
        if (method_exists(\App\Extensions\Catalog\SessionAssist::$cart, 'getProduct')) {
            $cp = \App\Extensions\Catalog\SessionAssist::$cart?->getProduct(
                $data['id']
            );
        } else {
            $cp = null;
        }

        App\Layout\Components\Common\QuantityInput\Layout::draw([
            'class_name' => 'catalog-card__quantity-input',
            'val' => $data['cartc'] ?: '',
            'sum' => $cp ? $cp['sum_actual'] : '',
        ]); ?>
        <div class="catalog-card__quantity-none"><span>Нет в наличии</span></div>
        <?php
        App\Layout\Components\Common\AddButton\Layout::draw([
            'class_name' => $data['cartc'] ? 'catalog-card__add-button--active' : 'catalog-card__add-button'
        ]); ?>
    </div>

<!--    --><?php
//    App\Layout\Components\Common\Favorites\Layout::draw([
//        'class_name' => 'catalog-card__favorites-button',
//        'id' => $data['id'],
//        'variant' => $data['variant'],
//        'active' => $data['fav']
//    ]); ?>
</div>