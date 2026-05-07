<?php
/** @var array $data */ ?>

<?php
extract($data);

/*
 * Sizes: Big, Small, Smaller, Page, TapBar
 * States: Default | Active | Out Of Stock
 */
$cn = ($size ? "buy-block_size-$size " : 'buy-block_size-big') . ($state ? " buy-block_state-$state " : '') . $className;
$v ??= $_REQUEST['v'] ?? 0;

?>

<div class="buy-block <?= $cn ?> <?= $data['inCart'] ? 'buy-block_active' : '' ?>" data-id="<?= $data['id'] ?>"
     data-variant="<?= $v ?>">

    <?php
    if ($state == 'out-of-stock'): ?>

        <?php
        App\Layout\UIKit\Button\Layout::draw([
            'size' => 'medium',
            'style' => 'secondary',
            'text' => 'Оставить заявку',
            'className' => 'buy-block__btn-stock',
            'attrs' => [
                'data-action' => 'out-of-stock',
                'style' => 'width: 100%',
                'data-name' => $name
            ]
        ]); ?>

    <?php
    else: ?>

        <?php
        if ($size == 'page'): ?>

            <?php
            App\Layout\UIKit\Button\Layout::draw([
                'text' => 'В корзину',
                'style' => 'primary',
                'viewBox' => '0 0 20 20',
                'iconLeft' => 'cart-mini',
                'size' => 'medium',
                'className' => 'buy-block__btn-add',
                'attrs' => [
                    'data-action' => 'add-to-cart',
                    'data-id' => $data['id'],
                    'data-variant' => $v
                ]
            ]); ?>

            <div class="buy-block__quantity">
                <?php
                App\Layout\UIKit\Button\Layout::draw([
                    'iconCenter' => 'minus',
                    'size' => 'small',
                    'style' => 'secondary',
                    'viewBox' => '0 0 20 20',
                    'className' => 'buy-block__btn-minus',
                    'attrs' => [
                        'data-action' => 'minus',
                        'data-id' => $data['id'],
                        'data-variant' => $v
                    ]
                ]); ?>
                <a href="/cart/" class="btn btn_style-secondary btn_size-medium buy-block__quantity-value"
                   style="pointer-events: all">
                    <i class="btn__icon btn__icon_left">
                        <svg viewBox="0 0 20 20">
                            <use xlink:href="/assets/icons/svg-defs.svg#cart-mini"></use>
                        </svg>
                    </i>
                    <span class="btn__text">
                    <span data-counter><?= $data['qty'] ?></span> шт.
                    </span>
                </a>
                <?php
                App\Layout\UIKit\Button\Layout::draw([
                    'iconCenter' => 'plus',
                    'size' => 'small',
                    'style' => 'secondary',
                    'viewBox' => '0 0 20 20',
                    'className' => 'buy-block__btn-plus',
                    'attrs' => [
                        'data-action' => 'plus',
                        'data-id' => $data['id'],
                        'data-variant' => $v
                    ]
                ]); ?>
            </div>
        <?php
        elseif ($size == 'tapbar'): ?>

            <?php
            App\Layout\UIKit\Button\Layout::draw([
                'text' => $data['price'] . ' ₽',
                'style' => 'primary',
                'size' => 'small',
                'iconLeft' => 'cart-mini',
                'viewBox' => '0 0 18 18',
                'className' => 'buy-block__btn-add',
                'attrs' => [
                    'data-action' => 'add-to-cart',
                    'data-id' => $data['id'],
                    'data-variant' => $v
                ]
            ]); ?>

            <?php
            if ((float)$data['price_old'] && $data['price_old'] != $data['price']): ?>
                <span class="buy-block__price-old"><?= $data['price_old'] ?> ₽</span>
            <?php
            endif; ?>

            <div class="buy-block__quantity">
                <?php
                App\Layout\UIKit\Button\Layout::draw([
                    'iconCenter' => 'minus',
                    'size' => 'small',
                    'style' => 'secondary',
                    'viewBox' => '0 0 20 20',
                    'className' => 'buy-block__btn-minus',
                    'attrs' => [
                        'data-action' => 'minus',
                        'data-id' => $data['id'],
                        'data-variant' => $v
                    ]
                ]); ?>
                <a href="/cart/" class="buy-block__quantity-block  btn btn_style-secondary btn_size-small  ">
                    <i class="btn__icon btn__icon_left">
                        <svg viewBox="0 0 20 20">
                            <use xlink:href="/assets/icons/svg-defs.svg#cart-mini"></use>
                        </svg>
                    </i>
                    <div class="btn__text">
                        <div class="btn__text btn__text_accent">
                            <span class="buy-block__quantity-value" data-counter><?= $data['qty'] ?></span>
                            <span class="buy-block__quantity-postfix">x</span>
                        </div>
                        <span class="buy-block__quantity-price"><?= $data['price'] ?> ₽</span>
                    </div>
                </a>
                <?php
                App\Layout\UIKit\Button\Layout::draw([
                    'iconCenter' => 'plus',
                    'size' => 'small',
                    'style' => 'secondary',
                    'viewBox' => '0 0 20 20',
                    'className' => 'buy-block__btn-plus',
                    'attrs' => [
                        'data-action' => 'plus',
                        'data-id' => $data['id'],
                        'data-variant' => $v
                    ]
                ]); ?>
            </div>

        <?php
        else: ?>
            <button data-action="add-to-cart" data-id="<?= $data['id'] ?>" data-variant="<?= $v ?>"
                    class="buy-block__btn-add btn btn_style-primary btn_size-medium ">
                <i class="btn__icon btn__icon_left">
                    <svg viewBox="0 0 20 20">
                        <use xlink:href="/assets/icons/svg-defs.svg#cart-mini"></use>
                    </svg>
                </i>
                <span class="btn__text"><?= $data['price'] ?> ₽</span>
                <span class="btn__text btn__text_cart">В корзину</span>
            </button>
            <div class="buy-block__price">
                <span class="buy-block__price-current"><?= $data['price'] ?> ₽</span>
                <?php
                if ((float)$data['price_old'] && $data['price_old'] != $data['price']): ?>
                    <span class="buy-block__price-old"><?= $data['price_old'] ?> ₽</span>
                <?php
                endif; ?>
            </div>
            <div class="buy-block__quantity">
                <?php
                App\Layout\UIKit\Button\Layout::draw([
                    'iconCenter' => 'minus',
                    'size' => 'small',
                    'style' => 'secondary',
                    'viewBox' => '0 0 20 20',
                    'className' => 'buy-block__btn-minus',
                    'attrs' => [
                        'data-action' => 'minus',
                        'data-id' => $data['id'],
                        'data-variant' => $v
                    ]
                ]); ?>
                <a href="/cart/" class="buy-block__quantity-block  btn btn_style-secondary btn_size-medium ">
                    <div class="btn__text">
                        <div class="btn__text btn__text_accent">
                            <span class="buy-block__quantity-value" data-counter><?= $data['qty'] ?></span>
                            <span class="buy-block__quantity-postfix">x</span>
                        </div>
                        <span class="buy-block__quantity-price"><?= $data['price'] ?> ₽</span>
                    </div>
                </a>
                <?php
                App\Layout\UIKit\Button\Layout::draw([
                    'iconCenter' => 'plus',
                    'size' => 'small',
                    'style' => 'secondary',
                    'viewBox' => '0 0 20 20',
                    'className' => 'buy-block__btn-plus',
                    'attrs' => [
                        'data-action' => 'plus',
                        'data-id' => $data['id'],
                        'data-variant' => $v
                    ]
                ]); ?>
            </div>
        <?php
        endif; ?><?php
    endif; ?>

</div>