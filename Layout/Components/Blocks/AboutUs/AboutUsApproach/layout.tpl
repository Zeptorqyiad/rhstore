<?php
/** @var array $data */

?>

<section class="<?= $data["class_name"] ?> about-us-approach">
    <div class="wrapper">
        <h2 class="about-us-approach__title">
            <?= $data["approach_title"] ?>
        </h2>
        <div class="about-us-approach__box">
            <div class="about-us-approach__first-column">
                <?php if ($data['approach_description_f']): ?>
                    <div class="about-us-approach__f-text">
                        <?= $data["approach_description_f"] ?>
                    </div>
                <?php endif; ?>
                <?php if ($data['approach_description_s']): ?>
                    <div class="about-us-approach__s-text">
                        <?= $data["approach_description_s"] ?>
                    </div>
                <?php endif; ?>
                <div class="about-us-approach__f-slider">
                    <div class="swiper-wrapper">
                        <?php if ($data['f_slide_left']): ?>
                            <div class="swiper-slide">
                                <div class="about-us-approach__f-slide">
                                    <img src="<?= $data["f_slide_left"] ?>" alt="">
                                </div>
                            </div>
                        <?php endif; ?>
                        <?php if ($data['s_slide_left']): ?>
                            <div class="swiper-slide">
                                <div class="about-us-approach__f-slide">
                                    <img src="<?= $data["s_slide_left"] ?>" alt="">
                                </div>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
            <div class="about-us-approach__second-column">
                <div class="about-us-approach__f-square">
                    <span><?= $data["approach__f-top"] ?></span>
                    <span><?= $data["approach__f-middle"] ?></span>
                    <span><?= $data["approach__f-bottom"] ?></span>
                </div>
                <div class="about-us-approach__s-square">
                    <span><?= $data["approach__s-top"] ?></span>
                    <span><?= $data["approach__s-middle"] ?></span>
                    <span><?= $data["approach__s-bottom"] ?></span>
                </div>
            </div>
            <div class="about-us-approach__third-column">
                <div class="about-us-approach__f-img">
                    <div class="about-us-approach__slider">
                        <div class="swiper-wrapper">
                            <?php if ($data['f_slide_right']): ?>
                                <div class="swiper-slide">
                                    <div class="about-us-approach__slide">
                                        <img src="<?= $data["f_slide_right"]?>" alt="">
                                    </div>
                                </div>
                            <?php endif; ?>
                            <?php if ($data['s_slide_right']): ?>
                                <div class="swiper-slide">
                                    <div class="about-us-approach__slide">
                                        <img src="<?= $data["s_slide_right"]?>" alt="">
                                    </div>
                                </div>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
                <div class="about-us-approach__third-bottom">
                    <?php if ($data['approach_img']): ?>
                        <div class="about-us-approach__t-img">
                            <img src="<?= $data["approach_img"]?>" alt="img-1">
                        </div>
                    <?php endif; ?>
                    <div class="about-us-approach__t-square">
                        <span><?= $data["approach__t-top"] ?></span>
                        <span><?= $data["approach__t-middle"] ?></span>
                        <span><?= $data["approach__t-bottom"] ?></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
