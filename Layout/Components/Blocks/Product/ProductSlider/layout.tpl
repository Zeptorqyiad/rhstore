<?php
/** @var array $data */
/** @var \App\Extensions\Catalog\Model\Product $p */
$p = $data['prod'];
?>

<div class="<?= $data["class_name"] ?> product-slider">
    <div class="product-slider__container">
        <div class=" product-slider__main-slider">
            <div class="swiper-wrapper">
                <?php
                foreach ($data['slides'] as $slide):?>
                    <div class="swiper-slide">
                        <div class="product-slider__slide">
                            <?php App\Layout\UIKit\Skeleton\Layout::draw(); ?>
                            <img class="lazy-image" data-src="<?= $slide['image'] ?>" alt=""/>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>

            <div class="product-slider__slide-box">
                <ul class="product-slider__slide-badges">
                    <?php if ($d = $p->getDiscountPercent()): ?>
                        <li class="product-slider__slide-badge product-slider__slide-badge_color-red">
                            -<?= $d ?>%
                        </li>
                    <?php endif; ?>
                    <?php if ($p->is_new): ?>
                        <li class="product-slider__slide-badge product-slider__slide-badge_color-green">
                            New
                        </li>
                    <?php endif; ?>
                    <?php if ($p->is_popular): ?>
                        <li class="product-slider__slide-badge product-slider__slide-badge_color-blue">
                            Hit
                        </li>
                    <?php endif; ?>
                </ul>
                <div class="product-slider__slide-warn">
                    <p class="product-slider__slide-warn-text">
                        Образец на карточке может отличаться от реального товара
                    </p>
                </div>
            </div>

            <div class="product-slider__slide-favorites-box">
                <?php App\Layout\Components\Common\Favorites\Layout::draw([
                    'class_name' => 'product-slider__slide-favorites',
                    'id' => $p->product_id,
                    'variant' => $p->variantId
                ]); ?>

            </div>
        </div>

        <div class="product-slider__bottom">
            <div class="product-slider__secondary-slider">
                <div class="swiper-wrapper">
                    <?php
                    foreach ($data['slides'] as $slide):?>
                        <div class="swiper-slide">
                            <div class="product-slider__s-slide">
                                <?php App\Layout\UIKit\Skeleton\Layout::draw(); ?>
                                <img class="lazy-image" data-src="<?= $slide['image'] ?>" alt=""/>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php App\Layout\Components\Common\SliderButtons\Layout::draw([
                'class_name' => 'product-slider__buttons',
                'prev_class_name' => 'product-slider__button-prev',
                'next_class_name' => 'product-slider__button-next',
            ]); ?>
        </div>
    </div>
</div>