<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> accordion">
    <div class="accordion__question">
        <p class="accordion__title"> <?= $data['title'] ?> </p>
        <button class="accordion__toggle">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                <path d="M6 9L12 15L18 9" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </button>
    </div>
    <div class="accordion__answer">
        <div class="accordion__answer-text content">
            <?= $data['text'] ?>
        </div>
    </div>
</div>