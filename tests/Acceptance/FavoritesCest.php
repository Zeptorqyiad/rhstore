<?php


namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;

class FavoritesCest
{
    public function _before(AcceptanceTester $I)
    {
    }

    // tests
    public function tryToTest(AcceptanceTester $I): void
    {
        $I->amOnPage('/');
        $I->seeElement('.header__button-like');
        $I->click('.header__button-like');
        $I->see('Избранное');
        $I->see('По вашему запросу ничего не найдено, попробуйте изменить запрос');

        $I->comment('Testing add/remove');
        $I->amOnPage('/catalog/');
        $I->see('test 2');
        $I->click('.catalog-card__favorites-button.favorites');
        $I->waitForElement('.header__button-like.active', 3);
        $I->click('.header__button-like');
        $I->see('test 2');
    }
}
