<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> main-about">
    <div class="main-about__container wrapper">

        <div class="main-about__card main-about__card-about">
            <h2 class="main-about__title">
                <?= $data["main-about_title_f"] ?>
            </h2>
            <p class="main-about__text">
                <?= $data["main-about_text_f"] ?>
            </p>
            <a href="/about-us/" class="main-about__button-link">
                <?php App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Подробнее',
                    'style' => 'secondary',
                    'class_name' => 'main-about__button',
                ]); ?>
            </a>

            <div class="main-about__img">
                <img src="/assets/images/main/main-about/tractor.png"
                     alt="tractor">
            </div>
        </div>
        <div class="main-about__card main-about__card-brands">
            <h2 class="main-about__title">
                <?= $data["main-about_title_s"] ?>
            </h2>
            <p class="main-about__text">
                <?= $data["main-about_text_s"] ?>
            </p>
            <a href="/brands/" class="main-about__button-link">
                <?php App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Подробнее',
                    'style' => 'secondary',
                    'class_name' => 'main-about__button',
                ]); ?>
            </a>
            <div class="main-about__img">
                <img src="/assets/images/main/main-about/glass.png"
                     alt="glass">
                <img src="/assets/images/main/main-about/glass-m.png"
                     alt="glass">
            </div>
        </div>
        <div class="main-about__card main-about__card-sell">
            <h2 class="main-about__title">
                <?= $data["main-about_title_t"] ?>
            </h2>
            <p class="main-about__text">
                <?= $data["main-about_text_t"] ?>
            </p>
            <a href="/for-sellers/" class="main-about__button-link">
                <?php \App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Подробнее',
                    'style' => 'secondary',
                    'class_name' => 'main-about__button',
                ]); ?>
            </a>

            <div class="main-about__img-box">
                <img src="/assets/images/main/main-about/Box.png"
                     alt="box">
            </div>
            <div class="main-about__img-mask">
                <img src="/assets/images/main/main-about/Mask.png"
                     alt="mask">
            </div>
            <div class="main-about__img-ozon">
                <img src="/assets/images/main/main-about/Ozon.png"
                     alt="ozon">
            </div>
        </div>
    </div>
</section>
