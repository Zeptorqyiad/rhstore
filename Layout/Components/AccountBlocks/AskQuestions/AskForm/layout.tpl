<?php
/** @var array $data */
?>

<form class="<?= $data["class_name"] ?> ask-form">
    <h3 class="ask-form__title">
        Задайте вопрос
    </h3>

    <p class="ask-form__text">
        Вам ответит представитель бренда. Мы пришлем уведомление, когда поступит ответ.
    </p>

    <?php App\Layout\Components\Common\Textarea\Layout::draw([
        'class_name' => 'ask-form__textarea',
        'placeholder' => 'Напишите свой вопрос',
        'required' => 'true',
        'name' => 'message'
    ]); ?>

    <?php App\Layout\Components\Common\Button\Layout::draw([
        'text' => 'Отправить',
        'style' => 'primary',
        'class_name' => 'ask-form__button',
        'type' => 'sumbit'
    ]); ?>
</form>