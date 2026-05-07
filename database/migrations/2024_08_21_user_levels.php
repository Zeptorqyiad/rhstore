<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('user_level', function (Schema\Table $c) {
            $c->id('level_id');
            $c->string('name');
            $c->string('desc');
            $c->integer('level_ord');
            $c->price('min');
            $c->enum('color', ['green', 'blue', 'orange', 'red'])->setDefault('green');
            $c->integer('unlock_id');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('user_level');
    }
};