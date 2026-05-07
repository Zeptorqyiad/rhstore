<div class="order-type-card__details hidden" data-details="<?= $value ?>">
    <?php
    $map = [];
    foreach (\App\Extensions\Catalog\Model\Transcomp::find('pid = ' . $value, 'npp') as $c) {
        $map[$c->transcomp_id] = [$c->name, $c->price];
    }
    App\Layout\Components\Common\Dropdown\Layout::draw([
        'placeholder' => 'Выбрать транспортную компанию',
        'class_name' => 'order-type-card__dropdown',
        'name' => 'transcomp_id2',
        'items' => $map,
        'ns' => true,
    ]); ?>
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