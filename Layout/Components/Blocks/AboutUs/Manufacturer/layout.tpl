<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> manufacturer">
    <div class="wrapper">
        <h2 class="manufacturer__title"><?= $data["manufacturer_title"] ?></h2>
        <div class="manufacturer__box">
            <div class="manufacturer__first-cell">
                <p class="manufacturer__text">
                    <?= $data["manufacturer_text"] ?>
                </p>

                <a href="https://стекла.рф/" target="_blank" class="manufacturer__button-link">
                    <?php App\Layout\Components\Common\Button\Layout::draw([
                        'text' => 'Подробнее',
                        'style' => 'secondary',
                        'class_name' => 'manufacturer__button'
                    ]); ?>
                </a>
            </div>
            <div class="manufacturer__second-cell">
                <img src="<?= $data["manufacturer_f-img"] ?>" alt="img">
            </div>

            <div class="manufacturer__third-cell">
                <video autoplay muted loop>
                    <source src="/assets/images/about-us/manufacturer/video_about.mp4" type="video/mp4">
                </video>

                <img src="/assets/images/about-us/manufacturer/image1.png" alt="img">
            </div>


            <div class="manufacturer__fourth-cell">
                <img src="<?= $data["manufacturer_s-img"] ?>" alt="img">
            </div>
        </div>
        <?php App\Layout\Components\Common\ManufacturerList\Layout::draw([
            'manufacturers' => $data['manufacturers'],

]); ?>
    </div>
</section>
