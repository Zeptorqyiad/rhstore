<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('catalog_category', function (Schema\Table $c) {
            $c->string('external_id')->setNull(true);
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_category', function (Schema\Table $c) {
            $c->dropColumns('external_id');
        });
    }
};