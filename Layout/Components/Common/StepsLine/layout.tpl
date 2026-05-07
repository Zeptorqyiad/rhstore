<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> steps-line">
    <div class="steps-line__step <?= $data['step'] === '1' ? 'steps-line__current-step' : '' ?>">
        <div class="steps-line__step-number"><span>1</span></div>
        <div class="steps-line__step-text">Авторизация</div>
    </div>

    <div class="steps-line__line">
        <svg viewBox="0 0 80 2" fill="none" xmlns="http://www.w3.org/2000/svg">
            <line x1="1" y1="1" x2="79" y2="1" stroke="#FFABAB" stroke-width="2" stroke-linecap="round"
                  stroke-dasharray="4 4"/>
        </svg>
    </div>

    <div class="steps-line__step <?= $data['step'] === '2' ? 'steps-line__current-step' : '' ?>">
        <div class="steps-line__step-number"><span>2</span></div>
        <div class="steps-line__step-text">Способ доставки</div>
    </div>

    <div class="steps-line__line">
        <svg viewBox="0 0 80 2" fill="none" xmlns="http://www.w3.org/2000/svg">
            <line x1="1" y1="1" x2="79" y2="1" stroke="#FFABAB" stroke-width="2" stroke-linecap="round"
                  stroke-dasharray="4 4"/>
        </svg>
    </div>

    <div class="steps-line__step <?= $data['step'] === '3' ? 'steps-line__current-step' : '' ?>">
        <div class="steps-line__step-number"><span>3</span></div>
        <div class="steps-line__step-text">Оформление заказа</div>
    </div>
</div>