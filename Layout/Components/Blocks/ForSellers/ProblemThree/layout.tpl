<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> problem-three">
    <div class="wrapper">
        <?php \App\Layout\Components\Blocks\ForSellers\ProblemBadge\Layout::draw([
            'class_name' => 'problem-three__badge',
            'text' => 'Проблема 3 из 4'
        ]); ?>

        <h2 class="problem-three__title"><?= $data["problem_three_title"] ?></h2>

        <div class="problem-three__container">
            <div class="problem-three__column">
                <div class="problem-three__column-left">
                    <div class="problem-three__card-badge">
                        <?= $data["three_list_title"] ?>
                    </div>
                    <ul class="problem-three__list">
                        <?php
                        foreach ($data['three_items'] as $three_item)
                            App\Layout\Components\Common\ProblemThreeItem\Layout::draw([
                                'icon' => $three_item['icon'],
                                'text' => $three_item['text'],
                            ]);
                        ?>
                    </ul>
                </div>
            </div>
            <div class="problem-three__column">
                <ul class="problem-three__cards">
                    <li class="problem-three__card">
                        <div class="problem-three__card-decision">
                            <img src="<?= $data["three_icon_f"] ?>">
                            <span><?= $data["three_title_f"] ?></span>
                        </div>
                        <p class="problem-three__card-text">
                            <?= $data["three_text_f"] ?>
                        </p>
                    </li>
                    <li class="problem-three__card">
                        <img src="<?= $data["three_img_f"] ?>" alt="phone">
                    </li>
                    <li class="problem-three__card">
                        <div class="problem-three__card-decision">
                            <img src=" <?= $data["three_icon_s"] ?>">
                            <span><?= $data["three_title_s"] ?></span>
                        </div>
                        <p class="problem-three__card-text">
                            <?= $data["three_text_s"] ?>
                    </li>
                    <li class="problem-three__card">
                        <img src="<?= $data["three_img_s"] ?>" alt="docs">
                    </li>
                    <li class="problem-three__card">
                        <div class="problem-three__card-decision">
                            <img src="<?= $data["three_icon_t"] ?>">
                            <span><?= $data["three_title_t"] ?></span>
                        </div>
                        <p class="problem-three__card-text">
                            <?= $data["three_text_t"] ?>
                        </p>
                        <?php App\Layout\Components\Common\Button\Layout::draw([
                            'text' => 'Пройти чек-лист',
                            'style' => 'secondary',
                            'class_name' => 'problem-three__button',
                            'modal' => 'checklist'
                        ]); ?>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</section>
