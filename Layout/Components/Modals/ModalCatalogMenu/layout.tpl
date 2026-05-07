<?php
use App\Layout\Components\Modals\ModalCatalogMenu\Layout;
?>

<div class="modal-catalog-menu">
    <div class="modal-catalog-menu__overlay"></div>
    <div class="modal-catalog-menu__wrapper">

        <ul class="modal-catalog-menu__categories">
            <?php foreach (\App\Extensions\Catalog\Model\Category::find('coalesce(pid, 0) = 0') as $cat): ?>
                <?= Layout::renderCategory($cat) ?>
            <?php endforeach; ?>
        </ul>

        <a href="/catalog/" class="modal-catalog-menu__button-all" draggable="false">Все категории</a>
<!--        --><?php //App\Layout\UIKit\ButtonOrdered\Layout::draw([
//            'href' => '/past/',
//            'text' => 'Заказывали ранее',
//            'class_name' => \Simflex\Core\Container::getUser()?->hasOldProducts() ? 'button-ordered_modal' : 'button-ordered_modal button-ordered_disabled'
//        ]); ?>
    </div>
</div>