<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('promotion', function (Schema\Table $c) {
            $c->integer('banner_npp');
            $c->integer('numbers_npp');
            $c->integer('info_npp');
            $c->integer('consists_npp');
            $c->integer('stages_npp');
            $c->integer('callback_npp');
            $c->integer('sales_npp');
            $c->integer('adv_npp');
            $c->integer('promo_slider_npp');
            $c->integer('about_npp');
            $c->integer('advantages_npp');
            $c->integer('form_npp');
            $c->integer('faq_npp');
        });
    }

    public function down(Schema $s)
    {
        $s->table('promotion', function (Schema\Table $c) {
            $c->dropColumns('banner_npp');
            $c->dropColumns('numbers_npp');
            $c->dropColumns('info_npp');
            $c->dropColumns('consists_npp');
            $c->dropColumns('stages_npp');
            $c->dropColumns('callback_npp');
            $c->dropColumns('sales_npp');
            $c->dropColumns('adv_npp');
            $c->dropColumns('promo_slider_npp');
            $c->dropColumns('about_npp');
            $c->dropColumns('advantages_npp');
            $c->dropColumns('form_npp');
            $c->dropColumns('faq_npp');
        });
    }
};