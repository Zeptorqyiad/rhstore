<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> main-banner">
    <div class="main-banner__container wrapper">
        <h1 class="main-banner__title">
            <?= $data["title"] ?>
            <span class="main-banner__title-red">
                <?= $data["red_title"] ?>
            </span>
        </h1>
        <p class="main-banner__paragraph">
            <?= $data["text"] ?>
        </p>

        <a href="/promotions/skidka-20-na-pervyj-zakaz-na-pervyj-zakaz-na-pervyj-zakaz-na-pervyj-zakaz/" class="main-banner__link" draggable="false">
            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' =>  $data["button_text"],
                'style' => 'primary',
                'class_name' => 'main-banner__button',
                'button_link' => $data["button_link"],
            ]); ?>
        </a>

        <div class="main-banner__phone">
            <div  class="main-banner__phone-box">
                <img src="/assets/images/main/main-banner/phone.png" alt=""
                     class="main-banner__phone-img parallax__phone">
            </div>
        </div>
        <div class="main-banner__box main-banner__box-first">
            <img src="/assets/images/main/main-banner/box1.png" alt=""
                 class="main-banner__box-first-img">
        </div>
        <div class="main-banner__box main-banner__box-second">
            <img src="/assets/images/main/main-banner/box2.png" alt=""
                 class="main-banner__box-second-img">
        </div>
        <div class=" main-banner__box main-banner__box-third">
            <img src="/assets/images/main/main-banner/box3.png" alt=""
                 class="main-banner__box-third-img">
        </div>
    </div>
</section>