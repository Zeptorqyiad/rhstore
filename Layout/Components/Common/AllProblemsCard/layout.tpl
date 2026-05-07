<?php
/** @var array $data */
?>

<li class="all-problems__card">
    <div class="all-problems__card-decision">
        <img src="<?= $data["img"] ?>">
        <span><?= $data["title"] ?></span>
    </div>
    <p class="all-problems__card-text">
        <?= $data["text"] ?>
    </p>
</li>