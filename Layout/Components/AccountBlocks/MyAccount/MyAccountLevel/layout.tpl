<?php

/** @var array $data */
$user = \Simflex\Core\Container::getUser();
$level = $user->getLevel();
$nextLevel = $level->getNextLevel();
?>

<div class="<?= $data["class_name"] ?> my-account-level">

    <div class="my-account-level__top">
        <div class="my-account-level__top-card">
            <div class="my-account-level__top-card-svg">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                    <path d="M3 20C5.33579 17.5226 8.50702 16 12 16C15.493 16 18.6642 17.5226 21 20M16.5 7.5C16.5 9.98528 14.4853 12 12 12C9.51472 12 7.5 9.98528 7.5 7.5C7.5 5.01472 9.51472 3 12 3C14.4853 3 16.5 5.01472 16.5 7.5Z"
                          stroke="#0D0D0D" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>

            <div class="my-account-level__top-card-content">
                <h4 class="my-account-level__top-title-1 tc-<?= $level->color ?>">
                    <?= $level->name ?>
                </h4>

                <?php
                App\Layout\Components\Common\SaleInfo\Layout::draw([
                    'class_name' => 'my-account-level__hint',
                    'text' => 'Ваш уровень',
                    'hint_text' => $level->desc,
                    'secondary' => true,
                ]); ?>
            </div>
        </div>

        <div class="my-account-level__top-card">
            <div class="my-account-level__top-card-svg">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                    <path d="M10.101 4C11.3636 2.76281 13.0927 2 15 2C18.866 2 22 5.13401 22 9C22 10.9073 21.2372 12.6365 19.9999 13.899M7.5 13L9 12V17.5M7.5 17.5H10.5M16 15C16 18.866 12.866 22 9 22C5.13401 22 2 18.866 2 15C2 11.134 5.13401 8 9 8C12.866 8 16 11.134 16 15Z"
                          stroke="#0D0D0D" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>

            <div class="my-account-level__top-card-content">
                <h4 class="my-account-level__top-title-2">
                    <?= \Simflex\Core\Helpers\Str::price($user->spent ?? 0); ?>
                </h4>

                <?php
                App\Layout\Components\Common\SaleInfo\Layout::draw([
                    'class_name' => 'my-account-level__hint',
                    'text' => 'Сумма покупок',
                    'hint_text' => 'Подсказка Сумма покупок',
                    'secondary' => true
                ]); ?>
            </div>
        </div>
    </div>

    <?php
    if ($nextLevel): ?>
        <div class="my-account-level__description">
            Ваш прогресс перехода на следующий уровень:
        </div>

        <div class="my-account-level__progress-bar">
            <div class="my-account-level__progress"
                 style="width: <?= round(($user->spent / $nextLevel->min) * 100) ?>%"></div>
        </div>

        <div class="my-account-level__bottom">
        <span class="my-account-level__bottom-text">
            Для более выгодных покупок закажите ещё на:
        </span>
            <span class="my-account-level__bottom-price">
            <?= \Simflex\Core\Helpers\Str::price($nextLevel->min - $user->spent); ?>
        </span>
        </div>
    <?php
    else: ?>
        <div class="my-account-level__description">
            <span>Поздравляем! Вы достигли последнего уровня.</span>
            <span>Желаем вам успешных и выгодных покупок.</span>
        </div>

        <div class="my-account-level__progress-bar">
            <div class="my-account-level__progress"
                 style="width: 100%"></div>
        </div>
    <?php
    endif; ?>
</div>