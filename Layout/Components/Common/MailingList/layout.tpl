<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> mailing-list">
    <div class="mailing-list__container wrapper">

        <div class="mailing-list__card">
            <h3 class="mailing-list__card-title">
                Не нашли что искали?
            </h3>
            <p class="mailing-list__card-text">
                Сообщите нам о нужном товаре, и мы постараемся добавить его в каталог
            </p>

            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Сообщить',
                'style' => 'primary',
                'class_name' => 'mailing-list__card-button mailing-list__card-button_modal',
            ]); ?>
        </div>

        <form class="mailing-list__mail-card" action="/form/" data-validate>
            <h3 class="mailing-list__mail-card-title">
                Будьте в курсе последних акций
            </h3>

            <div class="mailing-list__mail-card-line">
                <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                    'class_name' => 'mailing-list__mail-card-input',
                    'placeholder' => 'Введите ваш e-mail',
                    'name' => 'email',
                    'id' => 'mailListInput',
                    'required' => true,
                    'autocomplete' => 'email',
                    'validate' => 'required|email',
                ]) ?>
                <?php App\Layout\UIKit\CheckboxPolicy\Layout::draw([
                    'class_name' => 'mailing-list__checkbox',
                    'checked' => true,
                    'required' => true,
                    'validate' => 'required|checkbox',
                ]); ?>
                <?php App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Отправить',
                    'style' => 'primary',
                    'class_name' => 'mailing-list__card-button submit-disabled',
                    'type' => 'submit',
                    'disabled' => true,
                ]); ?>
            </div>
        </form>
    </div>
</section>

<?php App\Layout\Components\Modals\ModalHelp\Layout::draw([
        'class_name' => 'mailing-list__modal',
]); ?>