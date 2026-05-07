<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> modal-sales modal">
    <form action="" class="modal-sales__form" novalidate data-validate>
        <div class="modal-sales__content">
            <button class="modal-sales__close" type="button">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                    <path fill-rule="evenodd" clip-rule="evenodd"
                          d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z"/>
                </svg>
            </button>
            <h2 class="modal-sales__top-title">
                <?= $data["sales_title"] ?>
            </h2>
            <p class="modal-sales__text">
                <?= $data["sales_text"] ?>
            </p>

            <div class="modal-sales__inputs">
                <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'modal-sales__input',
                    'placeholder' => 'Имя*',
                    'name' => 'name',
                    'required' => true,
                    'autocomplete' => 'given-name',
                    'validate' => 'required',
                ]) ?>
                <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'modal-sales__input',
                    'placeholder' => 'Телефон*',
                    'name' => 'phone',
                    'required' => true,
                    'autocomplete' => 'tel',
                    'validate' => 'required|phone',
                ]) ?>
                <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'modal-sales__input',
                    'placeholder' => 'Почта*',
                    'name' => 'email',
                    'required' => true,
                    'autocomplete' => 'email',
                    'validate' => 'required|email',
                ]) ?>
            </div>

            <div class="modal-sales__bottom">
                <?php App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Отправить',
                    'style' => 'blue',
                    'class_name' => 'modal-sales__button',
                    'type' => 'submit'

                ]); ?>

                <?php App\Layout\UIKit\CheckboxPolicy\Layout::draw([
                    'class_name' => 'consultation__policy',
                    'checked' => true,
                    'required' => true,
                    'validate' => 'required|checkbox',
                ]); ?>
            </div>
        </div>
    </form>
    <div class="modal-sales__mask"></div>
</div>