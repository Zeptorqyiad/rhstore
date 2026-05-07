<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> contacts-map">
    <h3 class="contacts-map__title">
        <?= $data["map_title"] ?>
    </h3>

    <div class="contacts-map__address">
        <span>{storage_address}</span>
    </div>

    <div class="contacts-map__block">
        <iframe src="https://yandex.ru/map-widget/v1/?um=constructor%3A1f3268d9aeb845e7eddf0d06cf2a1c6b44e7f2b50e5cc25877d234835489508c&source=constructor"
                class="contacts__map" frameborder="0">
        </iframe>
    </div>
</div>