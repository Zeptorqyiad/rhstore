<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> company-news-slider">
    <div class="company-news-slider__container wrapper">

        <div class="company-news-slider__slider">
            <div class="swiper-wrapper">
                <?php foreach ($data['blog_news'] as $slide): ?>
                    <div class="swiper-slide">
                        <div class="company-news-slider__card">
                            <div class="company-news-slider__card-content">
                                <p class="company-news-slider__card-title">
                                    <?= $slide["title"] ?>
                                </p>
                                <p class="company-news-slider__card-text">
                                    <?= $slide["text"] ?>
                                </p>

                                <?php App\Layout\Components\Common\Button\Layout::draw([
                                    'text' => 'Читать статью',
                                    'style' => 'secondary',
                                    'class_name' => 'company-news-slider__button',
                                    'link' => $slide['link'],
                                ]); ?>
                            </div>

                            <div class="company-news-slider__image">
                                <?php App\Layout\UIKit\Skeleton\Layout::draw(); ?>
                                <img class="lazy-image" data-src="<?= $slide["image"] ?>" alt="slide">
                            </div>
                            <div class="company-news-slider__mobile-image">
                                <?php App\Layout\UIKit\Skeleton\Layout::draw(); ?>
                                <img class="lazy-image" data-src="<?= $slide["mobile_image"] ?? $slide["image"] ?>" alt="mob-slide">
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>

        <?php App\Layout\Components\Common\SliderButtons\Layout::draw([
            'class_name' => 'company-news-slider__buttons',
            'prev_class_name' => 'company-news-slider__button-prev',
            'next_class_name' => 'company-news-slider__button-next',
        ]); ?>
    </div>
</section>