<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_sale_banner', function (Schema\Table $c) {
            $c->id('banner_id');
            $c->integer('npp');
            $c->enum('type', ['header', 'offer']);
            $c->string('title');
            $c->string('link');
            $c->string('photo');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_sale_banner');
    }
};