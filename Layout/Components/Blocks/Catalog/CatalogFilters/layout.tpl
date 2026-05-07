<?php
/** @var array $data */

/** @var \App\Extensions\Catalog\Model\Category $cat */
$cat = $data['cat'];
$count = $cat->getProductCount($data['f']);

/** @var \App\Extensions\Catalog\Model\Category $par */
$par = $cat->getParent() ?? \Simflex\Core\Container::getFactory()->create(
    \App\Extensions\Catalog\Model\FakeCategory::class
);
?>

<div class="<?= $data["class_name"] ?> catalog-filters">
    <form class="catalog-filters__form">
        <?php
        if (!$data['fav'] && !$data['hide_cats']): ?>
            <h4 class="catalog-filters__title">Категории</h4>

            <?php
            if ($par && $par->category_id != $cat->category_id) {
                App\Layout\Components\Blocks\Catalog\CatalogBack\Layout::draw([
                    'text' => $par->name,
                    'href' => $data['is_search'] ? ('search/?category_id=' . $par->category_id . '&q=' . $_REQUEST['q']) : ($par->path . '/'),
                    'is_search' => $data['is_search'],
                ]);
            } ?><?php
            App\Layout\Components\Blocks\Catalog\CatalogCategories\Layout::draw([
                'class_name' => 'catalog-filters__categories',
                'cat' => $cat,
                'hasPar' => $par && $par->category_id != $cat->category_id,
                'par' => $par,
                'is_search' => $data['is_search'],
            ]);
        endif;

        $pars = App\Extensions\Catalog\Model\Param::getAllForCategory($cat->category_id);
        $filters = [];
        if ($cat->category_id) {
            $filters = \Simflex\Core\DB::result(
                'select filters from catalog_category_cache where category_id = ?',
                0,
                [$cat->category_id]
            );
            $filters = explode(',', (string)$filters);
        } else {
            $qs = $data['th']->makeQFilter();
            $qf = $data['th']->makeWFilter(true);
            $qr = '';
            if ($qs[0]) {
                $qr .= $qs[0];
            }
            if ($qf[0]) {
                if ($qr) {
                    $qr .= ' and ';
                }
                $qr .= $qf[0];
            }

            if ($qr) {
                $qr = str_replace('t.', 'p.', $qr);
                $qr = ' and ' . $qr;
            }

            $filters = \Simflex\Core\Cache::getOrSet(
                'c.fq.' . md5($qr),
                fn() => \App\Extensions\Catalog\CategoryAssist::getGlobalFilters($qr, array_merge($qs[1] ?? [], $qf[1] ?? [])),
                86400
            );
        }
        ?>

        <?php
        $items = [];
        if (in_array('is_popular', $filters)) {
            $items[] = [
                'text' => 'Хиты',
                'checked' => $_REQUEST['popular'] ?? false,
                'hint' => \Simflex\Core\Core::siteParam('hint_popular'),
                'name' => 'popular',
                'value' => 1,
            ];
        }

        if (in_array('is_new', $filters)) {
            $items[] = [
                'text' => 'Новинки',
                'hint' => \Simflex\Core\Core::siteParam('hint_new'),
                'checked' => ($_REQUEST['new'] ?? false),
                'name' => 'new',
                'value' => 1,
            ];
        }

        if (in_array('is_sale', $filters)) {
            $items[] = [
                'text' => 'Распродажа',
                'hint' => \Simflex\Core\Core::siteParam('hint_sale'),
                'style_variant' => true,
                'checked' => ($_REQUEST['discount'] ?? false),
                'name' => 'discount',
                'value' => 1,
            ];
        }

        if ($items) {
            App\Layout\Components\Common\ToggleList\Layout::draw([
                'class_name' => 'catalog-filters__toggle-list',
                'items' => $items
            ]);
        } ?>

        <?php
        App\Layout\Components\Blocks\Catalog\PriceRange\Layout::draw([
            'price_min' => $data['minp'],
            'price_max' => $data['maxp'],
        ]); ?>

        <?php
        if ($bs = \App\Extensions\Catalog\Model\Brand::findForCategory($cat->category_id)) {
            App\Layout\Components\Common\CheckboxList\Layout::draw([
                'class_name' => 'catalog-filters__check-list-item',
                'title' => 'Совместимость',
                'items' => array_map(
                    fn($b) => [
                        'text' => $b->name,
                        'name' => 'brand[]',
                        'value' => $b->brand_id,
                        'checked' => in_array($b->brand_id, $_REQUEST['brand'] ?? [])
                    ],
                    $bs
                ),
                'is_search' => true,
            ]);
        } ?>

        <?php
        if (!$data['fav']) {
            $seen = [];
            foreach ($pars as $p) {
                if (in_array($p->param_id, $seen)) {
                    continue;
                }

                $seen[] = $p->param_id;
                $hasActive = 0;
                foreach ($_REQUEST['param_' . $p->param_id] ?? [] as $v) {
                    if ($v) {
                        $hasActive++;
                    }
                }

                $varr = $_REQUEST['param_' . $p->param_id] ?? [];
                if ($p->is_bool) {
                    App\Layout\Components\Common\ToggleList\Layout::draw([
                        'items' => [
                            [
                                'text' => $p->name,
                                'hint' => $p->desc,
                                'name' => 'param_' . $p->param_id . '[]',
                                'value' => '1',
                                'checked' => in_array(1, $varr),
                            ],
                        ]
                    ]);
                } else {

                    App\Layout\Components\Common\CheckboxList\Layout::draw([
                        'class_name' => 'catalog-filters__check-list-item',
                        'title' => $p->name,
                        'is_search' => true,
                        'items' => array_map(fn($v) => [
                            'text' => $v['value'],
                            'name' => 'param_' . $p->param_id . '[]',
                            'value' => $v['value'],
                            'checked' => in_array($v['value'], $varr),
                        ],
                            $p->getValues(array_merge([$cat->category_id], $cat->getAllChildren())))
                    ]);
                }
            }
        } ?>

        <div class="catalog-filters__bottom">
            <?php
            App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Применить',
                'style' => 'primary',
                'class_name' => 'catalog-filters__apply-button js--apply',
                'type' => 'submit'
            ]); ?>

            <div class="catalog-filters__amount">
                <span>Фильтров выбрано: <span class="catalog-filters__selected">0</span></span>
                <button class="catalog-filters__reset">Сбросить</button>
            </div>
        </div>

    </form>

</div>
<?php
App\Layout\Components\Modals\ModalQuantity\Layout::draw([
    'count' => $count,
]); ?>