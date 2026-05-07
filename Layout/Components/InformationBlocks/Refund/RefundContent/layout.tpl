<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> refund-content">
    <div class="wrapper">
        <h1 class="refund-content__title">
            <?= $data["refund_title"] ?>
        </h1>
        <ul class="refund-content__list">
            <?php
            foreach ($data['refunds'] as $refund): ?>
                <li>
                    <h3 class="refund-content__sub-title">
                        <?= $refund["title"] ?>
                    </h3>
                    <p class="refund-content__text">
                       <?= $refund["text"] ?>
                    </p>

                </li>
            <?php
            endforeach; ?>
        </ul>
    </div>
</div>