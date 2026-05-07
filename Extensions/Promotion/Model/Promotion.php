<?php

namespace App\Extensions\Promotion\Model;

use Simflex\Core\ModelBase;

/**
 * @property int promo_id
 * @property int npp
 * @property string name
 * @property string date
 * @property string photo
 * @property string alias
 * @property string badge
 * @property string banner_title
 * @property string banner_title_accent
 * @property string banner_offer_title
 * @property text banner_offer_text
 * @property text banner_items
 * @property string banner_price
 * @property string banner_price_throught
 * @property string info_title
 * @property text info_text
 * @property string info_consist_title
 * @property text info_consist_text
 * @property string info_image
 * @property string consists_title
 * @property text consists_items
 * @property string stages_title
 * @property string stages_image
 * @property text stages_items
 * @property string callback_title
 * @property text callback_text
 * @property string sales_title
 * @property string sales_card1_title
 * @property text sales_card1_text
 * @property string sales_card1_image
 * @property string sales_card2_title
 * @property text sales_card2_text
 * @property string sales_card2_image
 * @property string adv_title
 * @property text adv_items
 * @property string about_title
 * @property text about_desc_f
 * @property text about_desc_s
 * @property string about_first_top
 * @property string about_first_middle
 * @property string about_first_bottom
 * @property string about_sec_top
 * @property string about_sec_middle
 * @property string about_sec_bottom
 * @property string about_third_top
 * @property string about_third_middle
 * @property string about_third_bottom
 * @property string about_slide_f_right
 * @property string about_slide_s_left
 * @property string about_approach_img
 * @property string advantages_title
 * @property text advantages_items
 * @property string form_title
 * @property text form_text
 * @property string faq_title
 * @property text faq_text
 * @property text faq_items
 * @property string seo_title1
 * @property text seo_text1
 * @property string seo_title2
 * @property text seo_text2
 */
class Promotion extends ModelBase
{
    protected static $table = 'promotion';
    protected static $primaryKeyName = 'promotion_id';
}