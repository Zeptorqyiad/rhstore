<?php
/** @var array $data */
?>

<div class="<?= $data["class_name"] ?> help-navigation">
    <ul class="help-navigation__container wrapper">
        <li class="help-navigation__list <?= $data["active_nav"] === '1' ? 'help-navigation__list_active' : '' ?>">
            <a href="/payment/" class="help-navigation__link">
                Оплата
            </a>
        </li>
        <li class="help-navigation__list <?= $data["active_nav"] === '2' ? 'help-navigation__list_active' : '' ?>">
            <a href="/delivery/" class="help-navigation__link">
                Доставка
            </a>
        </li>
        <li class="help-navigation__list <?= $data["active_nav"] === '3' ? 'help-navigation__list_active' : '' ?>">
            <a href="/guarantees/" class="help-navigation__link">
                Гарантии
            </a>
        </li>
        <li class="help-navigation__list <?= $data["active_nav"] === '4' ? 'help-navigation__list_active' : '' ?>">
            <a href="/refund/" class="help-navigation__link">
                Возврат
            </a>
        </li>
        <li class="help-navigation__list <?= $data["active_nav"] === '5' ? 'help-navigation__list_active' : '' ?>">
            <a href="/questions/" class="help-navigation__link">
                Частые вопросы
            </a>
        </li>
        <li class="help-navigation__list <?= $data["active_nav"] === '6' ? 'help-navigation__list_active' : '' ?>">
            <a href="/offer/" class="help-navigation__link">
                Оферта
            </a>
        </li>
        <li class="help-navigation__list <?= $data["active_nav"] === '7' ? 'help-navigation__list_active' : '' ?>">
            <a href="/policy/" class="help-navigation__link">
                Политика
            </a>
        </li>
    </ul>
</div>