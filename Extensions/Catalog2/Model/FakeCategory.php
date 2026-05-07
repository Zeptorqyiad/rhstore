<?php

namespace App\Extensions\Catalog2\Model;

use App\Extensions\Catalog\CategoryAssist;
use App\Extensions\Catalog\Model\Product;
use App\Extensions\Catalog2\ProductFilter;
use Simflex\Core\Buffer;
use Simflex\Core\DB;
use Simflex\Core\Profiler;

class FakeCategory extends \App\Extensions\Catalog\Model\FakeCategory
{
    public string $path = 'catalog';
    public string $oldName = 'Каталог';

    public function getProducts($limit = '', $order = '', $filter = '')
    {
        $filter = ProductFilter::fromUnk($filter) ?: new ProductFilter();

        Profiler::traceStart($this, __FUNCTION__);
        $ret = Buffer::getOrSet(
            'gcat.products.' . md5(
                $limit . '.' . $order . '.'
                . ($filter->getWhere() ?? '') . '.'
                . json_encode($filter->bind)
            ),
            function () use ($limit, $order, $filter) {
                $levelId = PriceLevel::getAuto()->level_id;

                $q = (new DB\AQ())->from('catalog_product', 't')
                    ->select(
                        't.*, null as variant_id, coalesce(vdp.discounted_price / vdp.original_price, 0) as discount, avg(rv.rating) as rating, vdp.discounted_price as price, vdp.discounted_price as sorter, vdp.original_price as price_old'
                    )
                    ->setModelClass(Product::class);

                $pvs = $filter->getJoins();
                foreach ($filter->paramValues as $pv) {
                    $pvs .= " LEFT JOIN catalog_param_value pv$pv ON pv$pv.product_id = t.product_id AND coalesce(pv$pv.variant_id, 0) = 0\n";
                }

                $qw = "
                $pvs
                LEFT JOIN review rv ON rv.product_id = t.product_id
                INNER JOIN RankedDiscounts AS vdp ON t.product_id = vdp.product_id AND vdp.rn = 1
WHERE t.is_active = 1
  ";

                $fval = '';
                if ($w = $filter->getWhere()) {
                    $qw .= ' AND ' . $w . ' ';
                    $fval = ' AND ' . $w . ' ';
                }

                $qw .= ' GROUP BY t.product_id, vdp.discounted_price, vdp.original_price ';

                $pvs = $filter->getJoins();
                foreach ($filter->paramValues as $pv) {
                    $pvs .= " LEFT JOIN catalog_param_value pv$pv ON pv$pv.product_id = t.product_id AND pv$pv.variant_id = pv.variant_Id\n";
                }

                // var selector
                $qw .= "
                UNION ALL

SELECT
    t.*,
    pv.variant_id,
    coalesce(vdp.discounted_price / vdp.original_price, 0) as discount,
    avg(rv.rating) as rating, (pv.price * coalesce(vdp.discounted_price / vdp.original_price, 0)) as price, (pv.price * coalesce(vdp.discounted_price / vdp.original_price, 0)) as sorter, pv.price as price_old
FROM
    catalog_product t
        INNER JOIN catalog_product_variant pv ON t.product_id = pv.product_id
        INNER JOIN RankedDiscounts AS vdp ON t.product_id = vdp.product_id AND vdp.rn = 1
        $pvs
        LEFT JOIN review rv ON rv.product_id = t.product_id
WHERE
    t.is_active = 1
  $fval
GROUP BY
    t.product_id, pv.variant_id, vdp.discounted_price, vdp.original_price
                ";

                if ($order) {
                    $qw .= ' ORDER BY ' . $order . ' ';
                }

                if ($limit) {
                    $qw .= ' LIMIT ' . $limit . ' ';
                }

                $q->custom($qw);
                $q->prefix(
                    "WITH RankedDiscounts AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY discounted_price ASC) AS rn
    FROM v_product_discounted_multi_price
    WHERE level_id = $levelId
)"
                );

                $q->bind($filter->bind);

                $all = $q->all();
                CategoryAssist::queryLinks($all);
                return $all;
            }
        );
        Profiler::traceEnd($this, __FUNCTION__);
        return $ret;
    }

    public function getProductCount($filter = [])
    {
        $filter = ProductFilter::fromUnk($filter) ?: new ProductFilter();

        Profiler::traceStart($this, __FUNCTION__);
        $ret = Buffer::getOrSet('gcat.count.' . md5(($filter->getWhere() ?? '') . '.' . json_encode($filter->bind)), function () use ($filter) {
            $levelId = PriceLevel::getAuto()->level_id;

            $pvs = $filter->getJoins();
            $pvs2 = $filter->getJoins();
            foreach ($filter->paramValues as $pv) {
                $pvs .= " LEFT JOIN catalog_param_value pv$pv ON pv$pv.product_id = t.product_id AND coalesce(pv$pv.variant_id, 0) = 0\n";
                $pvs2 .= " LEFT JOIN catalog_param_value pv$pv ON pv$pv.product_id = t.product_id AND pv$pv.variant_id = pv.variant_id\n";
            }

            $qw = '';
            if ($filter->getWhere()) {
                $qw = ' AND ' . $filter->getWhere();
            }
            $q = "WITH RankedDiscounts AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY discounted_price ASC) AS rn
    FROM v_product_discounted_multi_price
    WHERE level_id = $levelId
)
SELECT COUNT(*) AS total_count
FROM (
         SELECT t.product_id
         FROM `catalog_product` t
                  $pvs
                  INNER JOIN RankedDiscounts vdp ON t.product_id = vdp.product_id AND vdp.rn = 1
         WHERE t.is_active = 1
           $qw
         GROUP BY t.product_id

         UNION ALL

         SELECT pv.product_id
         FROM catalog_product_variant pv
                  INNER JOIN catalog_product t ON t.product_id = pv.product_id
                  INNER JOIN RankedDiscounts vdp ON t.product_id = vdp.product_id AND vdp.rn = 1
                  $pvs2
         WHERE t.is_active = 1 
           $qw
         GROUP BY pv.product_id, pv.variant_id
     ) AS combined;";

            return DB::result($q, 0, $filter->bind);
        });
        Profiler::traceEnd($this, __FUNCTION__);
        return $ret;
    }
}
