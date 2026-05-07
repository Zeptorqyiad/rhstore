<?php
/** @var array $data */

$level = \App\Extensions\Catalog2\Model\PriceLevel::getAuto();
// get levels above
$levels = \Simflex\Core\Buffer::getOrSet(
    'alllevels',
    fn() => \App\Extensions\Catalog2\Model\PriceLevel::findAdv()->orderBy(
        'level_ord'
    )->all()
);


?>

<div class="<?= $data["class_name"] ?> catalog-headlines" id="headlines">
    <div class="catalog-headlines__left">
        Наименование
    </div>

    <div class="catalog-headlines__right">
        <div class="catalog-headlines__right-box">

            <?php
            foreach ($levels as $lvl) {
                $hide = false;

                if (\Simflex\Core\Container::getRequest()->getPath() == '/cart/') {
                    $hide = $lvl->level_ord != $level->level_ord;
                }
//                else {
//                    if ($lvl->level_ord == 4 && $level->level_ord < 3) {
//                        $hide = true;
//                    }
//
//                    if ($lvl->level_ord == 0 && $level->level_ord == 3) {
//                        $hide = true;
//                    }
//
//                    if ($lvl->level_ord <= 1 && $level->level_ord == 4) {
//                        $hide = true;
//                    }
//                }

                App\Layout\Components\Common\SaleInfo\Layout::draw([
                    'class_name' => 'catalog-headlines__sale-info ' . ($hide ? ' hide ' : '') . ($lvl->level_ord != $level->level_ord ? ' inactive ' : ''),
                    'secondary' => true,
                    'text' => $lvl->name,
                    'hint_text' => $lvl->desc,
                    'dt' => 'data-level="' . $lvl->level_ord . '"',
                ]);
            } ?>
        </div>

        <div class="catalog-headlines__right-text">
            Кол-во
        </div>
    </div>
</div>
