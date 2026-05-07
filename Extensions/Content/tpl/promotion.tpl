<?php
/** @var array $content */

App\Layout\Components\HeaderBlock\Header\Layout::draw();

$advantages = $this->promotion->advantages_items;
?>

<main>
    <?php
        App\Layout\Components\Common\BreadCrumbs\Layout::draw([
            'class_name' => 'wrapper',
        ]);

        $sections = [];
        $sectionIndex = 0;
        $addSection = function ($npp, $render) use (&$sections, &$sectionIndex) {
            $sections[] = [
                'npp' => $npp,
                'idx' => $sectionIndex++,
                'render' => $render,
            ];
        };

        $addSection($this->promotion->banner_npp, function () {
            App\Layout\Components\Promo\PromoBanner\Layout::draw([
                'image' => $this->promotion->photo,
                'title' => $this->promotion->banner_title,
                'title-accent' => $this->promotion->banner_title_accent,
                'title-third' => $this->promotion->banner_title_third,
                'date' => $this->promotion->date,
                'badge' => $this->promotion->badge,
                'offer-title' => $this->promotion->banner_offer_title,
                'offer-text' => $this->promotion->banner_offer_text,
                'items' => $this->promotion->banner_items,
                'price' => $this->promotion->banner_price,
                'price-throught' => $this->promotion->banner_price_throught,
                'button-text' => $this->promotion->banner_button_text,
                'npp' => $this->promotion->banner_npp
            ]);
        });

        $addSection($this->promotion->numbers_npp, function () {
            App\Layout\Components\Promo\PromoNumbers\Layout::draw([
                'items' => $this->promotion->numbers_items,
                'npp' => $this->promotion->numbers_npp
            ]);
        });

        $addSection($this->promotion->info_npp, function () {
            App\Layout\Components\Promo\PromoInfo\Layout::draw([
                'title' => $this->promotion->info_title,
                'text' => $this->promotion->info_text,
                'consist-title' => $this->promotion->info_consist_title,
                'consist-text' => $this->promotion->info_consist_text,
                'image' => $this->promotion->info_image,
                'npp' => $this->promotion->info_npp
            ]);
        });

        $addSection($this->promotion->consists_npp, function () {
            App\Layout\Components\Promo\PromoConsists\Layout::draw([
                'title' => $this->promotion->consists_title,
                'items' => $this->promotion->consists_items,
                'npp' => $this->promotion->consists_npp
            ]);
        });

        $addSection($this->promotion->stages_npp, function () {
            App\Layout\Components\Promo\PromoStages\Layout::draw([
                'title' => $this->promotion->stages_title,
                'image' => $this->promotion->stages_image,
                'items' => $this->promotion->stages_items,
                'button-text' => $this->promotion->stages_button_text,
                'npp' => $this->promotion->stages_npp
            ]);
        });

        if ($this->promotion->callback_title) {
            $addSection($this->promotion->callback_npp, function () {
                App\Layout\Components\Promo\PromoCallback\Layout::draw([
                    'title' => $this->promotion->callback_title,
                    'text' => $this->promotion->callback_text,
                    'button-text' => $this->promotion->callback_button_text,
                    'tg-link' => $this->promotion->callback_tg_link,
                    'tg-button-text' => $this->promotion->callback_tg_button_text,
                    'npp' => $this->promotion->callback_npp
                ]);
            });
        }

        $addSection($this->promotion->sales_npp, function () {
            App\Layout\Components\Promo\PromoSales\Layout::draw([
                'title' => $this->promotion->sales_title,
                'card1-title' => $this->promotion->sales_card1_title,
                'card1-text' => $this->promotion->sales_card1_text,
                'card1-image' => $this->promotion->sales_card1_image,
                'card2-title' => $this->promotion->sales_card2_title,
                'card2-text' => $this->promotion->sales_card2_text,
                'card2-image' => $this->promotion->sales_card2_image,
                'npp' => $this->promotion->sales_npp
            ]);
        });

        $addSection($this->promotion->adv_npp, function () {
            App\Layout\Components\Promo\PromoAdvantages\Layout::draw([
                'title' => $this->promotion->adv_title,
                'items' => $this->promotion->adv_items,
                'npp' => $this->promotion->adv_npp
            ]);
        });

        $addSection($this->promotion->promo_slider_npp, function () {
            App\Layout\Components\Promo\PromoSlider\Layout::draw([
                'npp' => $this->promotion->promo_slider_npp
            ]);
        });

        if ($this->promotion->about_title) {
            $addSection($this->promotion->about_npp, function () {
                App\Layout\Components\Blocks\AboutUs\AboutUsApproach\Layout::draw([
                    'class_name' => 'promo-about',
                    'approach_title' => $this->promotion->about_title,
                    'approach_description_f' => $this->promotion->about_desc_f ,
                    'approach_description_s' => $this->promotion->about_desc_s ,
                    'approach__f-top' => $this->promotion->about_first_top,
                    'approach__f-middle' => $this->promotion->about_first_middle,
                    'approach__f-bottom' => $this->promotion->about_first_bottom,
                    'approach__s-top' => $this->promotion->about_sec_top,
                    'approach__s-middle' => $this->promotion->about_sec_middle,
                    'approach__s-bottom' => $this->promotion->about_sec_bottom,
                    'approach__t-top' => $this->promotion->about_third_top,
                    'approach__t-middle' => $this->promotion->about_third_middle,
                    'approach__t-bottom' => $this->promotion->about_third_bottom,
                    'f_slide_right' => '/uf/images/source/'.$this->promotion->about_slide_f_right,
                    'f_slide_left' => '/uf/images/source/'.$this->promotion->about_slide_s_left,
                    'approach_img' => '/uf/images/source/'.$this->promotion->about_approach_img,
                    'npp' => $this->promotion->about_npp
                ]);
            });
        }

        $addSection($this->promotion->advantages_npp, function () use ($advantages) {
            App\Layout\Components\Common\Advantages\Layout::draw([
                'class_name' => 'promo__advantages',
                'advantages_title' => $this->promotion->advantages_title,
                'advantages' => json_decode($advantages, true)['v'] ?? [],
                'npp' => $this->promotion->advantages_npp
            ]);
        });

        $addSection($this->promotion->form_npp, function () {
            App\Layout\Components\Promo\PromoForm\Layout::draw([
                'title' => $this->promotion->form_title,
                'text' => $this->promotion->form_text,
                'button-text' => $this->promotion->form_button_text,
                'npp' => $this->promotion->form_npp
            ]);
        });

        $addSection($this->promotion->faq_npp, function () {
            App\Layout\Components\Promo\PromoFAQ\Layout::draw([
                'title' => $this->promotion->faq_title,
                'text' => $this->promotion->faq_text,
                'items' => $this->promotion->faq_items,
                'npp' => $this->promotion->faq_npp
            ]);
        });

        $addSection(null, function () {
            App\Layout\Components\Common\SeoSection\Layout::draw([
                'seo_title_1' => $this->promotion->seo_title1,
                'seo_text_1' => $this->promotion->seo_text1,
                'seo_title_2' => $this->promotion->seo_title2,
                'seo_text_2' => $this->promotion->seo_text2,
            ]);
        });

        usort($sections, function ($a, $b) {
            $aNpp = is_numeric($a['npp']) ? (int) $a['npp'] : PHP_INT_MAX;
            $bNpp = is_numeric($b['npp']) ? (int) $b['npp'] : PHP_INT_MAX;
            if ($aNpp === $bNpp) {
                return $a['idx'] <=> $b['idx'];
            }
            return $aNpp <=> $bNpp;
        });

        foreach ($sections as $section) {
            $render = $section['render'];
            $render();
        }
    ?>
</main>

<?php
App\Layout\Components\Common\Footer\Layout::draw();

App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw([
    'active_nav' => '1'
]);
?>
