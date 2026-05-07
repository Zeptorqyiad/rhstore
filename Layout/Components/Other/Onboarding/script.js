const dialog = document.getElementById('onboardingDialog');
const slideTitle = document.getElementById('slideTitle');
const slideDescription = document.getElementById('slideDescription');
const slideImage = document.getElementById('slideImage');
const progressBar = document.querySelector('.onboarding__progress-bar-meter');
const currentStep = document.querySelector('.onboarding__progress-step_current');
const finalStep = document.querySelector('.onboarding__progress-step_final');
const skipButton = document.getElementById('skipOnboardingButton');
const closeButton = document.querySelector('.onboarding__button-close');
const nextButton = document.getElementById('nextOnboardingButton');
const nextButtonText = nextButton.querySelector('span');

let currentSlide = 0;

finalStep.textContent = onboardingSlides.length;

function updateSlideImage() {
    if (window.innerWidth < 577) {
        slideImage.src = onboardingSlides[currentSlide].imageMobile;
    } else {
        slideImage.src = onboardingSlides[currentSlide].imageDesktop;
    }
}

window.addEventListener('resize', updateSlideImage);

function updateSlide() {
    const slide = onboardingSlides[currentSlide];
    slideTitle.textContent = slide.title;
    slideDescription.textContent = slide.description;

    updateSlideImage();

    const progress = ((currentSlide + 1) / onboardingSlides.length) * 100;
    progressBar.style.width = `${progress}%`;

    currentStep.textContent = currentSlide + 1;

    if (currentSlide === onboardingSlides.length - 1) {
        nextButtonText.textContent = 'Завершить';
    } else {
        nextButtonText.textContent = currentSlide === 0 ? 'Начать' : 'Далее';
    }

    if (currentSlide !== 0) {
        skipButton.classList.add('hidden');
    } else {
        skipButton.classList.remove('hidden');
    }
}

function nextSlide() {
    if (currentSlide < onboardingSlides.length - 1) {
        currentSlide++;
        updateSlide();
    } else {
        completeOnboarding();
    }
}

function skipOnboarding() {
    completeOnboarding();
}

function completeOnboarding() {
    localStorage.setItem('onboardingCompleted', 'true');
    dialog.close();
}

function checkOnboardingStatus() {
    return localStorage.getItem('onboardingCompleted') === 'true';
}

nextButton.addEventListener('click', nextSlide);
skipButton.addEventListener('click', skipOnboarding);
closeButton.addEventListener('click', skipOnboarding);

updateSlide();

window.addEventListener('load', () => {
    const onboardingModal = document.querySelector('.onboarding');

    if (!checkOnboardingStatus()) {
        onboardingModal.showModal();
    }
});