<?php
/** @var array $data */

?>

<?php
//App\Layout\Components\Common\RunningLine\Layout::draw();
App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

<main class="payment">
    <?php
    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
        'class_name' => 'payment__breadcrumbs wrapper',
        'text' => 'Оплата'
    ]);

    App\Layout\Components\Common\HelpNavigation\Layout::draw([
        'class_name' => 'payment__nav',
        'active_nav' => '1'
    ]);

    \App\Layout\Components\InformationBlocks\Payment\PaymentContent\Layout::draw([
        'class_name' => 'payment__content',
        'payment_title' => $data['payment_title'],
        'payment_subtitle_f' => $data['payment_subtitle_f'],
        'payment_text_f' => $data['payment_text_f'],
        'payment_req_title' => $data['payment_req_title'],
        'reqs' => $data['reqs'],
        'payment_subtitle_s' => $data['payment_subtitle_s'],
        'payment_text_s' => $data['payment_text_s'],

    ]);
    ?>
</main>

<?php
App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php
App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw(); ?>
