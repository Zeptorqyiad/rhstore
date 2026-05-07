<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> become-seller">
    <div class="wrapper">
        <h2 class="become-seller__title"><?= $data["become_title"] ?></h2>

        <div class="become-seller__container">
            <div class="become-seller__cards">
                <div class="become-seller__first-card">
                    <p class="become-seller__text">
                        <?= $data["become_text_f"] ?>
                    </p>
                </div>
                <div class="become-seller__second-card">
                    <p class="become-seller__text">
                        <?= $data["become_text_s"] ?>
                    </p>
                    <?php
                    App\Layout\Components\Common\Button\Layout::draw([
                        'text' => 'Написать',
                        'style' => 'secondary',
                        'class_name' => 'become-seller__button',
                        'modal' => 'modalPromo',
                    ]);
                    ?>
                </div>
            </div>
            <div class="become-seller__image">
                <img src=" <?= $data["become_img"] ?>" alt="man">
            </div>

        </div>
    </div>
</section>
