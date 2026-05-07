<?php
/** @var array $data */
?>

<section class="<?= $data["class_name"] ?> main-info">
    <ul class="main-info__container wrapper">
        <li class="main-info__card">
            <h3 class="main-info__card-title">
                Есть вопросы или нужна поддержка?
            </h3>
            <p class="main-info__card-text">
                Вы можете поискать ответы на ваши вопросы в разделе «Частые вопросы» или связаться с нами
            </p>

            <div class="main-info__card-buttons">
                <a href="#" class="main-info__card-button-link">
                    <?php App\Layout\Components\Common\Button\Layout::draw([
                        'text' => 'Частые вопросы',
                        'style' => 'secondary',
                        'class_name' => 'main-info__card-button',
                        'link' => '/questions/',
                    ]); ?>
                </a>
                <a href="/contacts/" class="main-info__card-button-link">
                    <?php App\Layout\Components\Common\Button\Layout::draw([
                        'text' => 'Контакты',
                        'style' => 'secondary',
                        'class_name' => 'main-info__card-button'
                    ]); ?>
                </a>
            </div>
        </li>

        <li class="main-info__card">
            <h3 class="main-info__card-title">Доставка и оплата</h3>
            <p class="main-info__card-text">
                Информация об оплате и доставке товара
            </p>
            <a href="#" class="main-info__card-button-link">
                <?php App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Открыть',
                    'style' => 'secondary',
                    'class_name' => 'main-info__card-button main-info__card-button-icon',
                    'icon' => true,
                    'link' => '/delivery/',
                ]); ?>
            </a>
        </li>

        <li class="main-info__card">
            <h3 class="main-info__card-title">Обмен и возврат</h3>
            <p class="main-info__card-text">
                Информация о гарантии и условиях возврата
            </p>
            <a href="#" class="main-info__card-button-link">
                <?php App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Открыть',
                    'style' => 'secondary',
                    'class_name' => 'main-info__card-button main-info__card-button-icon',
                    'icon' => true,
                    'link' => '/refund/',
                ]); ?>
            </a>
        </li>
    </ul>
</section>