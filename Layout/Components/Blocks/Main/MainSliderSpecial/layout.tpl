<?php
/** @var array $data */

?>


<section class="<?= $data["class_name"] ?> main-slider-special">
    <div class="wrapper">
        <div class="main-slider-special__top">
            <h2 class="main-slider-special__title"><?= $data['title'] ?></h2>

            <?php
            App\Layout\Components\Common\SliderButtons\Layout::draw([
                'class_name' => 'main-slider-special__buttons',
                'prev_class_name' => 'main-slider-special__button-prev',
                'next_class_name' => 'main-slider-special__button-next',
            ]); ?>
        </div>
    </div>
    <div class="main-slider-special__container">
        <div class="wrapper">
            <div class="main-slider-special__slider">
                <ul class="swiper-wrapper">
                    <?php
                    foreach ($data['cards'] as $card): ?>
                        <?php
                        $isBlack = $card['black_text'] ? 'main-slider-special__info_color-black' : '';
                        ?>

                        <li class="swiper-slide">
                            <a href="<?= $card['link'] ?>" class="main-slider-special__slide">
                                <p class="main-slider-special__info <?= $isBlack ?>">
                                    <?= $card['text'] ?>
                                </p>
                                <div class="main-slider-special__image-block">
                                    <img src="<?= $card['image'] ?>"
                                         alt="sl-1">
                                </div>
                            </a>
                        </li>
                    <?php
                    endforeach; ?>
                </ul>
            </div>
        </div>
    </div>
</section>