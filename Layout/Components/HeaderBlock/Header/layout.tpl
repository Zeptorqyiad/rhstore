<?php
/** @var array $data */

$category = $data['cat'];
$user = Simflex\Core\Container::getUser();
?>

<?php App\Layout\Components\Modals\ModalSearchMobile\Layout::draw([]); ?>
<header class="header">
    <div class="header__container wrapper">
        <div class="header__logo-swap">
            <?php App\Layout\Components\Common\Logo\Layout::draw(); ?>
            <?php App\Layout\UIKit\ButtonCatalog\Layout::draw(); ?>
        </div>

        <form action="/search/" class="header__center">
            <div class="header__dash"></div>
            <div class="header__location-box">
                <?php App\Layout\Components\Common\LocationButton\Layout::draw([
                    'class_name' => 'header__location'
                ]); ?>
                <?php App\Layout\Components\Modals\ModalCity\Layout::draw(); ?>
            </div>
            <div class="header__search-wrapper">
                <label for="" class="header__search">
                    <input value="<?= $_REQUEST['q'] ?>" id="search-input" name="q" class="header__search-input"
                           type="text"
                           placeholder="Поиск по сайту">
                </label>
                <button type="submit" class="header__button-search">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M19 19L13.0001 13M15 8C15 11.866 11.866 15 8 15C4.13401 15 1 11.866 1 8C1 4.13401 4.13401 1 8 1C11.866 1 15 4.13401 15 8Z"
                              stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
                <?php App\Layout\Components\Modals\ModalSearchMain\Layout::draw(); ?>
            </div>

            <div class="header__dash"></div>
        </form>

        <div class="header__right">
<!--            <div class="header__profile">-->

<!--                --><?php //if ($user): ?>
<!--                    <a href="/user/" type="button" class="header__button-profile" title="--><?php //= $user['name'] ?><!--">-->
<!--                        <span class="header__button-profile-name">--><?php //= $user['name'] ?><!--</span>-->
<!--                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">-->
<!--                            <path fill-rule="evenodd" clip-rule="evenodd"-->
<!--                                  d="M12.0001 4C10.0671 4 8.50008 5.567 8.50008 7.5C8.50008 9.433 10.0671 11 12.0001 11C13.9331 11 15.5001 9.433 15.5001 7.5C15.5001 5.567 13.9331 4 12.0001 4ZM6.50008 7.5C6.50008 4.46243 8.96252 2 12.0001 2C15.0376 2 17.5001 4.46243 17.5001 7.5C17.5001 10.5376 15.0376 13 12.0001 13C8.96252 13 6.50008 10.5376 6.50008 7.5ZM9.32635 14.5C9.38341 14.5 9.44132 14.5 9.50009 14.5H14.5001C14.5589 14.5 14.6168 14.5 14.6738 14.5C15.9011 14.4995 16.7391 14.4992 17.4515 14.7153C19.0495 15.2 20.3 16.4506 20.7848 18.0486C21.0009 18.761 21.0006 19.599 21.0001 20.8263C21.0001 20.8833 21.0001 20.9412 21.0001 21C21.0001 21.5523 20.5524 22 20.0001 22C19.4478 22 19.0001 21.5523 19.0001 21C19.0001 19.5317 18.9892 19.0192 18.8709 18.6291C18.5801 17.6703 17.8297 16.92 16.8709 16.6292C16.4809 16.5108 15.9684 16.5 14.5001 16.5H9.50009C8.03177 16.5 7.51929 16.5108 7.12923 16.6292C6.17042 16.92 5.42011 17.6703 5.12926 18.6291C5.01094 19.0192 5.00008 19.5317 5.00008 21C5.00008 21.5523 4.55237 22 4.00008 22C3.4478 22 3.00008 21.5523 3.00008 21C3.00008 20.9412 3.00006 20.8833 3.00004 20.8263C2.99959 19.599 2.99928 18.761 3.21538 18.0486C3.70013 16.4506 4.95065 15.2 6.54866 14.7153C7.26106 14.4992 8.09908 14.4995 9.32635 14.5Z"/>-->
<!--                        </svg>-->
<!--                    </a>-->
<!--                    --><?php //App\Layout\Components\Common\HeaderProfile\Layout::draw([
//                        'class_name' => 'header__profile-dropdown'
//                    ]); ?>
<!--                --><?php //endif; ?>
<!--                --><?php //if (!$user): ?>
<!--                    <button type="button" class="header__button-profile" title="Войдите в аккаунт">-->
<!--                        <span class="header__button-profile-name">--><?php //= $user['name'] ?><!--</span>-->
<!--                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">-->
<!--                            <path fill-rule="evenodd" clip-rule="evenodd"-->
<!--                                  d="M12.0001 4C10.0671 4 8.50008 5.567 8.50008 7.5C8.50008 9.433 10.0671 11 12.0001 11C13.9331 11 15.5001 9.433 15.5001 7.5C15.5001 5.567 13.9331 4 12.0001 4ZM6.50008 7.5C6.50008 4.46243 8.96252 2 12.0001 2C15.0376 2 17.5001 4.46243 17.5001 7.5C17.5001 10.5376 15.0376 13 12.0001 13C8.96252 13 6.50008 10.5376 6.50008 7.5ZM9.32635 14.5C9.38341 14.5 9.44132 14.5 9.50009 14.5H14.5001C14.5589 14.5 14.6168 14.5 14.6738 14.5C15.9011 14.4995 16.7391 14.4992 17.4515 14.7153C19.0495 15.2 20.3 16.4506 20.7848 18.0486C21.0009 18.761 21.0006 19.599 21.0001 20.8263C21.0001 20.8833 21.0001 20.9412 21.0001 21C21.0001 21.5523 20.5524 22 20.0001 22C19.4478 22 19.0001 21.5523 19.0001 21C19.0001 19.5317 18.9892 19.0192 18.8709 18.6291C18.5801 17.6703 17.8297 16.92 16.8709 16.6292C16.4809 16.5108 15.9684 16.5 14.5001 16.5H9.50009C8.03177 16.5 7.51929 16.5108 7.12923 16.6292C6.17042 16.92 5.42011 17.6703 5.12926 18.6291C5.01094 19.0192 5.00008 19.5317 5.00008 21C5.00008 21.5523 4.55237 22 4.00008 22C3.4478 22 3.00008 21.5523 3.00008 21C3.00008 20.9412 3.00006 20.8833 3.00004 20.8263C2.99959 19.599 2.99928 18.761 3.21538 18.0486C3.70013 16.4506 4.95065 15.2 6.54866 14.7153C7.26106 14.4992 8.09908 14.4995 9.32635 14.5Z"/>-->
<!--                        </svg>-->
<!--                    </button>-->
<!--                --><?php //endif; ?>
            </div>

