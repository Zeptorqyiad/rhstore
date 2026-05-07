<?php


namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;

class HomePageCest
{
    public function _before(AcceptanceTester $I)
    {
    }

    // tests
    public function tryToTest(AcceptanceTester $I)
    {
        $I->amOnPage('/');

        // test brands
        $I->see('Samsung');
        $I->see('Apple');

        // test categories
        $I->seeElement('.main-category__cards');
        $I->see('test cat');
        $I->see('test cat 2');
        $I->see('test child 1');
        $I->see('test child 2');
    }
}
