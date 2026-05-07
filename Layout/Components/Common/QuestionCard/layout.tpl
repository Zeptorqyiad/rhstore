<?php
/** @var array $data */
extract($data);
?>

<li class="question-card">
    <div class="question-card__top">
        <p class="question-card__name"><?= $card['name'] ?></p>
        <p class="question-card__date"><?= $card['date'] ?></p>
    </div>
    <div class="question-card__center">
        <p class="question-card__title">Вопрос:</p>
        <p class='question-card__question'><?=  $card['q'] ?></p>
    </div>
    <?php if ($card['a']): ?>
        <div class="question-card__bottom">
            <svg class="question-card__icon" xmlns="http://www.w3.org/2000/svg" stroke="#CCC" fill="none" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M20.791 12.607c.244-.209.366-.314.411-.438a.5.5 0 0 0 0-.338c-.045-.125-.167-.23-.41-.439l-8.471-7.26c-.42-.36-.63-.54-.809-.545a.5.5 0 0 0-.4.184C11 3.909 11 4.186 11 4.739v4.295a9.666 9.666 0 0 0-8 9.517v.612a11.4 11.4 0 0 1 8-4.093v4.19c0 .554 0 .83.112.969a.5.5 0 0 0 .4.184c.178-.005.388-.185.809-.545l8.47-7.26Z"/>
            </svg>
            <p class="question-card__title">Ответ магазина:</p>
            <div class="question-card__answer-body">
                <p ><?= $card['a'] ?></p>
            </div>
        </div>
    <?php endif; ?>
</li>