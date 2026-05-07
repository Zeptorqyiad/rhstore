document.addEventListener('DOMContentLoaded', function () {
    const banner = document.querySelector(".faq-section");

    if (!banner) return;

    const img = banner.querySelector(".faq-section__parallax-img");

    addParallaxEffect(img, 25, 30);
});