<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_price_level', function (Schema\Table $c) {
            $c->id('level_id');
            $c->string('name');
            $c->price('min');
            $c->boolean('is_by_total');
        });

        $s->createTable('catalog_price', function (Schema\Table $c) {
            $c->id('price_id');
            $c->integer('product_id')->foreignKey('catalog_product');
            $c->integer('variant_id');
            $c->integer('level_id')->foreignKey('catalog_price_level');
            $c->price('price');
        });

        $s->table('user', function (Schema\Table $c) {
            $c->price('spent');
        });
    }

    public function down(Schema $s)
    {
        $s->table('user', function (Schema\Table $c) {
            $c->dropColumns('spent');
        });

        $s->dropTable('catalog_price');
        $s->dropTable('catalog_price_level');
    }
};