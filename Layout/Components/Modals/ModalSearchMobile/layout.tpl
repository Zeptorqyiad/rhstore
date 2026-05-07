<?php
/** @var array $data */
extract($data)
?>

<form action="/search/" class="modal-search-mobile">
    <div class="modal-search-mobile__top">
        <button class="modal-search-mobile__button-close">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#404040" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m15 6-6 6 6 6"/>
            </svg>
        </button>
        <div class="modal-search-mobile__searchbar">
            <label for="" class="modal-search-mobile__search">
                <input value="<?= $_REQUEST['q'] ?>" name="q" class="modal-search-mobile__search-input" type="text"
                       placeholder="Поиск по сайту">
            </label>
            <button type="submit" class="modal-search-mobile__button-search">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#fff" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="m21 21-6-6m2-5a7 7 0 1 1-14 0 7 7 0 0 1 14 0Z"/>
                </svg>
            </button>
        </div>
    </div>
    <div class="modal-search-mobile__container">
        <p class="modal-search-mobile__text">
            Введите название или артикул
        </p>
        <div class="modal-search-mobile__results">
            <ul class="modal-search-mobile__items">

            </ul>
            <div class="modal-search-mobile__categories-wrapper">
                <h4 class="modal-search-mobile__categories-title">Категории:</h4>
                <ul class="modal-search-mobile__categories">

                </ul>
            </div>
        </div>
    </div>
    <div class="modal-search-mobile__bottom">
        <button class="modal-search-mobile__submit">

        </button>
    </div>
</form>
