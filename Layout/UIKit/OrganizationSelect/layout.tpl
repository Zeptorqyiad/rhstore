<?php
/** @var array $data */

$user = \Simflex\Core\Container::getUser();
$isGuest = false;
if (!$user) {
    $isGuest = true;
    $user = (object)[
        'org_active' => 0,
        'org_name' => '',
        'org_inn' => '',
    ];
}

?>

<div class="organization-select">
    <?php
    App\Layout\Components\Common\Checkbox\Layout::draw([
        'text' => 'Я из организации',
        'class_name' => 'organization-select__checkbox',
        'name' => 'org_active',
        'checked' => $user->org_active,
        'value' => 1,
        'validate' => $isGuest ? null : 'required',
    ]); ?>
    <div class="organization-select__wrapper <?= $user->org_active ? 'organization-select__wrapper_active' : '' ?> <?= $data['class_name'] ?? '' ?>">
        <input type="hidden" name="org_name" value="<?= $user->org_name ?>">
        <div class="organization-select__line">
            <div class="organization-select__dropdown">
                <?php
                App\Layout\Components\Common\TextField\Layout::draw([
                    'class_name' => 'organization-select__org-input js--inn',
                    'placeholder' => 'Поиск',
                    'name' => 'org_inn',
                    'value' => $user->org_inn,
                ]); ?>

                <div class="organization-select__dropdown-wrapper">
                    <ul class="organization-select__dropdown-list">

                    </ul>
                </div>
            </div>

            <?php
            App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Найти',
                'style' => 'primary',
                'type' => 'button',
                'class_name' => 'organization-select__org-button js--find-inn',
            ]); ?>

        </div>
        <div class="organization-select__details">
            <p class="organization-select__text">Наименование организации:</p>
            <p class="organization-select__name js--org-name"><?= $user->org_name ?: 'Начните поиск' ?></p>
        </div>
    </div>
</div>
