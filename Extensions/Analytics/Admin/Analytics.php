<?php

namespace App\Extensions\Analytics\Admin;

use Simflex\Admin\Base;
use Simflex\Admin\Page;
use Simflex\Core\DB;
use Simflex\Core\Time;

class Analytics extends Base
{
    protected $statusToTextMap = [
        'pay' => 'Ожидает оплаты',
        'new' => 'Новый',
        'accepted' => 'Принят',
        'ready' => '',
        'sent' => 'Доставляется',
        'delivered' => 'Готов к выдаче',
        'finished' => 'Завершен',
        'canceled' => 'Отменен',
        'added' => '',
        'validating' => '',
    ];

    public function content()
    {
        $inPeriod = $_REQUEST['period'] ?? 'today';
        $inCompare = $_REQUEST['comparison'] ?? 0;

        Page::js('https://cdn.sn9.ru/js/chart/4.4.2/chart.js');
        Page::js('/Extensions/Analytics/Admin/assets/script.js');
        Page::css('/Extensions/Analytics/Admin/assets/style.css');

        $curPeriod = '';
        $curAggr = '';

        $d1 = '';
        $d2 = '';
        $range = [];
        $rangePrev = [];
        $delim = '';

        $curDate = Time::mysql(time(), false, false);
        $curDateBreakdown = explode('-', $curDate);

        switch ($inPeriod) {
            case 'today':
                $curAggr = 'Сегодня';
                $curPeriod = Time::userfull(time(), false);
                $delim = 'HOUR(`date`)';
                $range = [$curDate, $curDate];

                $pastDate = Time::addInterval($curDate, '-1 day');
                $rangePrev = [$pastDate, $pastDate];

                $d1 = 'Сегодня';
                $d2 = 'Вчера';

                break;
            case 'month':
                $curAggr = 'В этом месяце';
                $curPeriod = \Simflex\Core\Time::$monthsFull[(int)date('m')];
                $delim = 'DAY(`date`)';
                $range = [
                    implode('-', [$curDateBreakdown[0], $curDateBreakdown[1], '1']),
                    implode('-', [$curDateBreakdown[0], $curDateBreakdown[1], Time::$daysInMonth[(int)$curDateBreakdown[1]]])
                ];

                $pastDate = Time::addInterval($curDate, '-1 month');
                $pastDateBd = explode('-', $pastDate);
                $rangePrev = [
                    implode('-', [$pastDateBd[0], $pastDateBd[1], '1']),
                    implode('-', [$pastDateBd[0], $pastDateBd[1], Time::$daysInMonth[(int)$pastDateBd[1]]])
                ];

                $d1 = Time::$monthsFullUCF[(int)$curDateBreakdown[1]];
                $d2 = Time::$monthsFullUCF[(int)$pastDateBd[1]];

                break;
            case 'year':
                $curAggr = 'В этом году';
                $curPeriod = date('Y') . ' год';
                $delim = 'MONTH(`date`)';
                $range = [
                    implode('-', [$curDateBreakdown[0], '1', '1']),
                    implode('-', [$curDateBreakdown[0], '12', '31'])
                ];

                $pastDate = Time::addInterval($curDate, '-1 year');
                $pastDateBd = explode('-', $pastDate);
                $rangePrev = [
                    implode('-', [$pastDateBd[0], '1', '1']),
                    implode('-', [$pastDateBd[0], '12', '31'])
                ];

                $d1 = $curDateBreakdown[0];
                $d2 = $pastDateBd[0];

                break;
            case 'decade':
                $curAggr = 'В этом десятилетии';
                $curPeriod = 'десятилетие';
                $delim = 'YEAR(`date`)';
                $range = [
                    implode('-', [(int)$curDateBreakdown[0] - 10, '1', '1']),
                    implode('-', [$curDateBreakdown[0], '12', '31'])
                ];

                $pastDate = Time::addInterval($curDate, '-10 years');
                $pastDateBd = explode('-', $pastDate);
                $rangePrev = [
                    implode('-', [(int)$pastDateBd[0] - 10, '1', '1']),
                    implode('-', [$pastDateBd[0], '12', '31'])
                ];

                $d1 = ((int)$curDateBreakdown[0] - 10) . '-' . $curDateBreakdown[0];
                $d2 = ((int)$pastDateBd[0] - 10) . '-' . $pastDateBd[0];

                break;
        }

        $data = $this->getStat($range, $delim);
        $dataPrev = $this->getStat($rangePrev, $delim);

        if (!$inCompare) {
            $chart = $this->makeChartNormal($data, $inPeriod);
        } else {
            $chart = $this->makeChartCompare(
                $data,
                $dataPrev,
                $inPeriod,
                $d1,
                $d2,
                $_REQUEST['status_compare'] ?? 'pay'
            );
        }

        $statNow = $this->aggregateByStatus($range, $_REQUEST['status'] ?? 'pay');
        $statCompare = $this->compareAggrAgainst(
            $statNow,
            $rangePrev,
            $_REQUEST['status'] ?? 'pay'
        );

        $top = $this->getTopProducts();
        $curStatus = $this->statusToTextMap[$_REQUEST['status'] ?? 'pay'];
        $curStatusCompare = $this->statusToTextMap[$_REQUEST['status_compare'] ?? 'pay'];

        include 'tpl/analytics.tpl';
    }

