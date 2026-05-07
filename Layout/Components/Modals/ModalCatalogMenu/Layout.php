<?php

namespace App\Layout\Components\Modals\ModalCatalogMenu;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function renderCategory($category, int $level = 1): string
    {
        $children = $category->getChildren();
        ob_start();
        ?>
        <li class="modal-catalog-menu__category">
            <a href="/<?= $category->path ?>/" class="modal-catalog-menu__category-link" draggable="false">
                <div class="modal-catalog-menu__category-wrapper">
                    <?php
                    if ($category->icon): ?>
                        <img src="/uf/files/<?= $category->icon ?>" alt=""/>
                    <?php
                    endif; ?>
                    <span class="modal-catalog-menu__category-name"><?= $category->name ?></span>
                </div>
                <?php
                if ($children): ?>
                    <svg xmlns="http://www.w3.org/2000/svg"
                         class="modal-catalog-menu__category-icon"
                         fill="none"
                         stroke="#404040"
                         viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="m11 15 3-3-3-3"/>
                    </svg>
                <?php
                endif; ?>
            </a>
            <?php
            if ($children): ?>
                <ul class="modal-catalog-menu__subcategories">
                    <?php
                    foreach ($children as $child): ?>
                        <?= self::renderCategory($child, $level + 1) ?>
                    <?php
                    endforeach; ?>
                </ul>
            <?php
            endif; ?>
        </li>
        <?php
        return ob_get_clean();
    }
}