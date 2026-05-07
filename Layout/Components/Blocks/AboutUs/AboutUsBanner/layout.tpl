<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> about-us-banner">
    <div class="about-us-banner__container wrapper">
        <h2 class="about-us-banner__title"><?= $data["about-us_title"] ?></h2>
        <p class="about-us-banner__text"><?= $data["about-us_description"] ?></p>

        <div class="about-us-banner__parallax">
            <img src="/assets/images/about-us/about-us-banner/hand.png"
                 alt="3d" class="about-us-banner__parallax-img">
        </div>
    </div>
</section>