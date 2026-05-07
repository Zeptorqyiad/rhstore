<?php
/** @var array $data */


?>

<div class="step-top">
    <div class="step-top__title-wrap">
        <h2 class="step-top__title">Шаг <?= $data["num"] ?></h2>
        <span class="step-top__num"></span>
    </div>

    <div class="step-top__text">
        <h3 class="step-top__subtitle"><?= $data["subtitle"] ?></h3>
        <p class="step-top__info"><?= $data["info"] ?></p>
    </div>

</div>
