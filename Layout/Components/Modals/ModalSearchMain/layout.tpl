<?php
/** @var array $data */
extract($data)
?>

<div class="modal-search-main">
    <div class="modal-search-main__overlay"></div>
    <div class="modal-search-main__container">
        <p class="modal-search-main__text">
            По вашему запросу ничего не найдено
        </p>
        <div class="modal-search-main__results">
            <ul class="modal-search-main__items" id="search-items-list">

            </ul>
            <div class="modal-search-main__categories-wrapper">
                <h4 class="modal-search-main__categories-title">Категории:</h4>
                <ul class="modal-search-main__categories">

                </ul>
            </div>
            <button type="submit" class="modal-search-main__submit"></button>
        </div>
    </div>
</div>
