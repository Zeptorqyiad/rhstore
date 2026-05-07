<dialog class="cookie" id="cookie">
    <div class="cookie__container">
        <div class="cookie__text">
            <h3 class="cookie__title">Сайт использует Cookie</h3>

            <div class="cookie__description">
                Мы используем файлы cookie и сторонние сервисы (Yandex.Metrica и AppMetrica) для анализа трафика, персонализации контента и улучшения сайта.
                Подробнее см.
                <a class="cookie__description--link" href="/policy/"> в Политике обработки персональных данных </a>
            </div>

            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Принимаю',
                'style' => 'secondary',
                'class_name' => 'cookie__button js--cookie__button'
            ]); ?>
        </div>
    </div>
    <?php App\Layout\UIKit\ButtonModalClose\Layout::draw(); ?>
</dialog>