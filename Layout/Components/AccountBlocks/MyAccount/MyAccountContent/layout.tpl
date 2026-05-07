<?php
/** @var array $data */

?>

    <div class="<?= $data["class_name"] ?> my-account-content">
        <h1 class="my-account-content__title">
            Мой аккаунт
        </h1>

        <?php
        \App\Layout\Components\AccountBlocks\MyAccount\MyAccountEmailCard\Layout::draw([
            'class_name' => 'my-account-content__email-card'
        ]); ?>

        <?php /*
        \App\Layout\Components\AccountBlocks\MyAccount\MyAccountLevel\Layout::draw([
            'class_name' => 'my-account-content__level'
        ]); */ ?>

        <?php
        \App\Layout\Components\AccountBlocks\MyAccount\MyAccountForms\Layout::draw([
            'class_name' => 'my-account-content__forms'
        ]); ?>

    </div>

<?php
App\Layout\Components\Modals\ModalNotification\Layout::draw(); ?>