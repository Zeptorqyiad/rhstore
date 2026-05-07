<?php
namespace App\Extensions\Catalog2;

use App\Extensions\Import\Mapper;
use App\Extensions\Import\Parser\ParserInterface;
use Simflex\Core\ConsoleBase;
use Simflex\Core\DB;

class ConsoleCatalog2 extends ConsoleBase
{
    public function parse(int $parserId, string $file)
    {
        /** @var ParserInterface $parser */
        $parser = new (DB::result('select class from mp_parser where parser_id = ?', 0, [$parserId]));
        $data = $parser->parse(file_get_contents($file));

        file_put_contents('out.json', json_encode((array)$data, JSON_UNESCAPED_UNICODE));
    }

    public function map(int $parserId, string $file)
    {
        /** @var ParserInterface $parser */
        $parser = new (DB::result('select class from mp_parser where parser_id = ?', 0, [$parserId]));
        $data = $parser->parse(file_get_contents($file));

        try {
            $mapper = new Mapper();
            $data = $mapper->map($data);

            file_put_contents('out.json', json_encode($data, JSON_UNESCAPED_UNICODE));
        } catch (\Exception $ex) {
            echo $ex->getTraceAsString();
        }
    }
}