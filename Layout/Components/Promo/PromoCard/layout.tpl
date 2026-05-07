<?php
/** @var array $data */

?>

<div class="<?= $data['class_name'] ?> promo-card">
    <a href="<?= $data['path'] ?>" class="promo-card__slide" draggable="false">
        <div class="promo-card__image-block">
            <?php
            if ($data['badge']): ?>
                <span class="promo-card__badge promo__badge">
                    <?= $data['badge'] ?>
                </span>
            <?php
            endif ?>
            <img src="<?= $data['image'] ?>" alt="" class="promo-card__image" draggable="false">
            <div class="promo-card__mask"></div>
        </div>

        <div class="promo-card__info">
            <h3 class="promo-card__title">
                <?= $data['title'] ?>
            </h3>
            <div class="promo-card__date">
                <?= $data['date'] ?>
            </div>
        </div>
    </a>
</div>