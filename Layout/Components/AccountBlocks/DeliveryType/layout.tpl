<?php

/** @var array $data */
$user = \Simflex\Core\Container::getUser();
?>

<form class="delivery-type" data-validate>
    <div class="delivery-type__details">
        <div class="delivery-type__address">
            <p class="delivery-type__title">Адрес и способ доставки</p>
            <p class="delivery-type__subtitle">Выберите то, как вам удобно получить заказ</p>
            <fieldset class="delivery-type__radio-list">
                <?php
                foreach (\App\Extensions\Catalog\Model\Transcomp::findAdv()->where('coalesce(pid, 0) = 0')->orderBy('npp')->all() as $c): ?>
                    <?php
                    App\Layout\Components\AccountBlocks\OrderTypeCard\Layout::draw([
                        'input_name' => 'transcomp_id',
                        'user' => $user->transcomp_id == $c->transcomp_id,
                        'value' => $c->transcomp_id,
                        'name' => $c->name,
                        'desc' => $c->delivery_time,
                        'price' => $c->price,
                        'checked' => true,
                        'template' => $c->template_name,
                        'type' => 'pickup',
                    ]); ?>
                <?php
                endforeach; ?>
            </fieldset>
        </div>
        <div class="delivery-type__credentials">
            <p class="delivery-type__title">Получатель</p>
            <p class="delivery-type__subtitle">Эти данные нужны, чтобы мы знали, кому отправлять заказ</p>
            <div class="delivery-type__input-list">
                <div class="delivery-type__input-row">
                    <?php
                    App\Layout\Components\Common\VariantTextField\Layout::draw([
                        'class_name' => 'delivery-type__input',
                        'placeholder' => 'Фамилия*',
                        'name' => 'last_name',
                        'value' => $user->other_last_name ?: $user->last_name,
                        'required' => true,
                        'autocomplete' => 'family-name',
                        'validate' => 'required',
                    ]) ?>
                    <?php
                    App\Layout\Components\Common\VariantTextField\Layout::draw([
                        'class_name' => 'delivery-type__input',
                        'placeholder' => 'Имя*',
                        'name' => 'name',
                        'value' => $user->other_name ?: $user->name,
                        'required' => true,
                        'autocomplete' => 'given-name',
                        'validate' => 'required',
                    ]) ?>
                </div>
                <div class="delivery-type__input-row">
                    <?php
                    App\Layout\Components\Common\VariantTextField\Layout::draw([
                        'class_name' => 'delivery-type__input',
                        'placeholder' => 'Телефон*',
                        'name' => 'phone',
                        'value' => $user->other_phone ?: $user->phone,
                        'required' => true,
                        'autocomplete' => 'tel',
                        'validate' => 'required|phone',
                    ]) ?>
                    <?php
                    App\Layout\Components\Common\VariantTextField\Layout::draw([
                        'class_name' => 'delivery-type__input',
                        'placeholder' => 'E-mail*',
                        'name' => 'email',
                        'value' => $user->other_email ?: $user->email,
                        'required' => true,
                        'autocomplete' => 'email',
                        'validate' => 'required|email',
                    ]) ?>
                </div>

                <?php App\Layout\UIKit\OrganizationSelect\Layout::draw(); ?>

            </div>
        </div>
    </div>
    <?php
    App\Layout\Components\AccountBlocks\CheckoutCard\Layout::draw([
        'check_text' => 'К оформлению заказа',
    ]); ?>
</form>