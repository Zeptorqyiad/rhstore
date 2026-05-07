<?php
/** @var array $data */
?>

<li class="<?= $data["class_name"] ?> advantage-card">
    <?php if ($data['title']): ?>
        <h3 class="advantage-card__title">
            <?= $data["title"] ?>
        </h3>
    <?php endif; ?>
    <?php if ($data['text']): ?>
        <div class="advantage-card__text">
            <?= $data["text"] ?>
        </div>
    <?php endif; ?>

    <div class="advantage-card__logo">
        <img src="<?= $data["image"] ?>" alt="logo" draggable="false">
    </div>
</li>