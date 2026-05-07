<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('mp_import', function (Schema\Table $c) {
            $c->id('import_id');
            $c->integer('table_id')->foreignKey('struct_table');
            $c->integer('id');
            $c->string('iid');
            $c->integer('parser_id')->foreignKey('mp_parser');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('mp_import');
    }
};