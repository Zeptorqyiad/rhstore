<?php
/** @var array $data */

?>

<?php
$onboardingSlides = [];
foreach ($data['onboarding_slides'] as $slide) {
    $onboardingSlides[] = [
        'title' => $slide['title'],
        'description' => $slide['description'],
        'imageDesktop' => $slide['image_desktop'],
        'imageMobile' => $slide['image_mobile'],
    ];
}

$onboardingSlidesJson = json_encode($onboardingSlides, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
?>


<?php if ($data['onboarding_slides']): ?>
<dialog class="onboarding" id="onboardingDialog">
    <div class="onboarding__wrapper">
        <?php
        App\Layout\UIKit\ButtonModalClose\Layout::draw([
                'class_name' => 'onboarding__button-close'
        ]); ?>

        <div class="onboarding__text">
            <h3 class="onboarding__title" id="slideTitle"></h3>
            <p class="onboarding__desc" id="slideDescription"></p>
        </div>

        <div class="onboarding__image">
            <img id="slideImage" src="" alt="" draggable="false">
        </div>

        <div class="onboarding__divider"></div>

        <div class="onboarding__bottom">
            <div class="onboarding__progress">
                <span class="onboarding__progress-step onboarding__progress-step_current">1</span>
                <div class="onboarding__progress-bar">
                    <div class="onboarding__progress-bar-meter"></div>
                </div>
                <span class="onboarding__progress-step onboarding__progress-step_final">6</span>
            </div>

            <div class="onboarding__buttons">
                <?php
                App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Пропустить',
                    'style' => 'transparent',
                    'class_name' => 'onboarding__button',
                    'id' => 'skipOnboardingButton',
                ]); ?>
                <?php
                App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Начать',
                    'style' => 'primary',
                    'class_name' => 'onboarding__button',
                    'id' => 'nextOnboardingButton'
                ]); ?>
            </div>

        </div>
    </div>
    <script>
        const onboardingSlides = <?php echo $onboardingSlidesJson; ?>;
    </script>
</dialog>
<?php endif; ?>
