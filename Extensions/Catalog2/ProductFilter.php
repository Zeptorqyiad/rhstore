<?php

namespace App\Extensions\Catalog2;

class ProductFilter
{
    public array $where = [];
    public array $bind = [];
    public array $paramValues = [];
    public array $joins = [];

    public static function fromUnk($filter) {
        if (is_string($filter)) {
            $fOld = $filter;
            $filter = new ProductFilter();
            $filter->addWhere($fOld);
        }

        if (is_array($filter)) {
            $fOld = $filter;
            $filter = new ProductFilter();

            if (isset($fOld[0])) {
                $filter->addWhere($fOld[0], $fOld[3] ?? []);
            }

            if (isset($fOld[1])) {
                $filter->paramValues = $fOld[1];
            }
        }

        return $filter;
    }

    public function addJoin(string $join): void
    {
        $this->joins[] = $join;
    }

    public function addWhere(string $where, array $bind = []): void
    {
        $this->where[] = $where;
        $this->bind = array_merge($this->bind, $bind);
    }

    public function addParam(string $param): void
    {
        $this->paramValues[] = $param;
    }

    public function getWhere(): string
    {
        return implode(' AND ', $this->where);
    }

    public function getJoins(): string
    {
        return implode(' ', $this->joins);
    }
}