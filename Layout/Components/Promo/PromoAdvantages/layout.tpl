<?php
/** @var array $data */

$items = json_decode($data['items'], true)['v'] ?? [];
?>

<?php if (!empty($data['title'])): ?>
    <section class="promo-advantages wrapper">
        <h1 class="promo-advantages__title">
            <?= $data['title'] ?>
        </h1>

        <?php if (!empty($items)): ?>
            <div class="promo-advantages__content">
                <ul class="promo-advantages__items">
                    <?php foreach ($items as $i): ?>
                        <li class="promo-advantages__item">
                            <h3 class="promo-advantages__item--title">
                                <?= $i['title'] ?>
                            </h3>
                            <div class="promo-advantages__item--text">
                                <?= $i['text'] ?>
                            </div>
                        </li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>
    </section>
<?php endif; ?>