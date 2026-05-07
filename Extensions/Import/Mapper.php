<?php

namespace App\Extensions\Import;

use App\Extensions\Import\Model\Mapping;
use App\Extensions\Import\Model\Parser;
use App\Extensions\Import\Parser\ParsedData;
use Simflex\Core\Log;

class Mapper
{
    protected function resolve(array $data, array $path, $cbk, bool $array = false)
    {
        $curData = $data;
        for ($i = 0; $i < count($path); ++$i) {
            if (!is_array($curData)) {
                break;
            }

            $key = $path[$i];
            if ($key == '*') {
                foreach ($curData as $curDatum) {
                    $this->resolve($curDatum, array_slice($path, $i + 1), $cbk, $array);
                }

                break;
            } else {
                $curData = $curData[$key] ?? null;
                if ((!is_array($curData) || $array && ($i == count($path) - 1)) && !is_null($curData)) {
                    $cbk($curData);
                }

                // reached end...
                if (is_null($curData)) {
                    $cbk(null);
                }
            }
        }
    }

    public function map(ParsedData $data): array
    {
        $parser = Parser::findOne(['class' => $data->parser]);
        if (!$parser) {
            return [];
        }

        $mappers = Mapping::find(['parser_id' => $parser->parser_id]);

        $out = [];
        foreach ($mappers as $mapper) {
            // nope
            if ($mapper->getTable() == 'catalog_stock' || $mapper->getTable() == 'catalog_price') {
                continue;
            }

            $curi = 0;
            $this->resolve($data->kvs, explode('.', trim($mapper->path)), function ($val) use (&$curi, $mapper, &$out) {
                $out[$mapper->getTable()][$curi++][$mapper->field] = $val;
            }, str_starts_with($mapper->field, '#'));
        }

        // todo remove this shit
        if (isset($data->kvs['Предложения'])) {
            $items = $data->kvs['Предложения'][0]['Предложение'];
            foreach ($items as $item) {
                $stockData = [
                    '__iid' => $item['Ид'],
                    'available' => $item['Количество']
                ];

                $priceData = [
                    '__iid' => $item['Ид'],
                    'price' => []
                ];

                foreach ($item['Цены'][0]['Цена'] as $pd) {
                    $priceData['price'][] = $pd['ЦенаЗаЕдиницу'];
                }

                rsort($priceData['price']);

                $out['catalog_stock'][] = $stockData;
                $out['catalog_price'][] = $priceData;
            }
        }

        return $out;
    }
}