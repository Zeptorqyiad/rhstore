<?php

namespace App\Extensions\Import\Admin;

use App\Extensions\Import\Mapper;
use App\Extensions\Import\Model\Parser;
use App\Extensions\Import\Parser\ParserInterface;
use Simflex\Admin\Base;
use Simflex\Admin\Plugins\Alert\Alert;
use Simflex\Core\Container;
use Simflex\Core\DB;

class Import extends Base
{
    protected function getParser(string $data): ?ParserInterface
    {
        foreach (Parser::all() as $p) {
            /** @var ParserInterface $pCls */
            $pCls = Container::getFactory()->create($p->class);
            if ($pCls->test($data)) {
                return $pCls;
            }
        }

        return null;
    }

    public function showActions()
    {
        echo <<<HTML
<form action="?action=import" enctype="multipart/form-data" method="post">
    <input type="file" name="file" />
    <button type="submit" class="BtnPrimarySm BtnIconLeft">
        Импорт
    </button>
</form>
HTML;

        parent::showActions();
    }

    public function import()
    {
        $file = @file_get_contents($_FILES['file']['tmp_name']);
        if (!$file) {
            Alert::error('Не удалось прочитать файл');
            header('Location: ./');
            exit;
        }

        $parser = $this->getParser($file);
        if (!$parser) {
            Alert::error('Не нашлось подходящего парсера под такой формат');
            header('Location: ./');
            exit;
        }

        $data = $parser->parse($file);
        $mapped = (new Mapper())->map($data);

        $import = new \App\Extensions\Import\Import($parser);
        $import->setOnImported(function (string $table, int $si) {
            if ($si) {
                Alert::success('Импортирована таблица ' . $table . ' (' . $si . ' записей)');
            } else {
                Alert::error('Не удалось импортировать таблицу ' . $table);
            }
        });

        $import->import($mapped);

        header('Location: ./');
        exit;
    }
}