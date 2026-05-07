<?php
/** @var array $data */

?>

<main class="for-sellers">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'for-sellers__breadcrumbs wrapper',
        'text' => 'Для селлеров'
    ]);
    ?>
    <div class="for-sellers__container">
        <?php
        App\Layout\Components\Blocks\ForSellers\SellerHero\Layout::draw([
            'sellers_title' => $data['sellers_title'],
            'sellers_title_accent' => $data['sellers_title_accent'],
            'sellers_text' => $data['sellers_text'],
            'sellers_items' => $data['sellers_items'],
            'sellers_box_text' => $data['sellers_box_text'],
            'sellers_right_text' => $data['sellers_right_text'],
            'sellers_right_img' => $data['sellers_right_img'],
        ]);

        App\Layout\Components\Blocks\ForSellers\AllProblems\Layout::draw([
            'problems_title' => $data['problems_title'],
            'problems_title_accent' => $data['problems_title_accent'],
            'problems_text' => $data['problems_text'],
            'problems_info_text' => $data['problems_info_text'],
            'problems_info_img' => $data['problems_info_img'],
            'problems_cards' => $data['problems_cards'],
        ]);

        App\Layout\Components\Blocks\ForSellers\ProblemOne\Layout::draw([
            'problem_num' => $data['problem_num'],
            'problem_one_title' => $data['problem_one_title'],
            'one_top_title' => $data['one_top_title'],
            'one_top_text' => $data['one_top_text'],
            'one_bottom_title' => $data['one_bottom_title'],
            'one_bottom_text' => $data['one_bottom_text'],
            'problem_one_img' => $data['problem_one_img'],
        ]);
        App\Layout\Components\Blocks\ForSellers\ProblemTwo\Layout::draw([

            'problem_two_img' => $data['problem_two_img'],
            'problem_two_title' => $data['problem_two_title'],
            'two_top_title_f' => $data['two_top_title_f'],
            'two_top_text_f' => $data['two_top_text_f'],
            'two_bottom_title_f' => $data['two_bottom_title_f'],
            'two_bottom_text_f' => $data['two_bottom_text_f'],
            'two_top_title_s' => $data['two_top_title_s'],
            'two_top_text_s' => $data['two_top_text_s'],
            'two_bottom_title_s' => $data['two_bottom_title_s'],
            'two_bottom_text_s' => $data['two_bottom_text_s'],
            'problem_two_button' => $data['problem_two_button'],

        ]);
        App\Layout\Components\Blocks\ForSellers\ProblemThree\Layout::draw([
            'problem_three_title' => $data['problem_three_title'],
            'three_list_title' => $data['three_list_title'],
            'three_items' => $data['three_items'],
            'three_title_f' => $data['three_title_f'],
            'three_text_f' => $data['three_text_f'],
            'three_icon_f' => $data['three_icon_f'],

            'three_title_s' => $data['three_title_s'],
            'three_text_s' => $data['three_text_s'],
            'three_icon_s' => $data['three_icon_s'],

            'three_title_t' => $data['three_title_t'],
            'three_text_t' => $data['three_text_t'],
            'three_icon_t' => $data['three_icon_t'],

            'three_img_f' => $data['three_img_f'],
            'three_img_s' => $data['three_img_s'],

        ]);
        App\Layout\Components\Blocks\ForSellers\ProblemFour\Layout::draw([
            'problem_four_title' => $data['problem_four_title'],
            'problem_four_img' => $data['problem_four_img'],
            'four_items' => $data['four_items'],
        ]);

        App\Layout\Components\Blocks\ForSellers\BecomeSeller\Layout::draw([
            'become_title' => $data['become_title'],
            'become_text_f' => $data['become_text_f'],
            'become_text_s' => $data['become_text_s'],
            'become_img' => $data['become_img'],
        ]);

        App\Layout\Components\Blocks\ForSellers\BrandOnOzon\Layout::draw([
            'ozon_title' => $data['ozon_title'],
            'card_title' => $data['card_title'],
            'card_text' => $data['card_text'],
            'ozon_img' => $data['ozon_img'],
            'ozon_link' => $data['ozon_link'],
        ]);

        App\Layout\Components\Blocks\ForSellers\SellerBanner\Layout::draw([
            'banner_title' => $data['banner_title'],
            'banner_text' => $data['banner_text'],
        ]);

        App\Layout\Components\Blocks\ForSellers\FrequentQuestions\Layout::draw([
            'frequent_title' => $data['frequent_title'],
            'frequent_cards' => $data['frequent_cards'],
        ]);

        App\Layout\Components\Common\FaqSection\Layout::draw([
            'class_name' => 'for-sellers__faq',
            'faq-section_title' => $data['faq-section_title'],
            'faq-section_text' => $data['faq-section_text'],
        ]);
        ?>
    </div>
</main>

<?php
App\Layout\Components\Common\SeoSection\Layout::draw([
    'sellers_seo_title' => $data['sellers_seo_title'],
    'sellers_seo_text' => $data['sellers_seo_text'],
    'sellers_seo_title-s' => $data['sellers_seo_title-s'],
    'sellers_seo_text-s' => $data['sellers_seo_text-s'],
]); ?>

<?php
App\Layout\Components\Common\Footer\Layout::draw(); ?>

<?php
App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
<?php
App\Layout\Components\Modals\ModalQuestions\Layout::draw([
    'modal_questions_title' => $data['modal_questions_title'],
    'modal_questions_text' => $data['modal_questions_text'],
]); ?>
<?php
//App\Layout\Components\Modals\ModalConsultation\Layout::draw([
//    'consultation_title' => $data['consultation_title'],
//    'consultation_text' => $data['consultation_text'],
//    'consultation_text_policy' => $data['consultation_text_policy'],
//]); ?>

<?php
App\Layout\Components\Modals\ModalChecklist\Layout::draw([
    'checklist_title' => $data['checklist_title'],
    'checklist_text' => $data['checklist_text'],
    'checklist_title_fst' => $data['checklist_title_fst'],
    'checklist_title_s' => $data['checklist_title_s'],
    'checklist_title_t' => $data['checklist_title_t'],
    'checklist_title_frth' => $data['checklist_title_frth'],
    'checklist_title_fth' => $data['checklist_title_fth'],
    'checkboxes_fst' => $data['checkboxes_fst'],
    'checkboxes_s' => $data['checkboxes_s'],
    'checkboxes_t' => $data['checkboxes_t'],
    'checkboxes_frth' => $data['checkboxes_frth'],
    'checkboxes_fth' => $data['checkboxes_fth'],

]); ?>
<?php
App\Layout\Components\Modals\ModalError\Layout::draw([
    'error_title' => $data['error_title'],
    'error_text' => $data['error_text'],
]); ?>
<?php
App\Layout\Components\Modals\ModalErrorMobile\Layout::draw([
    'error_title_mobile' => $data['error_title_mobile'],
    'error_text_mobile' => $data['error_text_mobile'],
]); ?>
<?php
App\Layout\Components\Modals\ModalSuccess\Layout::draw([
    'success_title' => $data['success_title'],
    'success_text' => $data['success_text'],
]); ?>
<?php
App\Layout\Components\Modals\ModalSuccessMobile\Layout::draw([
    'success_title_mobile' => $data['success_title_mobile'],
    'success_text_mobile' => $data['success_text_mobile'],
]); ?>

<?php
App\Layout\Components\Modals\ModalSales\Layout::draw([
    'sales_title' =>  $data['sales_title'],
    'sales_text' =>  $data['sales_text'],
]); ?>
