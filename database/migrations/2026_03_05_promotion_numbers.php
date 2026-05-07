<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('promotion', function (Schema\Table $c) {
            $c->text('numbers_items');
        });
    }

    public function down(Schema $s)
    {
        $s->table('promotion', function (Schema\Table $c) {
            $c->dropColumns('numbers_items');
        });
    }
};