<div class="order-type-card__details hidden" data-details="<?= $value ?>">
    <div class="order-type-card__input-row">
        <?php App\Layout\UIKit\CitySelector\Layout::draw(); ?>
        <?php
        App\Layout\Components\Common\VariantTextField\Layout::draw([
            'class_name' => 'delivery-type__input',
            'placeholder' => 'Улица, дом, квартира/офис*',
            'name' => 'address',
            'value' => $user->address,
            'autocomplete' => 'street-address',
            'required' => true,
        ]) ?>
    </div>
</div>