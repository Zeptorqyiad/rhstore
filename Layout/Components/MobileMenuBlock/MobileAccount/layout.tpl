<?php
/** @var array $data */
$user = \Simflex\Core\Container::getUser();
?>

<div class="<?= $data["class_name"] ?> mobile-account mobile-modal">
    <div class="mobile-account__container wrapper">
        <?php if ($user): ?>
            <div>
                <div class="mobile-account__top ">
                    <p class="mobile-account__title">
                        Личный кабинет
                    </p>
                    <div class="mobile-account__close mobile-modal__close">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                  d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z"
                                  fill="#404040"/>
                        </svg>
                    </div>
                </div>

                <h3 class="mobile-account__name"><?= $user->name ?? 'Войдите в аккаунт' ?> <?= $user->last_name ?></h3>


                <ul class="mobile-account__items">
                    <li class="mobile-account__item">
                        <a href="/user/" class="mobile-account__item-link">
                            <span>Мой аккаунт</span>
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M9.79289 16.2071C9.40237 15.8166 9.40237 15.1834 9.79289 14.7929L12.0858 12.5L9.79289 10.2071C9.40237 9.81658 9.40237 9.18342 9.79289 8.79289C10.1834 8.40237 10.8166 8.40237 11.2071 8.79289L14.2071 11.7929C14.5976 12.1834 14.5976 12.8166 14.2071 13.2071L11.2071 16.2071C10.8166 16.5976 10.1834 16.5976 9.79289 16.2071Z"
                                      fill="#0D0D0D"/>
                            </svg>
                        </a>
                    </li>

                    <li class="mobile-account__item">
                        <a href="/active-orders/" class="mobile-account__item-link">
                            <span>Активные заказы</span>
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M9.79289 16.2071C9.40237 15.8166 9.40237 15.1834 9.79289 14.7929L12.0858 12.5L9.79289 10.2071C9.40237 9.81658 9.40237 9.18342 9.79289 8.79289C10.1834 8.40237 10.8166 8.40237 11.2071 8.79289L14.2071 11.7929C14.5976 12.1834 14.5976 12.8166 14.2071 13.2071L11.2071 16.2071C10.8166 16.5976 10.1834 16.5976 9.79289 16.2071Z"
                                      fill="#0D0D0D"/>
                            </svg>
                        </a>
                    </li>

                    <li class="mobile-account__item">
                        <a href="/user/orders/" class="mobile-account__item-link">
                            <span>Архивные заказы</span>
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M9.79289 16.2071C9.40237 15.8166 9.40237 15.1834 9.79289 14.7929L12.0858 12.5L9.79289 10.2071C9.40237 9.81658 9.40237 9.18342 9.79289 8.79289C10.1834 8.40237 10.8166 8.40237 11.2071 8.79289L14.2071 11.7929C14.5976 12.1834 14.5976 12.8166 14.2071 13.2071L11.2071 16.2071C10.8166 16.5976 10.1834 16.5976 9.79289 16.2071Z"
                                      fill="#0D0D0D"/>
                            </svg>
                        </a>
                    </li>

                    <li class="mobile-account__item">
                        <a href="/ask-questions/" class="mobile-account__item-link">
                            <span>Задать вопрос</span>
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M9.79289 16.2071C9.40237 15.8166 9.40237 15.1834 9.79289 14.7929L12.0858 12.5L9.79289 10.2071C9.40237 9.81658 9.40237 9.18342 9.79289 8.79289C10.1834 8.40237 10.8166 8.40237 11.2071 8.79289L14.2071 11.7929C14.5976 12.1834 14.5976 12.8166 14.2071 13.2071L11.2071 16.2071C10.8166 16.5976 10.1834 16.5976 9.79289 16.2071Z"
                                      fill="#0D0D0D"/>
                            </svg>
                        </a>
                    </li>
                </ul>

            </div>

            <div class="mobile-account__bottom">
                <button class="mobile-account__button" onclick="logoutModal(event)">
                    Выйти из профиля
                </button>
            </div>
        <?php endif; ?>

        <?php if (!$user): ?>
            <div class="mobile-account__auth">
                <div class="mobile-account__nav">
                    <svg class="mobile-account__icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path fill="#404040" fill-rule="evenodd" d="M3.293 3.293a1 1 0 0 1 1.414 0L12 10.586l7.293-7.293a1 1 0 1 1 1.414 1.414L13.414 12l7.293 7.293a1 1 0 0 1-1.414 1.414L12 13.414l-7.293 7.293a1 1 0 0 1-1.414-1.414L10.586 12 3.293 4.707a1 1 0 0 1 0-1.414Z" clip-rule="evenodd"/>
                    </svg>
                </div>
                <?php App\Layout\Components\AccountBlocks\SignIn\AuthorizationForm\Layout::draw([
                    'class_name' => 'mobile-account__form',
                    'form_id' => '2',
                ]); ?>
                <?php App\Layout\Components\AccountBlocks\SignUp\RegistrationForm\Layout::draw([
                    'class_name' => 'mobile-account__form',
                    'form_id' => '2',
                ]); ?>
            </div>
        <?php endif; ?>
    </div>
</div>
