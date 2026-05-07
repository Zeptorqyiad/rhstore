<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> delivery-content">
    <div class="wrapper">
        <h1 class="delivery-content__title">
            <?= $data["delivery_title"] ?>
        </h1>
        <ul class="delivery-content__list">
            <li>
                <h3 class="delivery-content__sub-title">
                    <?= $data["delivery_subtitle_f"] ?>
                </h3>

                <ul class="delivery-content__conditions">
                    <?php
                    foreach ($data['conditions'] as $condition): ?>
                        <li class="delivery-content__conditions-item">
                           <?= $condition["text"] ?>
                        </li>
                    <?php endforeach; ?>
                </ul>

            </li>
            <li>
                <h3 class="delivery-content__sub-title">
                    <?= $data["delivery_subtitle_s"] ?>
                </h3>
                <p class="delivery-content__text">
                      <?= $data["delivery_text"] ?>
                </p>
            </li>
        </ul>
    </div>
</div>