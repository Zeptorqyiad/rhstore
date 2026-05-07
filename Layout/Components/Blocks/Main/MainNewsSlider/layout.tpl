<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> main-news-slider">
    <div class="main-news-slider__container wrapper">

        <h2 class="main-news-slider__title"><?= $data['title'] ?></h2>

        <div class="main-news-slider__rs-content">
            <?php
            App\Layout\Components\Common\Button\Layout::draw([
                'text' =>  'Все новости',
                'style' => 'secondary',
                'class_name' => 'main-news-slider__rs-content--btn',
                'link' => '/blog/',
            ]);
            App\Layout\Components\Common\SliderButtons\Layout::draw([
                'class_name' => 'main-news-slider__buttons',
                'prev_class_name' => 'main-news-slider__button-prev',
                'next_class_name' => 'main-news-slider__button-next',
            ]);
            ?>
        </div>

        <div class="main-news-slider__slider">
            <div class="swiper-wrapper">
                <?php for ($i = 1; $i <= 4; $i++): ?>
                    <?php
                    foreach ($data['cards'] as $c): ?>
                        <div class="swiper-slide">
                            <?php App\Layout\Components\Common\BlogCard\Layout::draw([
                                'type' => $c->category->name,
                                'image' => '/uf/images/source/' . $c->photo,
                                'text' => $c->short,
                                'date' => $c->date,
                                'label' => $c->category->name,
                                'link' => '/blog/' . $c->alias . '/',
                            ]); ?>
                        </div>
                    <?php endforeach; ?>
                <?php endfor; ?>
            </div>
        </div>
    </div>
</section>