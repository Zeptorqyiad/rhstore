<?php
/** @var array $data */

$items = json_decode($data['items'], true)['v'] ?? [];
?>

<?php if ($data['title'] || $data['items']): ?>
    <section class="promo-stages wrapper">
        <?php if ($data['title']): ?>
            <h1 class="promo-stages__title">
                <?= $data['title'] ?>
            </h1>
        <?php endif; ?>

        <div class="promo-stages__content">
            <?php if ($data['image']): ?>
                <div class="promo-stages__content-ls">
                    <img src="/uf/images/source/<?= $data['image'] ?>" alt="">
                </div>
            <?php endif; ?>

            <ul class="promo-stages__content-rs">
                <?php foreach ($items as $index => $i): ?>
                    <li class="promo-stages__item <?= $index === 3 ? 'accentColor' : '' ?>">
                        <span class="promo-banner__badge promo-banner__badge--badge">
                            <?= $i['number'] ?>
                        </span>
                        <div class="promo-stages__item_text-block">
                            <h3 class="promo-stages__item--title">
                                <?= $i['title'] ?>
                            </h3>
                            <div class="promo-stages__item--text">
                                <?= $i['text'] ?>
                            </div>
                        </div>
                        <?php if ($index === 0) {
                            App\Layout\Components\Common\Button\Layout::draw([
                                'text' => $data['button-text'] ?: 'Написать',
                                'style' => 'secondary',
                                'class_name' => 'promo-stages__item--btn',
                                'modal' => 'modalPromo',
                            ]);
                        } ?>
                    </li>
                <?php endforeach; ?>
            </ul>
        </div>
    </section>
<?php endif; ?>