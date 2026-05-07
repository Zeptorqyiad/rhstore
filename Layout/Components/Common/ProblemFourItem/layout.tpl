<?php
/** @var array $data */
?>

<li class="problem-four__card">
    <div class="problem-four__card-left">
        <div class="problem-four__card-badge">
            <?= $data["title_f"] ?>
        </div>
        <p class="problem-four__card-text">
            <?= $data["text_f"] ?>
        </p>
    </div>
    <div  class="problem-four__card-right">
        <div class="problem-four__card-decision">
            <img src="<?= $data["img"] ?>">
            <span><?= $data["title_s"] ?></span>
        </div>
        <p class="problem-four__card-r-text">
            <?= $data["text_s"] ?>
        </p>
    </div>
</li>