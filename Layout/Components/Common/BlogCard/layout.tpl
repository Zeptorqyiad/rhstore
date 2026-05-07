<?php
/** @var array $data */

?>

<li class="<?= $data["class_name"] ?> news-card company-news__card ">
    <a href="<?= $data["link"] ?>" class="news-card__slide" draggable="false">
        <div class="news-card__image-block">
            <?php
            App\Layout\UIKit\Skeleton\Layout::draw(); ?>
            <img data-src="<?= $data['image'] ?>"
                 alt="<?= $data["text"] ?>"
                 class="news-card__image lazy-image" draggable="false" loading="lazy">
        </div>
        <div class="news-card__info">
            <p class="news-card__sl-title">
                <?= $data["text"] ?>
            </p>
            <div class="news-card__bottom">
                <p class="news-card__date">
                    <?= $data["date"] ?>
                </p>
                <p class="news-card__label">
                    <?= $data["label"] ?>
                </p>
            </div>
        </div>
    </a>
</li>