<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('mp_parser', function (Schema\Table $c) {
            $c->id('parser_id');
            $c->string('name');
            $c->string('class');
        });

        $s->createTable('mp_mapping', function (Schema\Table $c) {
            $c->id('mapping_id');
            $c->string('path');
            $c->integer('table_id')->foreignKey('struct_table');
            $c->string('field');
            $c->integer('parser_id')->foreignKey('mp_parser');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('mp_mapping');
        $s->dropTable('mp_parser');
    }
};