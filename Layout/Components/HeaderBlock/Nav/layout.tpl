<?php
/** @var array $data */

$phone = Simflex\Core\Core::siteParam('phone');
?>

<header class="nav" id="navigation">
    <div class="nav__container wrapper">
        <div class="nav__left">
            <?php //App\Layout\Components\Common\Logo\Layout::draw(); ?>
            <?php App\Layout\UIKit\ButtonCatalog\Layout::draw();?>
            <nav>
                <ul class="nav__list">
                    <li class="nav__item">
                        <a href="/promotions/" class="nav__item-link">
                            Акции
                        </a>
                    </li>
                    <li class="nav__item">
                        <a href="/about-us/" class="nav__item-link">
                            О нас
                        </a>
                    </li>
                    <li class="nav__item">
                        <a href="/for-sellers/" class="nav__item-link">
                            Для селлеров
                        </a>
                    </li>
                    <li class="nav__item">
                        <a href="/brands/" class="nav__item-link">
                            Бренды
                        </a>
                    </li>
                    <li class="nav__item">
                        <a href="/blog/" class="nav__item-link">
                            Новости
                        </a>
                    </li>
                    <li class="nav__item">
                        <div class="nav__item-link nav__item-link-help">
                            <span>Помощь</span>
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="none">
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M8.29289 10.2929C8.68342 9.90237 9.31658 9.90237 9.70711 10.2929L12 12.5858L14.2929 10.2929C14.6834 9.90237 15.3166 9.90237 15.7071 10.2929C16.0976 10.6834 16.0976 11.3166 15.7071 11.7071L12.7071 14.7071C12.3166 15.0976 11.6834 15.0976 11.2929 14.7071L8.29289 11.7071C7.90237 11.3166 7.90237 10.6834 8.29289 10.2929Z"/>
                            </svg>

                            <div class="nav__dropdown">
                                <ul class="nav__dropdown-list">
                                    <li class="nav__dropdown-item">
                                        <a href="/payment/" class="nav__dropdown-link" draggable="false">
                                            Оплата
                                        </a>
                                    </li>
                                    <li class="nav__dropdown-item">
                                        <a href="/delivery/" class="nav__dropdown-link" draggable="false">
                                            Доставка
                                        </a>
                                    </li>
                                    <li class="nav__dropdown-item">
                                        <a href="/guarantees/" class="nav__dropdown-link" draggable="false">
                                            Гарантии
                                        </a>
                                    </li>
                                    <li class="nav__dropdown-item">
                                        <a href="/refund/" class="nav__dropdown-link" draggable="false">
                                            Возврат
                                        </a>
                                    </li>
                                    <li class="nav__dropdown-item">
                                        <a href="/questions/" class="nav__dropdown-link" draggable="false">
                                            Частые вопросы
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </li>
                    <li class="nav__item">
                        <a href="/contacts/" class="nav__item-link">
                            Контакты
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
        <div class="nav__right">
            <a href="tel:{phone}" class="nav__phone">{phone}</a>
            <?php
            App\Layout\Components\Common\SocialNetwork\Layout::draw(); ?>
        </div>
    </div>

</header>


