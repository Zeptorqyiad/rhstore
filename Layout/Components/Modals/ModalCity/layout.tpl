<?php
/** @var array $data */
$user = \Simflex\Core\Container::getUser();

?>

<div class="<?= $data["class_name"] ?> modal-city modal">
    <div class="modal-city__wrapper">
        <div class="modal-city__first-content">
            <p class="modal-city__title">
                <span>Ваш город:</span>
                <span><?= \App\Plugins\GeoIp\GeoIp::getCurrentCity() ?>?</span>
            </p>


            <div class="modal-city__buttons">
                <?php
                App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Да, верно',
                    'style' => 'primary',
                    'class_name' => 'modal-city__button modal-city__yes-button',
                    'type' => 'button',
                ]); ?>
                <?php
                App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Указать другой',
                    'style' => 'secondary',
                    'class_name' => 'modal-city__button modal-city__selections-button',
                    'type' => 'button',
                ]); ?>
            </div>
        </div>

        <div class="modal-city__second-content">
            <p class="modal-city__title">
                <span>Укажите ваш город:</span>
            </p>
            <div class="modal-city__dropdown">
                <?php
                App\Layout\Components\Common\TextField\Layout::draw([
                    'placeholder' => 'Начните вводить город',
                    'class_name' => 'modal-city__text-field',
                    'name' => 'city',
                    'value' => $user->city ?: \App\Plugins\GeoIp\GeoIp::getCurrentCity(),
                ]); ?>

                <div class="modal-city__dropdown-wrapper">
                    <ul class="modal-city__dropdown-list">

                    </ul>
                </div>
            </div>

            <?php
            App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Сохранить',
                'style' => 'primary',
                'class_name' => 'modal-city__button modal-city__save-button',
                'type' => 'button',
            ]); ?>
        </div>
    </div>
</div>