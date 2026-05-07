<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> problem-two">
    <div class="wrapper">
        <?php \App\Layout\Components\Blocks\ForSellers\ProblemBadge\Layout::draw([
            'class_name' => 'problem-two__badge',
            'text' => 'Проблема 2 из 4'
        ]); ?>

        <h2 class="problem-two__title"><?= $data["problem_two_title"] ?></h2>

        <div class="problem-two__container">
            <div class="problem-two__first-column">
                <img src="<?= $data["problem_two_img"] ?>" alt="worker">
            </div>
            <div class="problem-two__second-column">
                <div class="problem-two__column-top">
                    <div class="problem-two__card-badge">
                        <?= $data["two_top_title_f"] ?>
                    </div>

                    <p class="problem-two__card-text">
                        <?= $data["two_top_text_f"] ?>
                    </p>
                </div>
                <div class="problem-two__column-bottom">
                    <div class="problem-three__card-decision">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                            <path d="M9.5 6.5H14C15.3807 6.5 16.5 7.61929 16.5 9C16.5 10.3807 15.3807 11.5 14 11.5H9.5V6.5ZM9.5 6.5V17.5M9.75 11.5H8M13 14.75H8M22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12Z"
                                  stroke="#0D0D0D" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span><?= $data["two_bottom_title_f"] ?></span>
                    </div>
                    <p class="problem-two__card-text">
                        <?= $data["two_bottom_text_f"] ?>
                    </p>
                </div>
            </div>
            <div class="problem-two__third-column">
                <div class="problem-two__column-top">
                    <div class="problem-two__card-badge">
                        <?= $data["two_top_title_s"] ?>
                    </div>
                    <p class="problem-two__card-text">
                        <?= $data["two_top_text_s"] ?>
                    </p>
                </div>

                <div class="problem-two__column-bottom">
                    <div class="problem-three__card-decision">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                            <path d="M11.5 5H11.9344C14.9816 5 16.5053 5 17.0836 5.54729C17.5836 6.02037 17.8051 6.71728 17.6702 7.39221C17.514 8.17302 16.2701 9.05285 13.7823 10.8125L9.71772 13.6875C7.2299 15.4471 5.98599 16.327 5.82984 17.1078C5.69486 17.7827 5.91642 18.4796 6.41636 18.9527C6.99474 19.5 8.51836 19.5 11.5656 19.5H12.5M8 5C8 6.65685 6.65685 8 5 8C3.34315 8 2 6.65685 2 5C2 3.34315 3.34315 2 5 2C6.65685 2 8 3.34315 8 5ZM22 19C22 20.6569 20.6569 22 19 22C17.3431 22 16 20.6569 16 19C16 17.3431 17.3431 16 19 16C20.6569 16 22 17.3431 22 19Z"
                                  stroke="#0D0D0D" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <?= $data["two_bottom_title_s"] ?>
                    </div>
                    <p class="problem-two__card-text">
                        <?= $data["two_bottom_text_s"] ?>
                    </p>

                    <?php App\Layout\Components\Common\Button\Layout::draw([
                        'text' => 'Оставить заявку',
                        'style' => 'secondary',
                        'class_name' => 'problem-two__button',
                        'modal' => 'modalPromo'
                    ]); ?>
                </div>
            </div>
        </div>
    </div>
</section>
