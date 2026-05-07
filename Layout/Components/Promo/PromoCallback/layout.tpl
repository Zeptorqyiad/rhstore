<?php
/** @var array $data */

?>

<section class="<?= $data["class_name"] ?> promo-callback">
    <div class="promo-callback__container wrapper">
        <?php if ($data['title']): ?>
            <h2 class="promo-callback__title">
                <?= $data['title'] ?>
            </h2>
        <?php endif; ?>
        <?php if ($data['text']): ?>
            <div class="promo-callback__text">
                <?= $data['text'] ?>
            </div>
        <?php endif; ?>

        <div class="promo-callback__social">
            <?php if ($data['tg-link']): ?>
                <a href="<?= $data['tg-link'] ?>"
                   class="promo-callback__social--tg"
                    target="_blank"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32" fill="none">
                        <path d="M27.9993 6.13622L23.9921 27.0563C23.9921 27.0563 23.4314 28.5067 21.8912 27.8111L12.6455 20.47L12.6026 20.4484C13.8515 19.2871 23.5359 10.2701 23.9591 9.86141C24.6144 9.2284 24.2076 8.85156 23.4468 9.32973L9.14174 18.7372L3.62287 16.8143C3.62287 16.8143 2.75436 16.4944 2.67081 15.7987C2.58615 15.102 3.65145 14.7251 3.65145 14.7251L26.1502 5.58518C26.1502 5.58518 27.9993 4.74383 27.9993 6.13622V6.13622Z" fill="white"/>
                    </svg>

                    <?= $data['tg-button-text'] ?: 'Подписаться' ?>
                </a>
            <?php else:
                App\Layout\Components\Common\Button\Layout::draw([
                    'text' => $data['button-text'] ?: 'Связаться с нами',
                    'style' => 'primary',
                    'class_name' => 'promo-callback__button marketplaces__checklist-btn',
                    'modal' => 'modalPromo',
                ]);

                App\Layout\Components\Common\SocialNetwork\Layout::draw();
                ?>
            <?php endif; ?>
        </div>

        <div class="promo-callback__parallax">
            <img src="/assets/images/for-sellers/seller-banner/target.png"
                 alt="3d" class="promo-callback__parallax-img" draggable="false">
        </div>

        <div class="promo-callback__dollar-1">
            <img src="/assets/images/for-sellers/seller-banner/dollar-1.png"
                 alt="dollar-1" class="promo-callback__parallax-img" draggable="false">
        </div>

        <div class="promo-callback__dollar-2">
            <img src="/assets/images/for-sellers/seller-banner/dollar-2.png"
                 alt="dollar-2" class="promo-callback__parallax-img" draggable="false">
        </div>
    </div>
</section>