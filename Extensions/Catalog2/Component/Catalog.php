<?php

namespace App\Extensions\Catalog2\Component;

use App\Extensions\Catalog\Model\Category;
use App\Extensions\Catalog\SaleAssist;
use App\Extensions\Catalog\SessionAssist;
use App\Extensions\Catalog2\Model\Price;
use App\Extensions\Catalog2\Model\PriceLevel;
use App\Extensions\Catalog2\ProductFilter;
use Simflex\Core\Container;
use Simflex\Core\DB;
use Simflex\Core\Factory;
use Simflex\Core\Log;
use Simflex\Core\Request;
use Simflex\Extensions\Content\Model\ModelContent;

class Catalog extends \App\Extensions\Catalog\Component\Catalog
{
    protected $isOlder = false;

    public function __construct(Request $request, protected Factory $factory)
    {
        parent::__construct($request);
    }

    public function get($path = ''): ?ModelContent
    {
        $content = parent::get($path);
        if ($content && $content['template_path'] == 'catalog2.tpl') {
            $content['template_path'] = $this->prod ? 'product.tpl' : 'catalog.tpl';
        }

        return $content;
    }

    protected function onGetSearch(ModelContent &$content): void
    {
        $this->cat->oldName = $this->cat->name;
        parent::onGetSearch($content);
    }

    protected function resolveMode()
    {
        $path = $this->request->getPath();

        parent::resolveMode();

        if (str_contains($path, 'past/')) {
            $this->isOlder = true;
        }
    }

    protected function resolveCategory()
    {
        $this->resolveMode();
        if ($this->isSearch) {
            $id = $this->request->request('category_id', 0);
            if (!$id) {
                return parent::resolveCategory();
            }

            return $this->factory->create(Category::class, $id);
        }

        return parent::resolveCategory();
    }

    protected function ajaxLevels()
    {
        if (!$this->prod) {
            return json_encode([]);
        }

        $prices = [];

        $level = PriceLevel::getAuto();
        $prices[] = [
            'price' => Price::findOne(
                [
                    'product_id' => $this->prod->product_id,
                    'variant_id' => $this->prod->variantId ?: null,
                    'level_id' => $level->level_id
                ]
            )?->toArray(),
            'level' => $level->toArray(),
            'mod' => SaleAssist::getModFor($this->prod->product_id),
        ];

        $nextLevel = $level->getNextLevel();
        if ($nextLevel) {
            $prices[] = [
                'price' => Price::findOne(
                    [
                        'product_id' => $this->prod->product_id,
                        'variant_id' => $this->prod->variantId ?: null,
                        'level_id' => $nextLevel->level_id
                    ]
                )?->toArray(),
                'level' => $nextLevel->toArray(),
                'mod' => SaleAssist::getModFor($this->prod->product_id),
            ];

            $nextLevel = $nextLevel->getNextLevel();
            if ($nextLevel) {
                $prices[] = [
                    'price' => Price::findOne(
                        [
                            'product_id' => $this->prod->product_id,
                            'variant_id' => $this->prod->variantId ?: null,
                            'level_id' => $nextLevel->level_id
                        ]
                    )?->toArray(),
                    'level' => $nextLevel->toArray(),
                    'mod' => SaleAssist::getModFor($this->prod->product_id),
                ];
            }
        }

        return json_encode($prices);
    }

    protected function getSorting()
    {
        $sort = 'npp DESC';
        if ($this->request->request('sort')) {
            switch ($this->request->request('sort')) {
                case 'pmin':
                    $sort = 'sorter';
                    break;
                case 'pmax':
                    $sort = 'sorter desc';
                    break;
                case 'aup':
                    $sort = 'name';
                    break;
                case 'adown':
                    $sort = 'name desc';
                    break;
            }
        }

        $this->sort = $sort;
    }

    protected function onGetOlder(ModelContent &$content): void
    {
        $content['title'] = $this->cat->name = 'Заказывали ранее';
        $this->showChildren = false;
    }

    protected function onGetDefault(ModelContent &$content): void
    {
        if ($this->isOlder) {
            $this->onGetOlder($content);
        } else {
            parent::onGetDefault($content);
        }
    }

    protected ProductFilter $builder;

    public function makeQFilter()
    {
        if (!$this->isSearch) {
            return;
        }

        $this->builder->addWhere(
            '(t.name like :search or t.sku like :search)',
            ['search' => '%' . $this->searchTerm . '%']
        );
    }

    public function makeWFilter(bool $onlyPs = false)
    {
        if (!$this->isFavorite) {
            return;
        }

        $data = SessionAssist::$fav->getList();
        $this->builder->addWhere(
            't.product_id in (' . (implode(
                ',',
                $data[0]
            ) ?: '0') . ')'
        );
    }

    protected function makeFilter()
    {
        $this->builder = new ProductFilter();
        $this->makeQFilter();
        $this->makeWFilter();

        if ($this->isOlder && ($u = Container::getUser())) {
            $this->builder->addJoin('INNER JOIN catalog_order_product cop ON cop.product_id = t.product_id');
            $this->builder->addJoin('INNER JOIN catalog_order co ON co.order_id = cop.order_id');
            $this->builder->addWhere('co.user_id = :user_id', ['user_id' => $u->user_id]);
        }

        $r = $this->request;
        if ($f = $r->request('price_min')) {
            $this->builder->addWhere('vdp.discounted_price >= :price_min', ['price_min' => $f]);
        }

        if ($f = $r->request('price_max')) {
            $this->builder->addWhere('vdp.discounted_price <= :price_max', ['price_max' => $f]);
        }

        foreach ($r->request() as $k => $v) {
            if ($k && isset($this->filterToString[$k])) {
                $this->builder->addWhere($this->filterToString[$k][0], []);
            }
        }

        if ($f = $r->request('brand')) {
            $bPl = [];
            $bVals = [];

            foreach ($f as $c) {
                $bPl[] = ':brand_' . crc32($c);
                $bVals['brand_' . crc32($c)] = $c;
            }

            $this->builder->addWhere('t.brand_id in (' . implode(',', $bPl) . ')', $bVals);
        }

        $pvBuilder = new ProductFilter();

        foreach ($r->request() as $k => $fa) {
            if (!str_starts_with($k, 'param_')) {
                continue;
            }

            $pPl = [];
            $pVals = [];
            $paramId = (int)substr($k, strlen('param_'));

            foreach ($fa as $a) {
                $pPl[] = ':param_' . $paramId . '_' . crc32($a);
                $pVals['param_' . $paramId . '_' . crc32($a)] = $a;
            }

            $pvBuilder->addWhere(
                "(pv$paramId.param_id = $paramId AND pv$paramId.value IN (" . implode(',', $pPl) . "))",
                $pVals
            );
            $this->builder->addParam($paramId);
        }

        if ($pvBuilder->where) {
            $this->builder->addWhere('(' . $pvBuilder->getWhere() . ')');
            $this->builder->bind = array_merge($this->builder->bind, $pvBuilder->bind);
        }

        return $this->builder;
    }

    protected function getMinMaxPrices()
    {
        $levelId = PriceLevel::getAuto()->level_id;

        $this->min_price = DB::result(
            'select discounted_price from v_product_discounted_multi_price where level_id = ? order by discounted_price limit 1',
            0,
            [$levelId]
        );
        $this->max_price = DB::result(
            'select discounted_price from v_product_discounted_multi_price where level_id = ? order by discounted_price desc limit 1',
            0,
            [$levelId]
        );
    }
}