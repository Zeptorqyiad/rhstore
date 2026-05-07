<?php
/** @var array $data */

$q = App\Extensions\Promotion\Model\Promotion::findAdv();

$items = $q
    ->orderBy('npp desc')
    ->where(['is_active' => 1])
    ->all();
?>

<section class="promo-slider">
    <div class="promo-slider__container wrapper">
        <h2 class="promo-slider__title">
            Другие акции и предложения
        </h2>

        <div class="promo-slider__rs-content">
            <?php
            App\Layout\Components\Common\Button\Layout::draw([
                'text' =>  'Все акции',
                'style' => 'secondary',
                'class_name' => 'promo-slider__rs-content--btn',
                'link' => '/promotions/',
            ]);
            App\Layout\Components\Common\SliderButtons\Layout::draw([
                'class_name' => 'promo-slider__buttons',
                'prev_class_name' => 'promo-slider__button-prev',
                'next_class_name' => 'promo-slider__button-next',
            ]);
            ?>
        </div>

        <div class="promo-slider__slider">
            <div class="swiper-wrapper">
                <?php foreach ($items as $c):?>
                    <div class="swiper-slide">
                        <?php App\Layout\Components\Promo\PromoCard\Layout::draw([
                            'title' => $c->banner_title . $c->banner_title_accent . $c->banner_title_third,
                            'image' => '/uf/images/source/' . $c->photo,
                            'date' => $c->date,
                            'badge' => $c->badge,
                            'path' => '/promotions/' . $c->alias . '/',
                        ]); ?>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</section>