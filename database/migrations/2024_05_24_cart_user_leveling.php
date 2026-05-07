<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('catalog_cart', function (Schema\Table $c) {
            $c->integer('level');
        });

        $s->table('user', function (Schema\Table $c) {
            $c->integer('level');
        });

        $s->table('catalog_price_level', function (Schema\Table $c) {
            $c->integer('level_ord');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_cart', function (Schema\Table $c) {
            $c->dropColumns('level');
        });

        $s->table('user', function (Schema\Table $c) {
            $c->dropColumns('level');
        });

        $s->table('catalog_price_level', function (Schema\Table $c) {
            $c->dropColumns('level_ord');
        });
    }
};