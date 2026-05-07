<?php

use Simflex\Admin\Migration\Struct;
use Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('promotion', function (Schema\Table $c) {
            $c->id('promo_id');
            $c->integer('npp');
            $c->string('name');
            $c->boolean('is_active');
            $c->string('date');
            $c->string('photo');
            $c->string('alias');
            $c->string('badge');
            $c->string('banner_title');
            $c->string('banner_title_accent');
            $c->string('banner_offer_title');
            $c->text('banner_offer_text');
            $c->text('banner_items');
            $c->string('banner_price');
            $c->string('banner_price_throught');
            $c->string('info_title');
            $c->text('info_text');
            $c->string('info_consist_title');
            $c->text('info_consist_text');
            $c->string('info_image');
            $c->string('consists_title');
            $c->text('consists_items');
            $c->string('stages_title');
            $c->string('stages_image');
            $c->text('stages_items');
            $c->string('callback_title');
            $c->text('callback_text');
            $c->string('sales_title');
            $c->string('sales_card1_title');
            $c->text('sales_card1_text');
            $c->string('sales_card1_image');
            $c->string('sales_card2_title');
            $c->text('sales_card2_text');
            $c->string('sales_card2_image');
            $c->string('adv_title');
            $c->text('adv_items');
            $c->string('about_title');
            $c->text('about_desc_f');
            $c->text('about_desc_s');
            $c->string('about_first_top');
            $c->string('about_first_middle');
            $c->string('about_first_bottom');
            $c->string('about_sec_top');
            $c->string('about_sec_middle');
            $c->string('about_sec_bottom');
            $c->string('about_third_top');
            $c->string('about_third_middle');
            $c->string('about_third_bottom');
            $c->string('about_slide_f_right');
            $c->string('about_slide_s_left');
            $c->string('about_approach_img');
            $c->string('advantages_title');
            $c->text('advantages_items');
            $c->string('form_title');
            $c->text('form_text');
            $c->string('faq_title');
            $c->text('faq_text');
            $c->text('faq_items');
            $c->string('seo_title1');
            $c->text('seo_text1');
            $c->string('seo_title2');
            $c->text('seo_text2');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('promotion');
    }
};