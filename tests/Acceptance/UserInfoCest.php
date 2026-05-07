<?php


namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;

class UserInfoCest
{
    public function _before(AcceptanceTester $I)
    {
    }

    // tests
    public function tryToTest(AcceptanceTester $I)
    {
        $I->amOnPage('/');
        $I->click('.header__button-profile');
        $I->see('Вход в личный кабинет');
        $I->wait(1);
        $I->click('.variant-text-field__input[name="email"]');
        $I->type('test@example.com');
        $I->click('.variant-text-field__input[name="password"]');
        $I->type('123123');
        $I->click('.authorization-form__button');
        $I->moveMouseOver('.header__button-profile');
        $I->see('test');
        $I->see('Мой аккаунт');
        $I->click('.header-profile__link');
        $I->see('Подтвердите свой e-mail');
        $I->click('.nav-aside__item-link[href="/user/orders/?active=1"]');
        $I->see('Заказ 30');
    }
}
