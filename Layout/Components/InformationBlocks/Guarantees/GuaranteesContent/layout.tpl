<?php
/** @var array $data */

?>

<div class="<?= $data["class_name"] ?> guarantees-content">
    <div class="wrapper">
        <h1 class="guarantees-content__title">
            <?= $data["guarantees_title"] ?>
        </h1>
        <ul class="guarantees-content__list">
            <?php
            foreach ($data['guarantees'] as $guarantee): ?>
                <li>
                    <h3 class="guarantees-content__sub-title">
                        <?= $guarantee["title"] ?>
                    </h3>
                    <p class="guarantees-content__text">
                       <?= $guarantee["text"] ?>
                    </p>

                </li>
            <?php
            endforeach; ?>
        </ul>
    </div>
</div>