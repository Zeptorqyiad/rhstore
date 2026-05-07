<?php
namespace App\Extensions\Import\Parser;

interface ParserInterface
{
    public function test(string $input): bool;
    public function parse(string $input): ParsedData;
}