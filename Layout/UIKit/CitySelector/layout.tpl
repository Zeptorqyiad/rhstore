<?php
/** @var array $data */
$user = \Simflex\Core\Container::getUser();
?>

<div class="city-selector">
    <?php
    App\Layout\Components\Common\VariantTextField\Layout::draw([
        'class_name' => 'city-selector__input city-selector__input_phone',
        'placeholder' => 'Город*',
        'val' => $user->city ?: \App\Plugins\GeoIp\GeoIp::getCurrentCity(),
        'name' => 'city',
        'autocomplete' => 'off',
        'required' => true,
    ]) ?>

    <div class="city-selector__dropdown-wrapper">
        <ul class="city-selector__dropdown-list">

        </ul>
    </div>
</div>