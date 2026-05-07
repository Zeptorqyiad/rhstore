<?php
/** @var array $data */

?>

<section class="promotions wrapper">
    <div class="promotions__container">

        <h1 class="promotions__title">
            <?= $data['title'] ?>
        </h1>

        <ul class="promotions__list">
            <?php foreach ($data['items'] as $c):?>
                <li class="promotions__item">
                    <?php App\Layout\Components\Promo\PromoCard\Layout::draw([
                        'title' => $c->banner_title . ' ' . $c->banner_title_accent . ' ' . $c->banner_title_third,
                        'image' => '/uf/images/source/' . $c->photo,
                        'date' => $c->date,
                        'badge' => $c->badge,
                        'path' => '/promotions/' . $c->alias . '/',
                    ]); ?>
                </li>
            <?php endforeach; ?>
        </ul>
    </div>
</section>


