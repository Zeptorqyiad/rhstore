<?php
/** @var array $data */

?>

<section class="promo-info wrapper">
    <div class="promo-info__content">
        <div class="promo-info__content-ls">
            <?php if ($data['title']): ?>
                <h1 class="promo-info__content-ls--title">
                    <?= $data['title'] ?>
                </h1>
            <?php endif; ?>
            <?php if ($data['text']): ?>
                <div class="promo-info__content-ls--text">
                    <?= $data['text'] ?>
                </div>
            <?php endif; ?>

            <?php if ($data['consist-title'] || $data['consist-text']): ?>
                <div class="promo-info__consist">
                    <h3 class="promo-info__consist--title">
                        <?= $data['consist-title'] ?>
                    </h3>
                    <div class="promo-info__consist--text">
                        <?= $data['consist-text'] ?>
                    </div>
                </div>
            <?php endif; ?>
        </div>
        <?php if ($data['image']): ?>
        <div class="promo-info__content-rs">
            <img src="/uf/images/source/<?= $data['image'] ?>" alt="">
        </div>
        <?php endif; ?>
    </div>
</section>