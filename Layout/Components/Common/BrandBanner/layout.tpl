<?php
/** @var array $data */

?>

<div class="<?= $data["class_name"] ?> brand-banner">
    <div class="brand-banner__container">
        <p class="brand-banner__text">
            <?= $data["text"] ?>
        </p>

        <?php
        App\Layout\Components\Common\ButtonLinks\Layout::draw([
            'text' => $data['button_text'],
            'style' => 'secondary',
            'class_name' => 'brand-banner__button',
            'href' => $data['button_url'],
        ]); ?>

        <img class="brand-banner__img" src="<?= $data['img'] ?>" alt="g-rhino">
    </div>
    <button class="brand-banner__close-button">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
            <path fill="#fff" fill-rule="evenodd" d="M5.293 5.293a1 1 0 0 1 1.414 0L12 10.586l5.293-5.293a1 1 0 1 1 1.414 1.414L13.414 12l5.293 5.293a1 1 0 0 1-1.414 1.414L12 13.414l-5.293 5.293a1 1 0 0 1-1.414-1.414L10.586 12 5.293 6.707a1 1 0 0 1 0-1.414Z" clip-rule="evenodd"/>
        </svg>
    </button>
</div>