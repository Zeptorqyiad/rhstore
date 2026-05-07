<?php
/** @var array $data */

?>

<div class="<?= $data["class_name"] ?> modal-city-mobile modal">
    <div class="modal-city-mobile__wrapper">
        <div class="modal-city-mobile__nav">
            <svg class="modal-city-mobile__icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                <path stroke="#404040" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m15 6-6 6 6 6"/>
            </svg>
            <svg class="modal-city-mobile__icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                <path fill="#404040" fill-rule="evenodd" d="M3.293 3.293a1 1 0 0 1 1.414 0L12 10.586l7.293-7.293a1 1 0 1 1 1.414 1.414L13.414 12l7.293 7.293a1 1 0 0 1-1.414 1.414L12 13.414l-7.293 7.293a1 1 0 0 1-1.414-1.414L10.586 12 3.293 4.707a1 1 0 0 1 0-1.414Z" clip-rule="evenodd"/>
            </svg>
        </div>
        <div class="modal-city-mobile__first-content">
            <p class="modal-city-mobile__title">
                <span>Ваш город:</span>
                <span><?= \App\Plugins\GeoIp\GeoIp::getCurrentCity() ?>?</span>
            </p>

            <div class="modal-city-mobile__buttons">
                <?php App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Да, верно',
                    'style' => 'primary',
                    'class_name' => 'modal-city-mobile__button modal-city-mobile__yes-button',
                    'type' => 'button',
                ]); ?>
                <?php App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Указать другой',
                    'style' => 'secondary',
                    'class_name' => 'modal-city-mobile__button modal-city-mobile__selections-button',
                    'type' => 'button',
                ]); ?>
            </div>
        </div>

        <div class="modal-city-mobile__second-content">
            <p class="modal-city-mobile__title">
                <span>Укажите ваш город:</span>
            </p>
            <div class="modal-city-mobile__dropdown">
                <?php
                App\Layout\Components\Common\TextField\Layout::draw([
                    'placeholder' => 'Начните вводить город',
                    'class_name' => 'modal-city-mobile__text-field',
                    'name' => 'city'
                ]); ?>

                <div class="modal-city-mobile__dropdown-wrapper">
                    <ul class="modal-city-mobile__dropdown-list">

                    </ul>
                </div>
            </div>

            <?php
            App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Сохранить',
                'style' => 'primary',
                'class_name' => 'modal-city-mobile__button modal-city-mobile__save-button',
                'type' => 'button',
            ]); ?>
        </div>
    </div>
</div>