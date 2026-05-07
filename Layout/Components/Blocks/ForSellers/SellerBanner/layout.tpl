<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> seller-banner">
    <div class="seller-banner__container wrapper">
        <h2 class="seller-banner__title"><?= $data["banner_title"] ?></h2>
        <p class="seller-banner__text"><?= $data["banner_text"] ?></p>

        <?php App\Layout\Components\Common\Button\Layout::draw([
            'text' => 'Пройти чек-лист',
            'style' => 'secondary',
            'class_name' => 'seller-banner__button marketplaces__checklist-btn',
            'modal' => 'checklist'
        ]); ?>

        <div class="seller-banner__parallax">
            <img src="/assets/images/for-sellers/seller-banner/target.png"
                 alt="3d" class="seller-banner__parallax-img" draggable="false">
        </div>

        <div class="seller-banner__dollar-1">
            <img src="/assets/images/for-sellers/seller-banner/dollar-1.png"
                 alt="dollar-1" class="seller-banner__parallax-img" draggable="false">
        </div>

        <div class="seller-banner__dollar-2">
            <img src="/assets/images/for-sellers/seller-banner/dollar-2.png"
                 alt="dollar-2" class="seller-banner__parallax-img" draggable="false">
        </div>
    </div>
</section>