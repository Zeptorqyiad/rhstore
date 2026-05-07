<?php
/** @var array $content */

$sellers_items = self::getTableFrom('sellers_items', $content);
$problems_cards = self::getTableFrom('problems_cards', $content);
$three_items = self::getTableFrom('three_items', $content);
$four_items = self::getTableFrom('four_items', $content);
$frequent_cards = self::getTableFrom('frequent_cards', $content);
$checkboxes_fst = self::getTableFrom('checkboxes_fst', $content);
$checkboxes_s = self::getTableFrom('checkboxes_s', $content);
$checkboxes_t = self::getTableFrom('checkboxes_t', $content);
$checkboxes_frth = self::getTableFrom('checkboxes_frth', $content);
$checkboxes_fth = self::getTableFrom('checkboxes_fth', $content);
$index = $content->loadFrom('/');

?>

<?php
//App\Layout\Components\Common\RunningLine\Layout::draw();
App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<?php
App\Layout\Pages\ForSellers\Layout::draw([
    'sellers_title' => $content['params']['sellers_title'],
    'sellers_title_accent' => $content['params']['sellers_title_accent'],
    'sellers_text' => $content['params']['sellers_text'],
    'sellers_items' => $sellers_items,
    'sellers_box_text' => $content['params']['sellers_box_text'],
    'sellers_right_text' => $content['params']['sellers_right_text'],
    'sellers_right_img' => '/uf/images/source/' . $content['params']['sellers_right_img'],

    'problems_title' => $content['params']['problems_title'],
    'problems_title_accent' => $content['params']['problems_title_accent'],
    'problems_text' => $content['params']['problems_text'],
    'problems_info_text' => $content['params']['problems_info_text'],
    'problems_info_img' => '/uf/images/source/' . $content['params']['problems_info_img'],
    'problems_cards' => $problems_cards,

    'problem_one_title' => $content['params']['problem_one_title'],
    'one_top_title' => $content['params']['one_top_title'],
    'one_top_text' => $content['params']['one_top_text'],
    'one_bottom_title' => $content['params']['one_bottom_title'],
    'one_bottom_text' => $content['params']['one_bottom_text'],
    'problem_one_img' => '/uf/images/source/' . $content['params']['problem_one_img'],

    'problem_two_img' => '/uf/images/source/' . $content['params']['problem_two_img'],
    'problem_two_title' => $content['params']['problem_two_title'],
    'two_top_title_f' => $content['params']['two_top_title_f'],
    'two_top_text_f' => $content['params']['two_top_text_f'],
    'two_bottom_title_f' => $content['params']['two_bottom_title_f'],
    'two_bottom_text_f' => $content['params']['two_bottom_text_f'],
    'two_top_title_s' => $content['params']['two_top_title_s'],
    'two_top_text_s' => $content['params']['two_top_text_s'],
    'two_bottom_title_s' => $content['params']['two_bottom_title_s'],
    'two_bottom_text_s' => $content['params']['two_bottom_text_s'],
    'problem_two_button' => $content['params']['problem_two_button'],

    'problem_three_title' => $content['params']['problem_three_title'],
    'three_list_title' => $content['params']['three_list_title'],
    'three_items' => $three_items,

    'three_title_f' => $content['params']['three_title_f'],
    'three_text_f' => $content['params']['three_text_f'],
    'three_icon_f' => '/uf/images/source/' . $content['params']['three_icon_f'],

    'three_title_s' => $content['params']['three_title_s'],
    'three_text_s' => $content['params']['three_text_s'],
    'three_icon_s' => '/uf/images/source/' . $content['params']['three_icon_s'],

    'three_title_t' => $content['params']['three_title_t'],
    'three_text_t' => $content['params']['three_text_t'],
    'three_icon_t' => '/uf/images/source/' . $content['params']['three_icon_t'],

    'three_img_f' => '/uf/images/source/' . $content['params']['three_img_f'],
    'three_img_s' => '/uf/images/source/' . $content['params']['three_img_s'],

    'problem_four_title' => $content['params']['problem_four_title'],
    'problem_four_img' => '/uf/images/source/' . $content['params']['problem_four_img'],
    'four_items' => $four_items,

    'become_title' => $content['params']['become_title'],
    'become_text_f' => $content['params']['become_text_f'],
    'become_text_s' => $content['params']['become_text_s'],
    'become_img' => '/uf/images/source/' . $content['params']['become_img'],
    'sales_title' => $content['params']['sales_title'],
    'sales_text' => $content['params']['sales_text'],

    'ozon_title' => $content['params']['ozon_title'],
    'card_title' => $content['params']['card_title'],
    'card_text' => $content['params']['card_text'],
    'ozon_img' => '/uf/images/source/' . $content['params']['ozon_img'],
    'ozon_link' => $content['params']['ozon_link'],

    'banner_title' => $content['params']['banner_title'],
    'banner_text' => $content['params']['banner_text'],

    'frequent_title' => $content['params']['frequent_title'],
    'frequent_cards' => $frequent_cards,

    'faq-section_title' => $index['params']['faq-section_title'],
    'faq-section_text' => $index['params']['faq-section_text'],

    'modal_questions_title' => $index['params']['modal_questions_title'],
    'modal_questions_text' => $index['params']['modal_questions_text'],

    'sellers_seo_title' => $content['params']['sellers_seo_title'],
    'sellers_seo_text' => $content['params']['sellers_seo_text'],
    'sellers_seo_title-s' => $content['params']['sellers_seo_title-s'],
    'sellers_seo_text-s' => $content['params']['sellers_seo_text-s'],

    'consultation_title' => $content['params']['consultation_title'],
    'consultation_text' => $content['params']['consultation_text'],
    'consultation_text_policy' => $content['params']['consultation_text_policy'],

    'checklist_title' => $content['params']['checklist_title'],
    'checklist_text' => $content['params']['checklist_text'],
    'checklist_title_fst' => $content['params']['checklist_title_fst'],
    'checklist_title_s' => $content['params']['checklist_title_s'],
    'checklist_title_t' => $content['params']['checklist_title_t'],
    'checklist_title_frth' => $content['params']['checklist_title_frth'],
    'checklist_title_fth' => $content['params']['checklist_title_fth'],
    'checkboxes_fst' => $checkboxes_fst,
    'checkboxes_s' => $checkboxes_s,
    'checkboxes_t' => $checkboxes_t,
    'checkboxes_frth' => $checkboxes_frth,
    'checkboxes_fth' => $checkboxes_fth,

    'success_title' => $index['params']['success_title'],
    'success_text' => $index['params']['success_text'],
    'success_title_mobile' => $index['params']['success_title_mobile'],
    'success_text_mobile' => $index['params']['success_text_mobile'],
    'error_title' => $index['params']['error_title'],
    'error_text' => $index['params']['error_text'],
    'error_title_mobile' => $index['params']['error_title_mobile'],
    'error_text_mobile' => $index['params']['error_text_mobile'],
]); ?>