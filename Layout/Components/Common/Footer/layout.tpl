<?php
/** @var array $data */

$tg = Simflex\Core\Core::siteParam('tg');
$wt = Simflex\Core\Core::siteParam('wt');
$yt = Simflex\Core\Core::siteParam('yt');
$whats_app = Simflex\Core\Core::siteParam('whats_app');
$email = Simflex\Core\Core::siteParam('email');
$phone = Simflex\Core\Core::siteParam('phone');
$storage_address = Simflex\Core\Core::siteParam('storage_address');

$user = \Simflex\Core\Container::getUser();

?>

<footer class="footer">
    <div class="footer__container wrapper">
        <div class="footer__hidden">
            <ul class="footer__items">
                <li class="footer__item footer__item-big">
                    <a href="/" class="footer__item-link">Главная</a>
                </li>
                <li class="footer__item footer__item-big">
                    <a href="/promotions/" class="footer__item-link">Акции</a>
                </li>
                <li class="footer__item footer__item-big">
                    <a href="/about-us/" class="footer__item-link">О нас</a>
                </li>
                <li class="footer__item footer__item-big">
                    <a href="/for-sellers/" class="footer__item-link">Для селлеров</a>
                </li>
                <li class="footer__item footer__item-big">
                    <a href="/brands/" class="footer__item-link">Бренды</a>
                </li>
                <li class="footer__item footer__item-big">
                    <a href="/blog/" class="footer__item-link">Новости</a>
                </li>
            </ul>
        </div>
        <div class="footer__hidden">
            <ul class="footer__items">
<!--                <li class="footer__item footer__item-big">-->
<!--                    <a href="/catalog/" class="footer__item-link">Каталог</a>-->
<!--                </li>-->
<!--                --><?php //foreach (\App\Extensions\Catalog\Model\Category::find('coalesce(pid, 0) = 0') as $cat): ?>
<!--                    <li class="footer__item footer__item-small">-->
<!--                        <a href="/--><?php //= $cat->path ?><!--/" class="footer__item-link">--><?php //= $cat->name ?><!--</a>-->
<!--                    </li>-->
<!--                --><?php //endforeach; ?>
            </ul>
        </div>
        <div class="footer__hidden">
            <ul class="footer__items">
<!--                --><?php //if ($user): ?>
<!--                    <li class="footer__item footer__item-big">-->
<!--                        <a href="/user/" class="footer__item-link">Личный кабинет</a>-->
<!--                    </li>-->
<!--                --><?php //endif; ?>
<!--                --><?php //if (!$user): ?>
<!--                    <li class="footer__item footer__item-big">-->
<!--                        <p class="footer__item-link footer__item-link_profile">Личный кабинет</p>-->
<!--                    </li>-->
<!--                --><?php //endif; ?>
                <li class="footer__item footer__item-big">
                    <a href="/contacts/" class="footer__item-link">Контакты</a>
                </li>
                <li class="footer__item footer__item-big">
                    <span>Помощь</span>
                </li>
                <li class="footer__item footer__item-small">
                    <a href="/payment/" class="footer__item-link">Оплата</a>
                </li>
                <li class="footer__item footer__item-small">
                    <a href="/delivery/" class="footer__item-link">Доставка</a>
                </li>
                <li class="footer__item footer__item-small">
                    <a href="/guarantees/" class="footer__item-link">Гарантии</a>
                </li>
                <li class="footer__item footer__item-small">
                    <a href="/refund/" class="footer__item-link">Возврат</a>
                </li>
                <li class="footer__item footer__item-small">
                    <a href="/questions/" class="footer__item-link">Частые вопросы</a>
                </li>
            </ul>
        </div>
        <div class="">
            <div class="footer__block">
                <div class="footer__contacts">
                    <a href="tel:{phone}" class="footer__contact">{phone}</a>
                    <a href="mailto:{email}" class="footer__contact">{email}</a>
                </div>
                <?php \App\Layout\Components\Common\SocialNetwork\Layout::draw([
                    'class_name' => 'footer__social'
                ]); ?>

                <div class="footer__info">
                    <a href="/offer/" class="footer__info-link">Публичная оферта</a>
                    <a href="/policy/" class="footer__info-link">Политика обработки данных</a>
                    <p class="footer__info-copy">&copy; {year} Rhstore, Все права защищены</p>
                    <p class="footer__info-text">
                        {company}<br>
                        {inn} <br>
                        {ogrnip}
                    </p>
                </div>
            </div>
        </div>
    </div>
</footer>

<?php App\Layout\UIKit\ButtonScroll\Layout::draw(); ?>

<?php App\Layout\Components\Modals\ModalPriceInfo\Layout::draw(); ?>
<?php App\Layout\Components\Modals\ModalPriceInfoMobile\Layout::draw(); ?>

<?php if (isset($data['prod'])) App\Layout\Components\Modals\ModalPropertyAbout\Layout::draw(['prod' => $data['prod']]); ?>

<?php App\Layout\Components\Modals\ModalCatalogMenu\Layout::draw(); ?>

<?php App\Layout\Components\Modals\ModalRegistrationSuccess\Layout::draw(); ?>
<?php App\Layout\Components\Modals\ModalLoginSuccess\Layout::draw(); ?>
<?php App\Layout\Components\Modals\ModalFormSubmitted\Layout::draw(); ?>

<?php App\Layout\Components\Modals\ModalOrderRefund\Layout::draw(); ?>
<?php App\Layout\Components\Modals\ModalOrderCancel\Layout::draw(); ?>
