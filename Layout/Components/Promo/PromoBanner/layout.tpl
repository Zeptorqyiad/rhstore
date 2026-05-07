<?php
/** @var array $data */

$items = json_decode($data['items'], true)['v'] ?? [];
?>

<section class="promo-banner wrapper">
    <div class="promo-banner__content">
        <div class="promo-banner__content-ls">
            <?php if ($data['image']): ?>
                <img src="/uf/images/source/<?= $data['image'] ?>" alt="">
            <?php endif; ?>
        </div>
        <div class="promo-banner__content-rs">
            <?php if ($data['title'] || $data['title-accent']): ?>
                <div class="promo-banner__title">
                    <?php if ($data['title']): ?>
                        <?= $data['title'] ?>
                    <?php endif; ?>
                    <span class="promo-banner__title--accent">
                        <?= $data['title-accent'] ?>
                    </span>
                    <span class="promo-banner__title--third">
                        <?= $data['title-third'] ?>
                    </span>
                </div>
            <?php endif; ?>

            <?php if ($data['date'] || $data['badge']): ?>
                <div class="promo-banner__badges">
                    <?php if ($data['date']): ?>
                        <span class="promo-banner__badge promo-banner__badge--date">
                            <?= $data['date'] ?>
                        </span>
                    <?php endif; ?>
                    <?php if ($data['badge']): ?>
                        <span class="promo-banner__badge promo-banner__badge--badge">
                            <?= $data['badge'] ?>
                        </span>
                    <?php endif; ?>
                </div>
            <?php endif; ?>

            <div class="promo-banner__offer">
                <?php if ($data['offer-title']): ?>
                    <h3 class="promo-banner__offer--title">
                        <?= $data['offer-title'] ?>
                    </h3>
                <?php endif; ?>

                <?php if ($data['offer-text']): ?>
                    <div class="promo-banner__offer--text">
                        <?= $data['offer-text'] ?>
                    </div>
                <?php endif; ?>

                <?php if ($items): ?>
                    <?php App\Layout\Components\Common\Separator\Layout::draw([
                        'className' => 'light'
                    ]); ?>
                    <ul class="promo-banner__bullits">
                        <?php foreach($items as $i): ?>
                            <li class="promo-banner__bullit">
                                <?= $i['text'] ?>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                <?php endif; ?>

                <?php if ($data['price'] || $data['price-throught']): ?>
                    <?php App\Layout\Components\Common\Separator\Layout::draw([
                        'className' => 'light'
                    ]); ?>
                    <div class="promo-banner__price">
                        <?php if ($data['price']): ?>
                            <span class="promo-banner__price--base">
                                <?= $data['price'] ?>
                            </span>
                        <?php endif; ?>

                        <?php if ($data['price-throught']): ?>
                            <span class="promo-banner__price--throught">
                                <?= $data['price-throught'] ?>
                            </span>
                        <?php endif; ?>
                    </div>
                    <?php App\Layout\Components\Common\Separator\Layout::draw([
                        'className' => 'light'
                    ]); ?>
                <?php endif; ?>

                <div class="promo-banner__social">
                    <?php
                        App\Layout\Components\Common\Button\Layout::draw([
                            'text' => $data['button-text'] ?: 'Оставить заявку',
                            'style' => 'primary',
                            'class_name' => 'promo-banner__social--btn',
                            'modal' => 'modalPromo',
                        ]);

                        App\Layout\Components\Common\SocialNetwork\Layout::draw();
                    ?>
                </div>
            </div>
        </div>
    </div>
</section>