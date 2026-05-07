<?php
/** @var array $data */

$items = json_decode($data['items'], true)['v'] ?? [];
?>

<?php if (!empty($items)): ?>
<div class="promo-numbers">
    <div class="promo-numbers__container wrapper">
        <ul class="promo-numbers__items">
            <?php foreach ($items as $i): ?>
                <li class="promo-numbers__item">
                    <h2 class="promo-numbers__item--title">
                        <?= $i['title'] ?>
                    </h2>
                    <div class="promo-numbers__item--text">
                        <?= $i['text'] ?>
                    </div>
                </li>
            <?php endforeach; ?>
        </ul>
    </div>
</div>
<?php endif; ?>