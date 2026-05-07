<?php
/** @var array $data */

/** @var \App\Extensions\Catalog\Model\Category $cat */
$cat = $data['cat'];

$isSearch = $data['is_search'];
?>

<ul class="<?= $data["class_name"] ?> catalog-categories">
    <li class="catalog-categories__item catalog-categories__item_active">
        <a href="/<?= $isSearch ? ('search/?category_id=' . $cat->category_id . '&q=' . $_REQUEST['q']) : ($cat->path . '/') ?>"
           class="catalog-categories__link" draggable="false">
            <p class="catalog-categories__first-text"><?= $cat->category_id == 0 ? 'Каталог' : ($isSearch ? $cat->oldName : $cat->name) ?></p>
        </a>
    </li>
    <?php
    foreach ($cat->getChildren() as $sibling):
        if (!(\App\Extensions\Catalog\CategoryAssist::$categoryCounts[$sibling->category_id] ?? 0)) {
            continue;
        }
        ?>
        <li class="catalog-categories__item">
            <a href="/<?= $isSearch ? ('search/?category_id=' . $sibling->category_id . '&q=' . $_REQUEST['q']) : ($sibling->path . '/') ?>"
               class="catalog-categories__link" draggable="false">
                <p class="catalog-categories__first-text"><?= $sibling->name ?></p>
                <?php
                if ($sibling->subtitle): ?>
                    <p class="catalog-categories__second-text"><?= $sibling->subtitle ?></p>
                <?php
                endif; ?>
            </a>
        </li>
    <?php
    endforeach; ?>

    <?php
    if ($data['hasPar']): ?>
        <?php
        foreach ($cat->getSiblings() as $sibling):
            if (!(\App\Extensions\Catalog\CategoryAssist::$categoryCounts[$sibling->category_id] ?? 0)) {
                continue;
            } ?>
            <li class="catalog-categories__item">
                <a href="/<?= $isSearch ? ('search/?category_id=' . $sibling->category_id . '&q=' . $_REQUEST['q']) : ($sibling->path . '/') ?>"
                   class="catalog-categories__link">
                    <p class="catalog-categories__first-text"><?= $sibling->name ?></p>
                    <?php
                    if ($sibling->subtitle): ?>
                        <p class="catalog-categories__second-text"><?= $sibling->subtitle ?></p>
                    <?php
                    endif; ?>
                </a>

            </li>
        <?php
        endforeach; ?>
    <?php
    endif; ?>
<!--    --><?php //App\Layout\UIKit\ButtonOrdered\Layout::draw([
//        'text' => 'Заказывали ранее',
//        'href' => '/past/',
//        'class_name' => \Simflex\Core\Container::getUser()?->hasOldProducts() ? 'button-ordered_filter' : 'button-ordered_disabled button-ordered_filter',
//    ]); ?>
</ul>