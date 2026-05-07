<?php

/** @var array $data */
$cat = $data[0];
$inf = $data[1];

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

<div class="filter-menu filter-menu_right">
    <div class="filter-menu__wrapper">
        <div class="filter-menu__top">
            <h4 class="filter-menu__title">Фильтры</h4>
            <div class="filter-menu__top-btns">
                <button class="filter-menu__reset">сбросить</button>
                <button class="filter-menu__btn-close">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                        <path fill-rule="evenodd"
                              clip-rule="evenodd"
                              d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z"
                              fill="#404040"/>
                    </svg>
                </button>
            </div>

        </div>
        <form class="filter-menu__content">
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
                App\Layout\Components\Common\ToggleListMobile\Layout::draw([
                    'class_name' => 'filter-menu__toggle-list',
                    'items' => $items
                ]);
            }?>

            <div class="d-filter-price">
                <div class="d-filter-price__top">
                    <h4 class="d-filter-price__title">Цена</h4>
                    <button class="d-filter-menu__reset">сбросить</button>
                    <?php
                    $priceReset = 'style="display:none"';
                    if (($_REQUEST['price_min'] ?? '') || ($_REQUEST['price_max'] ?? '')) {
                        $priceReset = '';
                    }
                    ?>
                </div>
                <div class="d-filter-price__values">
                    <?php
                    App\Layout\Components\Common\TextField\Layout::draw([
                        'class_name' => 'd-filter-price__min',
                        'hint' => 'от',
                        'type' => 'number',
                        'placeholder' => number_format($inf['pmin'], 0, '.', ' '),
                        'value' => $_REQUEST['price_min'] ?? '',
                        'name' => 'price_min',
                    ]); ?>

                    <?php
                    App\Layout\Components\Common\TextField\Layout::draw([
                        'class_name' => 'd-filter-price__max',
                        'hint' => 'до',
                        'placeholder' => number_format($inf['pmax'], 0, '.', ' '),
                        'type' => 'number',
                        'name' => 'price_max',
                        'value' => $_REQUEST['price_max'] ?? '',

                    ]); ?>
                </div>
            </div>

            <?php
            if ($bs = \App\Extensions\Catalog\Model\Brand::findForCategory($cat->category_id)): ?><?php
                App\Layout\UIKit\TabFilterMobile\Layout::draw([
                    'title' => 'Совместимость',
                    'items' => $bs,
                    'id' => 'brand'
                ]); ?>

                <div class="filter-menu filter-sub-menu mob-filter">
                    <div class="filter-menu__wrapper">
                        <div class="filter-menu__top">
                            <h4 class="filter-menu__title">Совместимость</h4>
                            <div class="filter-menu__top-btns">
                                <button class="filter-menu__reset">сбросить</button>
                                <button class="filter-menu__btn-close">
                                    <svg xmlns="http://www.w3.org/2000/svg"
                                         viewBox="0 0 24 24"
                                         fill="none">
                                        <path fill-rule="evenodd"
                                              clip-rule="evenodd"
                                              d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z"
                                              fill="#404040"/>
                                    </svg>
                                </button>
                            </div>
                        </div>
                        <div class="filter-menu__content">
                            <div class="filter-menu__search">
                                <?php
                                App\Layout\UIKit\TextField\Layout::draw([
                                    'size' => 'md',
                                    'placeholder' => 'Поиск',
                                ]); ?>

                                <div class="filter-menu__selectors">
                                    <?php
                                    App\Layout\Components\Common\CheckboxListMobile\Layout::draw([
                                        'class_name' => 'filter-menu__selector',
                                        'title' => 'Совместимость',
                                        'items' => array_map(
                                            fn($v) => [
                                                'text' => $v->name,
                                                'name' => 'brand[]',
                                                'value' => $v->brand_id,
                                                'checked' => in_array(
                                                    $v->brand_id,
                                                    $_REQUEST['brand'] ?? []
                                                ),
                                            ],
                                            $bs
                                        )
                                    ]); ?>

                                </div>
                            </div>

                            <div class="filter-menu__bottom">
                                <?php
                                App\Layout\Components\Common\Button\Layout::draw([
                                    'text' => 'Закрыть',
                                    'type' => 'button',
                                    'style' => 'primary',
                                    'class_name' => 'filter-menu__btn-submit',
                                ]); ?>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="filter-menu__bottom">
                    <div class="catalog-filters__amount">
                        <span>Фильтров выбрано: <span class="catalog-filters__selected">0</span></span>
                        <button class="catalog-filters__reset">Сбросить</button>
                    </div>

                    <?php App\Layout\Components\Common\Button\Layout::draw([
                        'text' => 'Закрыть',
                        'type' => 'submit',
                        'style' => 'primary',
                        'class_name' => 'filter-menu__btn-submit main',
                    ]); ?>
                </div>
            <?php
            endif; ?>

            <?php
            $pars = \App\Extensions\Catalog\Model\Param::getAllForCategory($cat->category_id);
            $seen = [];
            for ($i = 0; $i < count($pars); ++$i):
                $p = $pars[$i];
                if (in_array($p->param_id, $seen)) {
                    continue;
                }

                $seen[] = $p->param_id;
                $v = $p->getValues(array_merge([$cat->category_id], $cat->getAllChildren()));
                if (!$v) {
                    continue;
                }

                if (!$p->is_bool):
                    App\Layout\UIKit\TabFilterMobile\Layout::draw([
                        'title' => $p->name,
                        'items' => $v,
                        'id' => $p->param_id
                    ]);
                    ?>

                    <div class="filter-menu filter-sub-menu mob-filter">
                        <div class="filter-menu__wrapper">
                            <div class="filter-menu__top">
                                <h4 class="filter-menu__title"><?= $p->name ?></h4>
                                <div class="filter-menu__top-btns">
                                    <button class="filter-menu__reset">сбросить</button>
                                    <button class="filter-menu__btn-close">
                                        <svg xmlns="http://www.w3.org/2000/svg"
                                             width="24"
                                             height="24"
                                             viewBox="0 0 24 24"
                                             fill="none">
                                            <path fill-rule="evenodd"
                                                  clip-rule="evenodd"
                                                  d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z"
                                                  fill="#404040"/>
                                        </svg>
                                    </button>
                                </div>
                            </div>
                            <div class="filter-menu__content">
                                <div class="filter-menu__search">
                                    <?php
                                    App\Layout\UIKit\TextField\Layout::draw([
                                        'size' => 'md',
                                        'placeholder' => 'Поиск',
                                    ]); ?>

                                    <div class="filter-menu__selectors">
                                        <?php
                                        App\Layout\Components\Common\CheckboxListMobile\Layout::draw([
                                            'class_name' => 'filter-menu__selector',
                                            'title' => 'Совместимость',
                                            'items' => array_map(
                                                fn($v) => [
                                                    'text' => $v['value'],
                                                    'name' => 'param_' . $p->param_id . '[]',
                                                    'value' => $v['value'],
                                                    'checked' => in_array(
                                                        $v['value'],
                                                        $_REQUEST['param_' . $p->param_id] ?? []
                                                    ),
                                                ],
                                                $v
                                            )
                                        ]); ?>

                                    </div>
                                </div>

                                <div class="filter-menu__bottom">
                                    <?php
                                    App\Layout\Components\Common\Button\Layout::draw([
                                        'text' => 'Закрыть',
                                        'type' => 'button',
                                        'style' => 'primary',
                                        'class_name' => 'filter-menu__btn-submit',
                                    ]); ?>

                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="filter-menu__bottom">
                        <?php
                        App\Layout\Components\Common\Button\Layout::draw([
                            'text' => 'Закрыть',
                            'type' => 'submit',
                            'style' => 'primary',
                            'class_name' => 'filter-menu__btn-submit main',
                        ]); ?>
                    </div>
                <?php
                else: ?>
                    <?php
                    App\Layout\Components\Common\ToggleListMobile\Layout::draw([
                        'class_name' => 'filter-menu__toggle-list ' . ($i == count($pars) - 1 ? 'filter-menu__toggle-list_last' : ''),
                        'items' => [
                            [
                                'text' => $p->name,
                                'active' => !!($_REQUEST['param_' . $p->param_id] ?? false),
                                'name' => 'param_' . $p->param_id,
                                'value' => 1,
                            ],
                        ]
                    ]); ?>
                <?php
                endif; ?>
            <?php
            endfor; ?>
        </form>

    </div>
</div>