<!--            --><?php
//            $cnt = \App\Extensions\Catalog\SessionAssist::$fav->getProductCount(); ?>
<!--            <a type="button" href="/favorite/" class="header__button-like --><?php //= $cnt ? 'active' : '' ?><!--"-->
<!--               data-count="--><?php //= $cnt ?><!--" title="Избранное">-->
<!--                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">-->
<!--                    <path fill-rule="evenodd" clip-rule="evenodd"-->
<!--                          d="M11.9929 3.71691C9.65298 1.67202 6.19252 1.25356 3.50521 3.54965C0.598423 6.03328 0.176093 10.2161 2.47471 13.1739C3.34724 14.2967 5.05023 15.9835 6.68684 17.5282C8.34261 19.0911 9.99457 20.5679 10.8092 21.2894L10.8247 21.3031C10.9013 21.371 10.9967 21.4555 11.0881 21.5244C11.1975 21.6068 11.3547 21.7091 11.5645 21.7717C11.8434 21.8549 12.1432 21.8549 12.4221 21.7717C12.6319 21.7091 12.789 21.6068 12.8984 21.5244C12.9898 21.4555 13.0852 21.371 13.1618 21.3031L13.1773 21.2894C13.992 20.5679 15.6439 19.0911 17.2997 17.5282C18.9363 15.9835 20.6393 14.2967 21.5118 13.1739C23.8016 10.2275 23.4445 6.01238 20.4709 3.54088C17.7537 1.28246 14.3301 1.67124 11.9929 3.71691ZM11.2333 5.78575C9.52828 3.79238 6.818 3.34975 4.80441 5.07021C2.7011 6.86733 2.41807 9.84171 4.05392 11.9467C4.81701 12.9286 6.40681 14.5137 8.05966 16.0738C9.6027 17.5303 11.1462 18.9145 11.9933 19.6663C12.8403 18.9145 14.3838 17.5303 15.9269 16.0738C17.5797 14.5137 19.1695 12.9286 19.9326 11.9467C21.5773 9.83034 21.3152 6.84319 19.1925 5.07898C17.1256 3.36105 14.4507 3.80119 12.7532 5.78575C12.5632 6.00786 12.2856 6.13573 11.9933 6.13573C11.701 6.13573 11.4233 6.00786 11.2333 5.78575Z"/>-->
<!--                </svg>-->
<!--            </a>-->

            <?php
            $cart = \App\Extensions\Catalog\SessionAssist::$cart;
            $cnt = $cart->getTotalOrderCount(); ?>
            <a href="/cart/" class="header__button-cart <?= $cnt ? 'active' : '' ?>" data-count="<?= $cnt ?>"
               draggable="false" title="Корзина">
                <span class="header__button-cart-result"
                    <?= $cnt == 0 ? 'style="display:none"' : '' ?>><?= $cart->sum_actual ?> ₽</span>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                    <path fill-rule="evenodd" clip-rule="evenodd"
                          d="M3.67163 1.00858C3.80497 1.01879 3.9908 1.04477 4.18984 1.13573C4.45155 1.25533 4.67333 1.44769 4.82874 1.68985C4.94695 1.87403 4.99894 2.05432 5.0279 2.18487C5.0525 2.29575 5.07045 2.42175 5.08515 2.52494C5.08614 2.53189 5.08711 2.53873 5.08807 2.54545L5.43872 5.00001L21.0597 5C21.2018 4.99995 21.3657 4.9999 21.5079 5.01229C21.6678 5.02624 21.9081 5.06244 22.1511 5.20406C22.4582 5.38306 22.6918 5.66532 22.8102 6.00052C22.9038 6.26571 22.8944 6.50852 22.8782 6.66825C22.8638 6.81024 22.833 6.97125 22.8064 7.11082L21.4714 14.1194C21.3887 14.5537 21.3166 14.9323 21.2329 15.2435C21.1438 15.5749 21.0249 15.8978 20.8159 16.2013C20.5003 16.6598 20.0633 17.0213 19.5539 17.2456C19.2167 17.3941 18.8772 17.4505 18.535 17.476C18.2136 17.5 17.8282 17.5 17.3861 17.5H8.75873C8.29386 17.5 7.88978 17.5 7.55391 17.4742C7.19707 17.4468 6.84288 17.3864 6.49387 17.2261C5.96847 16.9847 5.52401 16.5966 5.21399 16.1085C5.00806 15.7843 4.90043 15.4415 4.82517 15.0916C4.75433 14.7623 4.69987 14.3619 4.63722 13.9013L3.58101 6.13812L3.1327 3.00001H2C1.44772 3.00001 1 2.5523 1 2.00001C1 1.44773 1.44772 1.00001 2 1.00001H3.30616C3.31296 1.00001 3.31987 1.00001 3.32688 1.00001C3.43112 0.999965 3.55839 0.999915 3.67163 1.00858ZM5.7167 7.00001L6.61419 13.5966C6.683 14.1023 6.7277 14.4258 6.78045 14.671C6.83057 14.904 6.87359 14.9911 6.90221 15.0362C7.00555 15.1989 7.1537 15.3282 7.32884 15.4087C7.37734 15.431 7.46944 15.4619 7.70706 15.4801C7.95716 15.4993 8.28371 15.5 8.79411 15.5H17.352C17.8381 15.5 18.1481 15.4994 18.386 15.4816C18.6114 15.4648 18.7001 15.4363 18.748 15.4152C18.9178 15.3405 19.0634 15.2199 19.1686 15.0671C19.1983 15.0241 19.2429 14.9422 19.3016 14.724C19.3635 14.4936 19.4222 14.1892 19.5131 13.7117L20.7915 7.00001H5.7167ZM7 21C7 19.8954 7.89543 19 9 19C10.1046 19 11 19.8954 11 21C11 22.1046 10.1046 23 9 23C7.89543 23 7 22.1046 7 21ZM15 21C15 19.8954 15.8954 19 17 19C18.1046 19 19 19.8954 19 21C19 22.1046 18.1046 23 17 23C15.8954 23 15 22.1046 15 21Z"/>
                </svg>
            </a>
            <?php App\Layout\Components\Modals\ModalCart\Layout::draw() ?>

            <button type="button" class="header__button-mob-search">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                    <path d="M21 21L15.0001 15M17 10C17 13.866 13.866 17 10 17C6.13401 17 3 13.866 3 10C3 6.13401 6.13401 3 10 3C13.866 3 17 6.13401 17 10Z"
                          stroke="#404040" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
        </div>
</header>

<?php App\Layout\Components\HeaderBlock\Nav\Layout::draw(); ?>

<?php App\Layout\Components\Modals\ModalCookie\Layout::draw() ?>
<?php App\Layout\Components\Modals\ModalPromo\Layout::draw() ?>

<?php if ($user): ?>
    <?php App\Layout\Components\Modals\ModalLogout\Layout::draw(); ?>
<?php endif; ?>

<?php if (!$user): ?>
    <?php App\Layout\Components\Modals\ModalAuth\Layout::draw(); ?>

    <?php App\Layout\Components\Modals\ModalRestorePassword\Layout::draw(); ?>
    <?php App\Layout\Components\Modals\ModalNotification\Layout::draw(); ?>
    <?php App\Layout\Components\Modals\ModalInvalidUser\Layout::draw() ?>
    <?php App\Layout\Components\Modals\ModalInvalidEmail\Layout::draw() ?>
<?php endif; ?>
