<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> brands-banner">
    <div class="brands-banner__container wrapper">
        <h1 class="brands-banner__title"><?= $data["brands_title"] ?></h1>
        <p class="brands-banner__text"><?= $data["brands_text"] ?></p>

        <div class="brands-banner__parallax">
            <img src="/assets/images/brands/brands-banner/3D.png"
                 alt="3d" class="brands-banner__parallax-img" draggable="false">
        </div>
    </div>
</section>