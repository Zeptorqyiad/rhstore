<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('info_qna', function (Schema\Table $c) {
            $c->text('answer');
        });
    }

    public function down(Schema $s)
    {
        $s->table('info_qna', function (Schema\Table $c) {
            $c->dropColumns('answer');
        });
    }
};