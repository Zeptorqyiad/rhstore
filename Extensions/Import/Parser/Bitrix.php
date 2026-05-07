<?php

namespace App\Extensions\Import\Parser;

use SimpleXMLElement;

class Bitrix implements ParserInterface
{
    protected SimpleXMLElement $root;
    protected ParsedData $out;

    protected function parseCls(SimpleXMLElement $cls)
    {
        $cats = [];
        foreach ($cls->Категории->children() as $cat) {
            $ca = [];
            $id = '';
            foreach ($cat->children() as $cd) {
                if ($cd->getName() === 'Ид') {
                    $id = (string)$cd;
                    continue;
                }

                $ca[$cd->getName()] = (string)$cd;
            }

            $cats[] = ['id' => $id, 'data' => $ca];
        }

        $this->out->kvs['Категории'] = $cats;

        // parse these also
        $this->out->kvs['Свойства'] = [];
        $this->parseChildren($this->out->kvs, $cls->Свойства);
    }

    protected function parseChildren(array &$p, SimpleXMLElement $chld)
    {
        $name = $chld->getName();
        if ($chld->count() > 0) {
            $out = [];
            foreach ($chld->children() as $c) {
                $this->parseChildren($out, $c);
            }

            if (!isset($p[$name])) {
                $p[$name] = [$out];
            } else {
                $p[$name][] = $out;
            }
        } else {
            $p[$name] = (string)$chld;
        }
    }

    protected function parseProducts(SimpleXMLElement $prods)
    {
        $pds = [];
        foreach ($prods->children() as $pr) {
            $p = [];
            $this->parseChildren($p, $pr);
            $pds[] = $p;
        }

        $this->out->kvs['Товары'] = $pds;
    }

    protected function parseCatalog(SimpleXMLElement $ct)
    {
        if ($prods = $ct->Товары) {
            $this->parseProducts($prods);
        }
    }

    protected function parsePriceTypes(SimpleXMLElement $pc)
    {
        $this->out->kvs['ТипыЦен'] = [];
        $this->parseChildren($this->out->kvs, $pc);
    }

    protected function parseOffers(SimpleXMLElement $pc)
    {
        $this->out->kvs['Предложения'] = [];
        $this->parseChildren($this->out->kvs, $pc);
    }

    protected function parsePack(SimpleXMLElement $pack)
    {
        if ($pc = $pack->ТипыЦен) {
            $this->parsePriceTypes($pc);
        }

        if ($pc = $pack->Предложения) {
            $this->parseOffers($pc);
        }
    }

    protected function parseXml()
    {
        if ($cls = $this->root->Классификатор) {
            $this->parseCls($cls);
        }

        if ($ct = $this->root->Каталог) {
            $this->parseCatalog($ct);
        }

        if ($pack = $this->root->ПакетПредложений) {
            $this->parsePack($pack);
        }
    }

    public function test(string $input): bool
    {
        return str_contains($input, 'КоммерческаяИнформация');
    }

    public function parse(string $input): ParsedData
    {
        $this->out = new ParsedData();
        $this->out->parser = self::class;

        try {
            $this->root = new SimpleXMLElement($input);
            $this->parseXml();
        } finally {
            return $this->out;
        }
    }
}