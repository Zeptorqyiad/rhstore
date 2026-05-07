<?php

/** @var array $data */

?>

<div class="<?= $data["class_name"] ?> modal-checklist modal modal-checklist" data-modal="checklist">
    <div class="modal-checklist__content modal-checklist__inner" data-modal-content="checklist">
        <button class="modal-checklist__close modal-checklist__close" type="button" data-close="checklist">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                <path fill-rule="evenodd"
                      clip-rule="evenodd"
                      d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z" />
            </svg>
        </button>

        <div class="modal-checklist__firstscreen">
            <h2 class="modal-checklist__top-title modal-checklist__title">
                <?= $data["checklist_title"] ?>
            </h2>
            <p class="modal-checklist__text modal-checklist__description">
                <?= $data["checklist_text"] ?>
            </p>

            <div class="modal-checklist__bottom">
                <?php
                App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Начать',
                    'style' => 'blue',
                    'class_name' => 'modal-checklist__start modal-checklist__btn',
                    'type' => 'button'
                ]); ?>
            </div>
        </div>

        <form class="modal-checklist__form" novalidate data-validate>
            <div class="modal-checklist__form-wrap">
                <div class="modal-checklist__form-fields modal-checklist__first" data-index="0">
                    <h2 class="modal-checklist__form-title"><?= $data["checklist_title_fst"] ?> </h2>
                    <?php
                    App\Layout\Components\Common\CheckboxList\Layout::draw([
                        'class_name' => 'modal-checklist__checkboxes',
                        'items' => $data['checkboxes_fst']
                    ]);
                    ?>
                </div>

                <div class="modal-checklist__form-fields modal-checklist__sec" data-index="1">
                    <h2 class="modal-checklist__form-title"><?= $data["checklist_title_s"] ?></h2>
                    <?php

                    App\Layout\Components\Common\CheckboxList\Layout::draw([
                        'class_name' => 'modal-checklist__checkboxes',
                        'items' => $data['checkboxes_s']
                    ]);
                    ?>
                </div>

                <div class="modal-checklist__form-fields modal-checklist__third" data-index="2">
                    <h2 class="modal-checklist__form-title"><?= $data["checklist_title_t"] ?></h2>
                    <?php
                    App\Layout\Components\Common\CheckboxList\Layout::draw([
                        'class_name' => 'modal-checklist__checkboxes',
                        'items' => $data['checkboxes_t']
                    ]);
                    ?>
                </div>

                <div class="modal-checklist__form-fields modal-checklist__fourth" data-index="3">
                    <h2 class="modal-checklist__form-title"><?= $data["checklist_title_frth"] ?></h2>
                    <?php
                    App\Layout\Components\Common\CheckboxList\Layout::draw([
                        'class_name' => 'modal-checklist__checkboxes',
                        'items' => $data['checkboxes_frth']
                    ]);
                    ?>
                </div>

                <div class="modal-checklist__form-fields modal-checklist__fifth" data-index="4">
                    <h2 class="modal-checklist__form-title modal-checklist__form-title--blue"><?= $data["checklist_title_fth"] ?></h2>
                    <?php
                    App\Layout\Components\Common\CheckboxList\Layout::draw([
                        'class_name' => 'modal-checklist__checkboxes',
                        'items' => $data['checkboxes_fth']
                    ]);
                    ?>
                    <div class="modal-checklist__form-note">
                        <div class="modal-checklist__form-note-description">Интересно, что за бонусы? Свяжитесь с нами, и мы вам подробно расскажем об условиях и о том, как их получить</div>
                        <button type="button" class="modal-checklist__form-note-btn">Получить бонусы</button>
                    </div>
                </div>

                <div class="modal-checklist__form-bottom">
                    <?php
                    App\Layout\Components\Common\Button\Layout::draw([
                        'text' => 'Далее',
                        'style' => 'secondary',
                        'class_name' => 'modal-checklist__form-btn',
                        'type' => 'button'
                    ]); ?>
                    <div class="modal-checklist__form-progress progress">
                        <div class="progress__value progress__value--start">1</div>
                        <div class="progress__bar">
                            <div class="progress__bar-progress"></div>
                            <div class="progress__bar-bg"></div>
                        </div>
                        <div class="progress__value progress__value--end">5</div>
                    </div>
                </div>
            </div>

            <div class="modal-checklist__result">

                <h2 class="modal-checklist__result-title"></h2>
                <p class="modal-checklist__result-text"></p>

                <div class="modal-checklist__result-inputs">
                    <?php
                    App\Layout\Components\Common\VariantTextField\Layout::draw([
                        'class_name' => 'modal-checklist__result-input',
                        'placeholder' => 'Имя*',
                        'name' => 'name',
                        'required' => true,
                        'autocomplete' => 'given-name',
                        'validate' => 'required',
                    ]) ?>

                    <?php
                    App\Layout\Components\Common\VariantTextField\Layout::draw([
                        'class_name' => 'modal-checklist__result-input',
                        'placeholder' => 'Телефон*',
                        'name' => 'phone',
                        'required' => true,
                        'autocomplete' => 'tel',
                        'validate' => 'required|phone',
                    ]) ?>

                    <?php
                    App\Layout\Components\Common\VariantTextField\Layout::draw([
                        'class_name' => 'modal-checklist__result-input',
                        'placeholder' => 'Почта*',
                        'name' => 'email',
                        'required' => true,
                        'autocomplete' => 'email',
                        'validate' => 'required|email',
                    ]) ?>
                </div>

                <div class="modal-checklist__result-bottom">
                    <?php
                    App\Layout\Components\Common\Button\Layout::draw([
                        'text' => 'Отправить',
                        'style' => 'blue',
                        'class_name' => 'modal-checklist__submit button-blue',
                        'type' => 'submit'
                    ]); ?>

                    <?php App\Layout\UIKit\CheckboxPolicy\Layout::draw([
                        'class_name' => 'modal-checklist__policy',
                        'checked' => true,
                        'required' => true,
                        'validate' => 'required|checkbox',
                    ]); ?>
                </div>
            </div>

        </form>

    </div>

</div>

