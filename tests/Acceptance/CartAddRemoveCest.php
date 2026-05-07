<?php


namespace Tests\Acceptance;

use Facebook\WebDriver\WebDriverElement;
use Tests\Support\AcceptanceTester;

class CartAddRemoveCest
{
    public function _before(AcceptanceTester $I)
    {
    }

    // tests
    public function tryToTest(AcceptanceTester $I)
    {
        $I->amOnPage('/catalog/');
        $I->seeElement('.catalog-card__add-button.add-button');
        $I->click('.catalog-card__add-button.add-button');
        $I->waitForElementChange('.header__button-cart-result', function (WebDriverElement $el) {
            return $el->getText() != '0 ₽';
        });

        $I->click('.header__button-cart');
        $I->dontSee('Корзина пуста');
        $I->see('test 2');
        $I->moveBack();
        $I->click('.quantity-input__button-plus');
        $I->waitForElementChange('.quantity-input__amount', function (WebDriverElement $el) {
            return !str_contains($el->getText(), '4 250');
        });

        $I->pressKey('.quantity-input__label.product__purchase-label input', ['backspace']);
        $I->click('.quantity-input__label.product__purchase-label input');
        $I->type('0');
        $I->pressKey('.quantity-input__label.product__purchase-label input', ['enter']);
        $I->waitForElementNotVisible('.quantity-input__amount');
    }
}
