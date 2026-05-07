document.addEventListener("DOMContentLoaded", function () {
    const banner = document.querySelector(".promo-form");

    if (!banner) return;

    const question = banner.querySelector(".promo-form__content-rs--question");
    const bubble = banner.querySelector(".promo-form__bubble");

    addReverseParallaxEffect(question, -20, -20);
    addReverseParallaxEffect(bubble, 20, 15);
});
