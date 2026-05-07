<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> seller-hero">
    <div class="seller-hero__container wrapper">

        <div class="seller-hero__left">
            <h1 class="seller-hero__title">
                <span><?= $data["sellers_title"] ?></span>
                <span><?= $data["sellers_title_accent"] ?></span>
            </h1>

            <p class="seller-hero__text">
                <?= $data["sellers_text"] ?>
            </p>

            <ul class="seller-hero__list">
                <?php
                foreach ($data['sellers_items'] as $sellers_item)
                    App\Layout\Components\Common\SellersHeroItem\Layout::draw([
                        'item_image' => $sellers_item['item_image'],
                        'item_text' => $sellers_item['item_text'],
                    ]);
                ?>
            </ul>

            <div class="seller-hero__box">
                <p class="seller-hero__box-text">
                    <?= $data["sellers_box_text"] ?>
                </p>
                <?php
//                App\Layout\Components\Common\Button\Layout::draw([
//                    'text' => '',
//                    'style' => 'secondary',
//                    'class_name' => ''
//                ]);
                App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Получить консультацию',
                    'style' => 'secondary',
                    'class_name' => 'seller-hero__button',
                    'modal' => 'modalPromo',
                ]);
                ?>

            </div>
        </div>
        <div class="seller-hero__right">
            <div class="seller-hero__image">
                <img src="<?= $data["sellers_right_img"] ?>" alt="diagram">
            </div>
            <p class="seller-hero__right-text">
                <?= $data["sellers_right_text"] ?>
            </p>

        </div>

    </div>
</section>
