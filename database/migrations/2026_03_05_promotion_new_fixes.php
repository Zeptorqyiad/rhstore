<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('promotion', function (Schema\Table $c) {
            $c->string('banner_title_third');
            $c->string('banner_button_text');
            $c->string('stages_button_text');
            $c->string('form_button_text');
            $c->string('callback_button_text');
            $c->string('callback_tg_link');
            $c->string('callback_tg_button_text');
        });
    }

    public function down(Schema $s)
    {
        $s->table('promotion', function (Schema\Table $c) {
            $c->dropColumns('banner_title_third');
            $c->dropColumns('banner_button_text');
            $c->dropColumns('stages_button_text');
            $c->dropColumns('form_button_text');
            $c->dropColumns('callback_button_text');
            $c->dropColumns('callback_tg_link');
            $c->dropColumns('callback_tg_button_text');
        });
    }
};