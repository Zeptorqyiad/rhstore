<?php
/** @var array $data */

$items = json_decode($data['items'], true)['v'] ?? [];
?>

<?php if (!empty($data['title'])): ?>
    <section class="promo-consists wrapper">
        <div class="promo-consists__content">
            <?php if ($data['title']): ?>
                <h1 class="promo-consists__title">
                    <?= $data['title'] ?>
                </h1>
            <?php endif; ?>

            <?php if (!empty($items)): ?>
                <ul class="promo-consists__items">
                    <?php foreach ($items as $i): ?>
                        <li class="promo-consists__item">
                            <span class="promo-banner__badge promo-banner__badge--badge">
                                <?= $i['badge'] ?>
                            </span>
                            <h3 class="promo-consists__item--title">
                                <?= $i['title'] ?>
                            </h3>
                            <div class="promo-consists__item--text">
                                <?= $i['text'] ?>
                            </div>
                        </li>
                    <?php endforeach; ?>
                </ul>
            <?php endif; ?>
        </div>
    </section>
<?php endif; ?>