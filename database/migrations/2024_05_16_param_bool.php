<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('catalog_param', function (Schema\Table $c) {
            $c->boolean('is_bool');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_param', function (Schema\Table $c) {
            $c->dropColumns('is_bool');
        });
    }
};