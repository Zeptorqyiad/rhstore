<?php
/** @var array $data */

?>

<?php if (!empty($data['title'])): ?>
<section class="promo-sales wrapper">
    <h1 class="promo-sales__title">
        <?= $data['title'] ?>
    </h1>

    <?php if ($data['card1-title'] || $data['card1-text'] || $data['card2-title'] || $data['card2-text']): ?>
    <ul class="promo-sales__items">
        <li class="promo-sales__item promo-sales__item-red">
            <?php if ($data['card1-title']): ?>
                <h3 class="promo-sales__item--title">
                    <?= $data['card1-title'] ?>
                </h3>
            <?php endif; ?>
            <?php if ($data['card1-text']): ?>
                <div class="promo-sales__item--text">
                    <?= $data['card1-text'] ?>
                </div>
            <?php endif; ?>

            <?php if ($data['card1-image']): ?>
                <div class="promo-sales__item--image">
                    <img src="/uf/images/source/<?= $data['card1-image'] ?>" alt="">
                </div>
            <?php endif; ?>
        </li>
        <li class="promo-sales__item promo-sales__item-blue">
            <?php if ($data['card2-title']): ?>
                <h3 class="promo-sales__item--title">
                    <?= $data['card2-title'] ?>
                </h3>
            <?php endif; ?>
            <?php if ($data['card2-text']): ?>
                <div class="promo-sales__item--text">
                    <?= $data['card2-text'] ?>
                </div>
            <?php endif; ?>

            <?php if ($data['card2-image']): ?>
                <div class="promo-sales__item--image">
                    <img src="/uf/images/source/<?= $data['card2-image'] ?>" alt="">
                </div>
            <?php endif; ?>
        </li>
    </ul>
    <?php endif; ?>
</section>
<?php endif; ?>