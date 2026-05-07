<?php
/** @var array $data */

$phone = Simflex\Core\Core::siteParam('phone');

?>

<section class="promo-form wrapper">
    <div class="promo-form__content">
        <div class="promo-form__content-ls">
            <h2 class="promo-form__title">
                <?= $data['title'] ?>
            </h2>

            <div class="promo-form__social">
                <?php
                    App\Layout\Components\Common\Button\Layout::draw([
                        'phone-icon' => true,
                        'link' => 'tel:'.$phone,
                        'text' => 'Позвонить: '.$phone,
                        'style' => 'secondary',
                        'class_name' => 'promo-form__social--btn'
                    ]);

                    App\Layout\Components\Common\SocialNetwork\Layout::draw();
                ?>
            </div>

            <?php App\Layout\Components\Common\Separator\Layout::draw([
                'className' => 'light',
            ]); ?>

            <div class="promo-form__text">
                <?= $data['text'] ?>
            </div>

            <form class="modal-feedback__form" action="/form/" data-validate>
                <div class="modal-feedback__inputs">
                    <?php App\Layout\Components\Common\VariantTextField\Layout::draw([
                        'type' => 'tel',
                        'class_name' => 'modal-feedback__input',
//                        'placeholder' => 'Телефон*',
                        'name' => 'phone',
                        'id' => 'phone',
                        'required' => true,
                        'autocomplete' => 'tel',
                        'validate' => 'required|phone',
                    ]) ?>
                </div>

                <?php App\Layout\UIKit\CheckboxPolicy\Layout::draw([
                    'checked' => false,
                    'required' => true,
                    'validate' => 'required|checkbox',
                ]); ?>

                <?php App\Layout\Components\Common\Button\Layout::draw([
                    'text' => $data['button-text'] ?: 'Отправить',
                    'style' => 'primary',
                    'class_name' => 'modal-feedback__button',
                    'type' => 'submit',
                ]); ?>
            </form>
        </div>

        <div class="promo-form__content-rs">
            <div class="promo-form__content-rs--question">
                <img src="/assets/images/Promo/question.png" alt="">
            </div>

            <div class="promo-form__content-rs--warm">
                <svg xmlns="http://www.w3.org/2000/svg" width="613" height="522" viewBox="0 0 613 522" fill="none">
                    <path d="M155.958 804.09C145.744 800.457 134.802 804.992 131.519 814.221L0 767.436C26.6266 692.584 115.375 655.797 198.226 685.27L471.539 782.494C481.753 786.128 492.695 781.593 495.978 772.365C499.261 763.136 493.641 752.709 483.427 749.076L210.114 651.851C127.263 622.379 81.6846 537.808 108.312 462.956C134.938 388.106 223.686 351.32 306.537 380.792L579.85 478.017C590.064 481.65 601.007 477.113 604.289 467.886C607.572 458.659 601.952 448.231 591.738 444.597L318.425 347.372C235.575 317.9 189.996 233.33 216.622 158.48C243.249 83.6263 331.998 46.84 414.849 76.3122L688.162 173.537C698.376 177.17 709.317 172.637 712.601 163.407C715.883 154.179 710.264 143.751 700.05 140.118L426.737 42.8928C343.886 13.4207 298.307 -71.1495 324.934 -146L456.453 -99.2147C453.171 -89.9876 458.79 -79.5592 469.004 -75.9258L742.317 21.299C825.167 50.7709 870.746 135.341 844.12 210.191C817.493 285.045 728.743 321.831 645.894 292.359L372.58 195.134C362.367 191.501 351.425 196.034 348.141 205.265C344.859 214.492 350.478 224.92 360.692 228.554L634.005 325.779C716.855 355.25 762.435 439.821 735.809 514.671C709.182 589.521 620.433 626.307 537.583 596.835L264.27 499.61C254.056 495.977 243.113 500.514 239.831 509.741C236.547 518.971 242.168 529.396 252.382 533.03L525.695 630.255C608.545 659.727 654.124 744.298 627.497 819.15C600.871 894.001 512.121 930.787 429.271 901.315L155.958 804.09Z" fill="#FFABAB"/>
                </svg>
            </div>
        </div>
    </div>

    <div class="promo-form__bubble">
        <img src="/assets/images/Promo/bubble.png" alt="">
    </div>
</section>