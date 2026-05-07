<?php
/** @var array $data */

$user = \Simflex\Core\Container::getUser();
?>

<?php
App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php
App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="delivery-edit">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'delivery-edit__breadcrumbs wrapper',
        'text' => 'Доставка'
    ]);
    ?>

    <section class="delivery-edit__container wrapper">
        <form class="delivery-edit-type" novalidate data-validate>
            <div class="delivery-edit-type__details">
                <div class="delivery-edit-type__address">
                    <p class="delivery-edit-type__title">Адрес и способ доставки</p>
                    <p class="delivery-edit-type__subtitle">Выберите то, как вам удобно получить заказ</p>
                    <fieldset class="delivery-edit-type__radio-list">
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
                            ]); ?>
                        <?php
                        endforeach; ?>
                    </fieldset>
                </div>
                <div class="delivery-edit-type__credentials">
                    <p class="delivery-edit-type__title">Получатель</p>
                    <p class="delivery-edit-type__subtitle">Эти данные нужны, чтобы мы знали, кому отправлять заказ</p>
                    <div class="delivery-edit-type__input-list">
                        <div class="delivery-edit-type__input-row">
                            <?php
                            App\Layout\Components\Common\VariantTextField\Layout::draw([
                                'class_name' => 'delivery-edit-type__input',
                                'placeholder' => 'Фамилия*',
                                'name' => 'last_name',
                                'value' => $user->other_last_name ?: $user->last_name,
                                'required' => true,
                                'autocomplete' => 'family-name',
                                'validate' => 'required',
                            ]) ?>
                            <?php
                            App\Layout\Components\Common\VariantTextField\Layout::draw([
                                'class_name' => 'delivery-edit-type__input',
                                'placeholder' => 'Имя*',
                                'name' => 'name',
                                'value' => $user->other_name ?: $user->name,
                                'required' => true,
                                'autocomplete' => 'given-name',
                                'validate' => 'required',
                            ]) ?>
                        </div>
                        <div class="delivery-edit-type__input-row">
                            <?php
                            App\Layout\Components\Common\VariantTextField\Layout::draw([
                                'class_name' => 'delivery-edit-type__input',
                                'placeholder' => 'Телефон*',
                                'name' => 'phone',
                                'value' => $user->other_phone ?: $user->phone,
                                'required' => true,
                                'autocomplete' => 'tel',
                                'validate' => 'required|phone',
                            ]) ?>
                            <?php
                            App\Layout\Components\Common\VariantTextField\Layout::draw([
                                'class_name' => 'delivery-edit-type__input',
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
            <div class="delivery-edit-type__box-bottom-buttons">
                <?php
                App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Сохранить',
                    'style' => 'primary',
                    'class_name' => 'delivery-edit-type__button delivery-edit-type__submit',
                    'type' => 'submit'
                ]); ?>
                <p class="delivery-edit-type__changes hidden">Есть изменения</p>
            </div>
        </form>
    </section>
</main>

<?php
App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php
App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
