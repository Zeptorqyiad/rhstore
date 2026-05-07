<?php
/** @var array $data */

$content = json_decode($data['content'], true)['v'] ?? [];
?>

<section class="post">
    <div class="post__container wrapper">
        <div class="post__top ">
            <div class="post__header">
                <h1 class="post__title"><?= $data['title'] ?></h1>
                <p class="post__description"><?= $data['description'] ?></p>
            </div>
            <div class="post__meta">
                <p class="post__data"><?= $data['date'] ?></p>
                <p class="post__data"><?= $data['label'] ?></p>
            </div>
            <img class="post__image post__image--desktop" src="<?= $data['image_big'] ?>" alt="">

            <img class="post__image post__image--mob" src="<?= $data['image_mob'] ?>" alt="">
        </div>
        <div class="post__body content">
            <?php foreach ($content as $i): ?>
                <h2><?= $i['title'] ?></h2>
                <?= $i['content'] ?>
            <?php endforeach; ?>

            <div class="post__bottom">
                <?php App\Layout\UIKit\ButtonArrow\Layout::draw([
                    'onclick' =>'history.back(-1);',
                ]);?>
            </div>
        </div>
    </div>
</section>