<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> frequent-questions">
    <div class="frequent-questions__container wrapper">
        <h2 class="frequent-questions__title"><?= $data["frequent_title"] ?></h2>

        <ul class="frequent-questions__box">
            <?php
            foreach ($data['frequent_cards'] as $frequent_card): ?>
                <li class="frequent-questions__item">
                    <?php App\Layout\Components\Common\Accordion\Layout::draw([
                        'title' => $frequent_card['title'],
                        'text' => $frequent_card['text']
                    ]); ?>
                </li>
            <?php endforeach; ?>
        </ul>
    </div>
</section>