<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> politics-content">
    <div class="wrapper">
        <h1 class="politics-content__title">
            <?= $data['policy_title'] ?>
        </h1>
        <div class="content politics-content__list">
            <?= $data['policy_content'] ?>
        </div>
    </div>
</div>