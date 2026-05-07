<?php

/** @var array $data */
$user = \Simflex\Core\Container::getUser();
?>

<?php
if (!$user->mail_verified): ?>
    <div class="<?= $data["class_name"] ?> my-account-email-card">
        <p class="my-account-email-card__title">
            Подтвердите свой e-mail
        </p>
        <p class="my-account-email-card__text">
            Проверьте почту, нажмите на ссылку, и тогда мы уберём это окно
        </p>

        <?php
        App\Layout\Components\Common\Button\Layout::draw([
            'text' => 'Отправить ссылку снова',
            'style' => 'primary',
            'class_name' => 'my-account-email-card__button js--send-email'
        ]); ?>
    </div>
<?php
endif; ?>