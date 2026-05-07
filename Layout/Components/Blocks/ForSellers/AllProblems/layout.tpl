<?php
/** @var array $data */

?>

<section class="<?= $data["class_name"] ?> all-problems">
    <div class="all-problems__container wrapper">
        <div class="all-problems__box">
            <h2 class="all-problems__title">
                <span><?= $data["problems_title"] ?> </span>
                <span><?= $data["problems_title_accent"] ?></span>
            </h2>
            <p class="all-problems__text">
                <?= $data["problems_text"] ?>
            </p>
        </div>
        <div class="all-problems__info">
            <p class="all-problems__info-text">
                <?= $data["problems_info_text"] ?>
            </p>
            <div class="all-problems__info-img">
                <img src="<?= $data["problems_info_img"] ?>" alt="businessman">
            </div>
        </div>
        <ul class="all-problems__cards">
            <?php
            foreach ($data['problems_cards'] as $problems_card) {
                App\Layout\Components\Common\AllProblemsCard\Layout::draw([
                    'img' => $problems_card['img'],
                    'title' => $problems_card['title'],
                    'text' => $problems_card['text'],
                ]);
            }
            ?>
        </ul>

    </div>
</section>
