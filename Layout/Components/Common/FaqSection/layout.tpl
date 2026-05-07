<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> faq-section">
    <div class="faq-section__container wrapper">
        <div class="faq-section__parallax">
            <img src="/assets/images/main/faq-section/faq_3d.png"
                 alt="3d" class="faq-section__parallax-img">
        </div>
        <div class="faq-section__parallax-mobile">
            <img src="/assets/images/main/faq-section/faq_3d_m.png"
                 alt="bg" class="faq-section__parallax-img-mobile">
        </div>

        <div class="faq-section__wrapper">

            <div class="faq-section__block">
                <h2 class="faq-section__title">
                    <?= $data["faq-section_title"] ?? 'Остались вопросы?' ?>
                </h2>
                <p class="faq-section__text">
                    <?= $data["faq-section_text"] ?? 'Оставьте заявку на обратную связь и мы вам перезвоним как можно скорее' ?>
                </p>

                <?php
                App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Связаться со мной',
                    'style' => 'secondary',
                    'class_name' => 'faq-section__button',
                    'modal' => 'modalPromo',
                ]);
                ?>

            </div>
        </div>
    </div>
</section>

<?php App\Layout\Components\Modals\ModalFeedback\Layout::draw([
    'class_name' => 'mailing-feedback__modal',
]); ?>