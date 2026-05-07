<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> brands-on-ozon">
    <div class="brands-on-ozon__container wrapper">
        <h2 class="brands-on-ozon__title"><?= $data["ozon_title"] ?></h2>

        <div class="brands-on-ozon__card">
            <div class="brands-on-ozon__card-column">
                <h3 class="brands-on-ozon__card-title"><?= $data["card_title"] ?></h3>
                <p class="brands-on-ozon__card-text"><?= $data["card_text"] ?></p>

                <a href="<?= $data["ozon_link"] ?>" target="_blank" class="brands-on-ozon__button-link">
                    <?php App\Layout\Components\Common\Button\Layout::draw([
                        'text' => 'Перейти на озон',
                        'style' => 'secondary',
                        'class_name' => 'brands-on-ozon__button'
                    ]); ?>
                </a>
            </div>
            <div class="brands-on-ozon__card-column">
                <div class="brands-on-ozon__card-image">
                    <img src="<?= $data["ozon_img"] ?>" alt="ozon">
                </div>
            </div>
        </div>
    </div>
</section>
