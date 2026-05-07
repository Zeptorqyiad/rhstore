<?php
/** @var array $data */
extract($data)
?>

<dialog class="modal-auth <?= $data['class_name'] ?>">
    <?php App\Layout\UIKit\ButtonModalClose\Layout::draw(); ?>

    <?php App\Layout\Components\AccountBlocks\SignIn\AuthorizationForm\Layout::draw([
        'class_name' => 'modal-auth__form',
        'form_id' => '1',
    ]); ?>

    <?php App\Layout\Components\AccountBlocks\SignUp\RegistrationForm\Layout::draw([
        'class_name' => 'modal-auth__form',
        'form_id' => '1',
    ]); ?>
</dialog>
