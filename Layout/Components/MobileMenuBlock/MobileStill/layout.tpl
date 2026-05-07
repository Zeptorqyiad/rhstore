<?php
/** @var array $data */

$phone = Simflex\Core\Core::siteParam('phone');
?>

<div class="<?= $data["class_name"] ?> mobile-still mobile-modal">
    <div class="mobile-still__container ">

        <div class="wrapper">

            <div class="mobile-still__box">
                <div class="mobile-still__top ">
                    <p class="mobile-still__title">
                        Меню
                    </p>
                    <div class="mobile-still__close mobile-modal__close">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                  d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z"
                                  fill="#404040"/>
                        </svg>
                    </div>
                </div>

                <ul class="mobile-still__items">
<!--                    <li class="mobile-still__item">-->
<!--                        --><?php //App\Layout\Components\Common\LocationButton\Layout::draw([
//                            'class_name' => 'mobile-still__location'
//                        ]); ?>
<!--                    </li>-->

                    <li class="mobile-still__item">
                        <a href="/promotions/" class="mobile-still__item-link" draggable="false">
                            <span>Акции</span>
                        </a>
                    </li>

                    <li class="mobile-still__item">
                        <a href="/about-us/" class="mobile-still__item-link" draggable="false">
                            <span>О нас</span>
                        </a>
                    </li>

                    <li class="mobile-still__item">
                        <a href="/for-sellers/" class="mobile-still__item-link" draggable="false">
                            <span>Для селлеров</span>
                        </a>
                    </li>

                    <li class="mobile-still__item">
                        <a href="/brands/" class="mobile-still__item-link" draggable="false">
                            <span>Бренды</span>
                        </a>
                    </li>

                    <li class="mobile-still__item">
                        <a href="/blog/" class="mobile-still__item-link" draggable="false">
                            <span>Новости</span>
                        </a>
                    </li>

                    <li class="mobile-still__item mobile-still__item_dropdown">
                        <div class="mobile-still__item-link">
                            <span>Помощь</span>
                            <svg class="mobile-still__item-link-icon" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M15.7071 9.29289C15.3166 8.90237 14.6834 8.90237 14.2929 9.29289L12 11.5858L9.70711 9.29289C9.31658 8.90237 8.68342 8.90237 8.29289 9.29289C7.90237 9.68342 7.90237 10.3166 8.29289 10.7071L11.2929 13.7071C11.6834 14.0976 12.3166 14.0976 12.7071 13.7071L15.7071 10.7071C16.0976 10.3166 16.0976 9.68342 15.7071 9.29289Z"
                                      fill="#404040"/>
                            </svg>
                        </div>
                        <div class="mobile-still__item-list">
                            <a href="/payment/" draggable="false">Оплата</a>
                            <a href="/delivery/" draggable="false">Доставка</a>
                            <a href="/guarantees/" draggable="false">Гарантии</a>
                            <a href="/refund/" draggable="false">Возврат</a>
                            <a href="/questions/" draggable="false">Частые вопросы</a>
                            <a href="/offer/" draggable="false">Оферта</a>
                            <a href="/policy/" draggable="false">Политика</a>
                        </div>
                    </li>

                    <li class="mobile-still__item">
                        <a href="/contacts/" class="mobile-still__item-link" draggable="false">
                            <span>Контакты</span>
                        </a>
                    </li>
                </ul>

                <?php if ($phone): ?>
                    <a href="tel:{phone}" class="mobile-still__phone" draggable="false">{phone}</a>
                <?php endif; ?>
                <?php App\Layout\Components\Common\SocialNetwork\Layout::draw([
                    'class_name' => 'mobile-still__social'
                ]); ?>
            </div>
        </div>
    </div>
</div>

<?php App\Layout\Components\Modals\ModalCityMobile\Layout::draw([

]); ?>
