<?php
/** @var array $data */
extract($data);
?>

<div class="not-found wrapper">
    <h1 class="not-found__title">Ошибка 404</h1>
    <p class="not-found__description">Похоже, вы неправильно ввели адрес или такой страницы не существует</p>
    <div class="not-found__buttons">
        <a href="/" draggable="false">
            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'На главную',
                'style' => 'primary',
                'class_name' => 'not-found__button',
                'type' => 'button',
            ]); ?>
        </a>
<!--        <a href="/user/" draggable="false">-->
<!--            --><?php //App\Layout\Components\Common\Button\Layout::draw([
//                'text' => 'В личный кабинет',
//                'style' => 'transparent',
//                'class_name' => 'not-found__button',
//                'type' => 'button',
//            ]); ?>
<!--        </a>-->
    </div>
</div>