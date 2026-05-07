<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> offer-content">
    <div class="wrapper">
        <h1 class="offer-content__title">
            <?= $data["offer_title"] ?>
        </h1>
        <div class="offer-content__list">
            <?= $data["offer_blocks"] ?>
        </div>
    </div>
</div>