    protected $statusToColorMap = [
        'new' => '#F9C7D9',
        'accepted' => '#CC8FB2',
        'ready' => '',
        'sent' => '#7A83CC',
        'delivered' => '#9E7ACC',
        'finished' => '#8FCCAD',
        'canceled' => '#665C62',
        'added' => '',
        'validating' => '',
        'pay' => '#99453D',
    ];

    protected function makeLabels(string $period, array &$out)
    {
        // generate labels
        if ($period == 'today') {
            for ($i = 0; $i < 24; ++$i) {
                $out['labels'][] = ($i > 9 ? '' : '0') . $i . ':00';
            }
        } elseif ($period == 'month') {
            for ($i = 1; $i <= Time::$daysInMonth[(int)date('m')]; ++$i) {
                $out['labels'][] = $i;
            }
        } elseif ($period == 'year') {
            for ($i = 1; $i <= 12; ++$i) {
                $out['labels'][] = $i;
            }
        } else {
            $decade = (int)date('Y') - 10;
            for ($i = $decade; $i <= $decade + 10; ++$i) {
                $out['labels'][] = $i;
            }
        }
    }

    protected function makeChartCompare(
        array  $data,
        array  $dataPrev,
        string $period,
        string $d1,
        string $d2,
        string $stat
    )
    {
        $out = [
            'labels' => [],
            'datasets' => [],
        ];

        $this->makeLabels($period, $out);

        // generate datasets
        $dataMap = [];
        foreach ($out['labels'] as $l) {
            $v = $dataPrev[(int)$l] ?? [];
            if (!$v) {
                // default everything to 0 this day
                $dataMap[$d2][(int)$l] = ['orders' => 0, 'items' => 0, 'price' => 0];

                continue;
            }

            // run add pass
            $ks = [];
            foreach ($v as $vv) {
                if ($vv['status'] != $stat) {
                    continue;
                }

                $dataMap[$d2][(int)$l] = ['price' => (int)$vv['sum'], 'orders' => (int)$vv['ords'], 'items' => (int)$vv['its']];
                $ks[] = $d2;
            }
        }

        foreach ($out['labels'] as $l) {
            $v = $data[(int)$l] ?? [];
            if (!$v) {
                // default everything to 0 this day
                $dataMap[$d1][(int)$l] = ['orders' => 0, 'items' => 0, 'price' => 0];

                continue;
            }

            // run add pass
            $ks = [];
            foreach ($v as $vv) {
                if ($vv['status'] != $stat) {
                    continue;
                }

                $dataMap[$d1][(int)$l] = ['price' => (int)$vv['sum'], 'orders' => (int)$vv['ords'], 'items' => (int)$vv['its']];
                $ks[] = $d1;
            }
        }

        // make dataset array
        foreach ($dataMap as $k => $v) {
            $i = [
                'label' => $k,
                'data' => array_values($v),
                'borderRadius' => 8,
                'backgroundColor' => $k == $d1 ? '#F9C7D9' : '#CC8FB2'
            ];

            $out['datasets'][] = $i;
        }

        return htmlspecialchars(json_encode($out));
    }

