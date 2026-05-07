<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> modal-questions modal">
    <form action="" class="modal-questions__wrapper">
        <div class="modal-questions__top">
            <h3 class="modal-questions__top-title">
                <?= $data["modal_questions_title"] ?? 'Остались вопросы?' ?>
            </h3>

            <button class="modal-questions__close" type="button">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                    <path fill-rule="evenodd" clip-rule="evenodd"
                          d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z"/>
                </svg>
            </button>
        </div>

        <p class="modal-questions__text">
            <?= $data["modal_questions_text"] ?? 'Оставьте свои контакты и мы вам перезвоним в течение 15 минут (в рабочее время)' ?>
        </p>

        <div class="modal-questions__inputs">
            <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                'class_name' => 'modal-questions__input',
                'placeholder' => 'Имя*',
                'name' => 'name',
                'id' => 'nameQ',
            ]) ?>
            <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                'class_name' => 'modal-questions__input',
                'placeholder' => 'Телефон*',
                'name' => 'phone',
                'id' => 'phoneQ',
            ]) ?>
            <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                'class_name' => 'modal-questions__input',
                'placeholder' => 'Почта*',
                'name' => 'email',
                'id' => 'emailQ',
            ]) ?>
        </div>
        <?php App\Layout\UIKit\CheckboxPolicy\Layout::draw([
            'class_name' => 'modal-questions__checkbox',
            'checked' => true,
        ]); ?>

        <?php App\Layout\Components\Common\Button\Layout::draw([
            'text' => 'Отправить',
            'style' => 'primary',
            'class_name' => 'modal-questions__button',
            'type' => 'submit',
        ]); ?>
    </form>
    <div class="modal-questions__mask"></div>
</div>