<?php
/** @var array $data */

$phone = Simflex\Core\Core::siteParam('phone');
?>

<div class="modal-promo" data-modal="modalPromo">
    <div class="modal-promo__content" data-modal-content="modalPromo">
        <div class="modal-promo__top">
            <h3 class="modal-promo__top--title">Обратная связь</h3>

            <button class="modal-promo__close" type="button" data-close="modalPromo">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                    <path fill-rule="evenodd"
                          clip-rule="evenodd"
                          d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z"
                          fill="#404040" />
                </svg>
            </button>
        </div>

        <div class="modal-promo__social">
            <?php
                App\Layout\Components\Common\Button\Layout::draw([
                        'phone-icon' => true,
                        'link' => 'tel:'.$phone,
                        'text' => 'Позвонить: '.$phone,
                        'style' => 'secondary',
                        'class_name' => 'promo-form__social--btn'
                ]);
                App\Layout\Components\Common\SocialNetwork\Layout::draw();
            ?>
        </div>

        <?php
            App\Layout\Components\Common\Separator\Layout::draw([
                'className' => 'steel',
            ])
        ?>

        <div class="modal-promo__form">
            <div class="modal-promo__text">
                Оставьте свои контакты, мы свяжемся с вами и ответим на все ваши вопросы
            </div>

            <form class="modal-feedback__form" data-validate novalidate>
                <div class="modal-feedback__inputs">
                    <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                        'type' => 'tel',
                        'class_name' => 'modal-feedback__input',
//                        'placeholder' => 'Телефон*',
                        'name' => 'phone',
                        'id' => 'phone',
                        'required' => true,
                        'autocomplete' => 'tel',
                        'validate' => 'required|phone',
                    ]) ?>
                </div>

                <?php App\Layout\UIKit\CheckboxPolicy\Layout::draw([
                        'checked' => false,
                        'required' => true,
                        'validate' => 'required|checkbox',
                ]); ?>

                <?php App\Layout\Components\Common\Button\Layout::draw([
                        'text' => 'Отправить',
                        'style' => 'primary',
                        'class_name' => 'modal-feedback__button',
                        'type' => 'submit',
                ]); ?>
            </form>
        </div>
    </div>
</div>