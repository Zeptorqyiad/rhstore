<?php
namespace App\Extensions\Import\Parser;

class ParsedData
{
    public string $parser = '';
    public bool $isDelta = false;
    public array $kvs = [];
}