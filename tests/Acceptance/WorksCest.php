<?php


namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;

class WorksCest
{
    public function _before(AcceptanceTester $I)
    {
    }

    // tests
    public function tryToTest(AcceptanceTester $I)
    {
        $I->amOnPage('/');
        $I->dontSee('Error');
        $I->see('Аксессуары для смартфонов оптом');
    }
}
