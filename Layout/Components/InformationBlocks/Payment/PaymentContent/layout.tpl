<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> payment-content">
    <div class="wrapper">
        <h1 class="payment-content__title">
            <?= $data["payment_title"] ?>
        </h1>
        <ul class="payment-content__list">
            <li>
                <h3 class="payment-content__sub-title">
                    <?= $data["payment_subtitle_f"] ?>
                </h3>
                <div class="payment-content__text">
                    <p>
                        <?= $data["payment_text_f"] ?>
                    </p>
                    <p class="payment-content__text-bold">
                        <?= $data["payment_req_title"] ?>
                    </p>
                    <div class="payment-content__bottom-text">
                        <?php
                        foreach ($data['reqs'] as $req): ?>
                            <span><?= $req["text"] ?></span>
                        <?php endforeach; ?>
                    </div>
                </div>
            </li>
            <li>
                <h3 class="payment-content__sub-title">
                    <?= $data["payment_subtitle_s"] ?>
                </h3>
                <p class="payment-content__text">
                    <?= $data["payment_text_s"] ?>
                </p>
            </li>
        </ul>
    </div>
</div>