    protected function makeChartNormal(array $data, string $period)
    {
        $out = [
            'labels' => [],
            'datasets' => []
        ];

        $this->makeLabels($period, $out);

        // generate datasets
        $dataMap = [];
        foreach ($out['labels'] as $l) {
            $v = $data[(int)$l] ?? [];
            if (!$v) {
                // default everything to 0 this day
                foreach ($this->statusToTextMap as $k => $v) {
                    if ($v) {
                        $dataMap[$k][] = ['orders' => 0, 'items' => 0, 'price' => 0];
                    }
                }

                continue;
            }

            // run add pass
            $ks = [];
            foreach ($v as $vv) {
                $dataMap[$vv['status']][] = ['price' => (int)$vv['sum'], 'orders' => (int)$vv['ords'], 'items' => (int)$vv['its']];
                $ks[] = $vv['status'];
            }

            // default empty
            foreach ($this->statusToTextMap as $k => $v) {
                if (!in_array($k, $ks) && $v) {
                    $dataMap[$k][] = ['orders' => 0, 'items' => 0, 'price' => 0];
                }
            }
        }

        // make dataset array
        foreach ($dataMap as $k => $v) {
            $i = [
                'label' => $this->statusToTextMap[$k],
                'data' => array_values($v),
                'borderRadius' => 8,
                'backgroundColor' => $this->statusToColorMap[$k]
            ];

            $out['datasets'][] = $i;
        }

        return htmlspecialchars(json_encode($out));
    }

    protected function rotateMonth(int $m): int
    {
        if ($m < 1) {
            return 12 + $m - 1;
        }

        return $m;
    }

    protected function formatPercent(float $proc): string
    {
        if ($proc > 0) {
            return '+' . (int)$proc . '%';
        }

        return $proc . '%';
    }

    protected function formatDir(float $proc): string
    {
        if ($proc > 0) {
            return 'positive';
        } elseif ($proc < 0) {
            return 'negative';
        } else {
            return 'neutral';
        }
    }

    protected function getStat(array $range, string $d)
    {
        return DB::assoc("SELECT $d AS d, sum(op.price * op.qty) AS `sum`, status, count(distinct co.order_id) AS ords, sum(op.qty) AS its
FROM catalog_order co
         LEFT JOIN catalog_order_product op USING (order_id)
WHERE DATE(`date`) >= '$range[0]' AND DATE(`date`) <= '$range[1]'
GROUP BY d, status", 'd', '');
    }

    protected function compareAggrAgainst(array $a, array $range, string $status)
    {
        $against = $this->aggregateByStatus($range, $status);
        $toProc = function ($a, $b, $n) {
            if (!(int)$a[$n] && !(int)$b[$n]) {
                return 0;
            } elseif (!(int)$a[$n]) {
                return -100;
            } elseif (!(int)$b[$n]) {
                return 100;
            }

            $c = (float)$a[$n];
            $p = (float)$b[$n];

            if ($c > $p) {
                $c -= $p;
                return (int)($c / $p * 100);
            } elseif ($p > $c) {
                return (int)((1.0 - $c / $p) * 100) * -1;
            }

            return 0;
        };

        return [
            'total' => $toProc($a, $against, 'total'),
            'prods' => $toProc($a, $against, 'prods'),
            'tot' => $toProc($a, $against, 'tot'),
            'act' => $toProc($a, $against, 'act'),
            'marg' => $toProc($a, $against, 'marg'),
        ];
    }

    protected function aggregateByStatus(array $range, string $status)
    {
        $q = DB::query(
            "SELECT COUNT(DISTINCT o.order_id)              as total,
       COALESCE(SUM(op.qty), 0)       as prods,
       COALESCE(SUM(p.price_base * op.qty), 0) as tot,
       COALESCE(SUM(op.price * op.qty), 0)     as act
FROM catalog_order o
         LEFT JOIN catalog_order_product op ON o.order_id = op.order_id
         LEFT JOIN catalog_product p ON op.product_id = p.product_id
WHERE DATE(`date`) >= '$range[0]' AND DATE(`date`) <= '$range[1]'
  AND status = ?",
            [$status]
        );

        $r = DB::fetch($q);
        $r['marg'] = $r['act'] - $r['tot'];
        return $r;
    }

    protected function getTopProducts()
    {
        return DB::assoc(
            'select co.product_id, name, photo, sum(co.qty) as total, sum(co.price) as price
from catalog_product cp
         left join catalog_order_product co on (co.product_id = cp.product_id)
group by co.product_id, name, photo
order by total desc
limit 50'
        );
    }
}