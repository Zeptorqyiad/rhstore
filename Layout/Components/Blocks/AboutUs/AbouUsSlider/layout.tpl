<?php
/** @var array $data */

?>

<section class="<?= $data["class_name"] ?> about-us-slider">
    <div class="about-us-slider__container wrapper">

        <h2 class="about-us-slider__title"><?= $data['about-us-slider_title'] ?></h2>

        <?php
        App\Layout\Components\Common\SliderButtons\Layout::draw([
            'class_name' => 'about-us-slider__buttons',
            'prev_class_name' => 'about-us-slider__button-prev',
            'next_class_name' => 'about-us-slider__button-next',
        ]); ?>

        <div class="about-us-slider__slider">
            <div class="swiper-wrapper">

                <?php
                foreach ($data['slides'] as $slide): ?>

                        <div class="swiper-slide">
                            <div class="about-us-slider__slide">
                                <div class="about-us-slider__video-mask"></div>
                                <button type="button" class="about-us-slider__video-play">
                                    <svg viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M9 4L34 18L9 32V4Z" fill="#404040"></path>
                                    </svg>
                                </button>
                                <video class="about-us-slider__video">

                                    <source src="/uf/files/<?= $slide['video'] ?>" type="video/mp4">
                                </video>
                            </div>
                        </div>

                <?php
                endforeach ?>
            </div>
        </div>
    </div>
</section>