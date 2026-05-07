document.addEventListener("DOMContentLoaded", function () {
    const banner = document.querySelector(".promo-callback");

    if (!banner) return;

    const img = banner.querySelector(".promo-callback__parallax-img");
    const firstDollar = banner.querySelector(".promo-callback__dollar-1");
    const secondDollar = banner.querySelector(".promo-callback__dollar-2");

    addParallaxEffect(img, 25, 30);
    addReverseParallaxEffect(firstDollar, 10, 10);
    addReverseParallaxEffect(secondDollar, 10, 5);
});
