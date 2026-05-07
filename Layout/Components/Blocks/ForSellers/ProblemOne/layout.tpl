<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> problem-one">
    <div class="wrapper">
        <?php \App\Layout\Components\Blocks\ForSellers\ProblemBadge\Layout::draw([
            'class_name' => 'problem-one__badge',
            'text' => 'Проблема 1 из 4'
        ]); ?>

        <h2 class="problem-one__title"><?= $data["problem_one_title"] ?></h2>

        <div class="problem-one__container">
            <div class="problem-one__column">
                <div class="problem-one__column-top">
                    <div class="problem-one__card-badge">
                        <?= $data["one_top_title"] ?>
                    </div>
                    <p class="problem-one__card-text">
                        <?= $data["one_top_text"] ?>
                    </p>
                </div>

                <div class="problem-one__column-bottom">
                    <div class="problem-one__card-decision">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                            <path d="M3.5 8H16M16 8V20.5M16 8L20.5 3.5M21 15.3373V3.8C21 3.51997 21 3.37996 20.9455 3.273C20.8976 3.17892 20.8211 3.10243 20.727 3.0545C20.62 3 20.48 3 20.2 3H8.66274C8.41815 3 8.29586 3 8.18077 3.02763C8.07873 3.05213 7.98119 3.09253 7.89172 3.14736C7.7908 3.2092 7.70432 3.29568 7.53137 3.46863L3.46863 7.53137C3.29568 7.70432 3.2092 7.7908 3.14736 7.89172C3.09253 7.98119 3.05213 8.07873 3.02763 8.18077C3 8.29586 3 8.41815 3 8.66274V20.2C3 20.48 3 20.62 3.0545 20.727C3.10243 20.8211 3.17892 20.8976 3.273 20.9455C3.37996 21 3.51997 21 3.8 21H15.3373C15.5818 21 15.7041 21 15.8192 20.9724C15.9213 20.9479 16.0188 20.9075 16.1083 20.8526C16.2092 20.7908 16.2957 20.7043 16.4686 20.5314L20.5314 16.4686C20.7043 16.2957 20.7908 16.2092 20.8526 16.1083C20.9075 16.0188 20.9479 15.9213 20.9724 15.8192C21 15.7041 21 15.5818 21 15.3373Z"
                                  stroke="#0D0D0D" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span><?= $data["one_bottom_title"] ?></span>
                    </div>
                    <p class="problem-one__card-bottom-text">
                        <?= $data["one_bottom_text"] ?>
                    </p>

<!--                    <a href="/catalog/" class="problem-one__button-link">-->
<!--                        --><?php //App\Layout\Components\Common\Button\Layout::draw([
//                            'text' => 'В каталог',
//                            'style' => 'secondary',
//                            'class_name' => 'problem-one__button'
//                        ]); ?>
<!--                    </a>-->
                </div>

            </div>
            <div class="problem-one__image">
                <img src="<?= $data["problem_one_img"] ?>" alt="screenshot">
            </div>
        </div>
    </div>
</section>
