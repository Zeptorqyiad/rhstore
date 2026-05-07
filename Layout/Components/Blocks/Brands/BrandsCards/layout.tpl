<?php
/** @var array $data */

?>

<section class="<?= $data["class_name"] ?> brands-cards">
    <ul class="brands-cards__container wrapper">
        <?php
        foreach ($data['cards'] as $card): ?>
            <li class="brands-cards__card">
                <h2 class="brands-cards__title">
                    <?= $card['name'] ?>
                </h2>
                <p class="brands-cards__text">
                    <?= $card['desc'] ?>
                </p>
                <div class="brands-cards__buttons">
                        <?php if ($card['link_brand']) {
                            App\Layout\Components\Common\Button\Layout::draw([
                                'text' => 'К бренду',
                                'style' => 'primary',
                                'class_name' => 'brands-cards__first-button',
                                'link' => $card['link_brand'],
                            ]);
                        }  ?>

                        <?php App\Layout\Components\Common\Button\Layout::draw([
                            'text' => 'Подробнее',
                            'style' => 'secondary',
                            'class_name' => 'brands-cards__second-button',
                            'link' => $card['link_more'],
                            'attr' => 'target="_blank"',
                        ]); ?>
                </div>
                <div class="brands-cards__logo">
                    <img src="<?= $card['img'] ?>" alt="<?= $card['name'] ?>" draggable="false">
                </div>
            </li>
        <?php
        endforeach; ?>
    </ul>
</section>