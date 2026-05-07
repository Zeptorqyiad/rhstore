<?php
/** @var array $data */

?>

<section class="<?= $data["class_name"] ?> problem-four">
    <div class="wrapper">
        <?php
        \App\Layout\Components\Blocks\ForSellers\ProblemBadge\Layout::draw([
            'class_name' => 'problem-four__badge',
            'text' => 'Проблема 4 из 4'
        ]); ?>

        <h2 class="problem-four__title"><?= $data["problem_four_title"] ?></h2>

        <div class="problem-four__container">

            <div class="problem-four__image">
                <img src="<?= $data["problem_four_img"] ?>" alt="hands">
            </div>

            <ul class="problem-four__cards">
                <?php
                foreach ($data['four_items'] as $four_item) {
                    App\Layout\Components\Common\ProblemFourItem\Layout::draw([
                        'title_f' => $four_item['title_f'],
                        'text_f' => $four_item['text_f'],
                        'img' => $four_item['img'],
                        'title_s' => $four_item['title_s'],
                        'text_s' => $four_item['text_s'],
                    ]);
                }
                ?>

            </ul>

        </div>
    </div>
</section>
