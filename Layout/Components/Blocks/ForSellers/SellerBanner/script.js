document.addEventListener("DOMContentLoaded", function () {
    const banner = document.querySelector(".seller-banner");

    if (!banner) return;

    const img = banner.querySelector(".seller-banner__parallax-img");
    const firstDollar = banner.querySelector(".seller-banner__dollar-1");
    const secondDollar = banner.querySelector(".seller-banner__dollar-2");

    addParallaxEffect(img, 25, 30);
    addReverseParallaxEffect(firstDollar, 10, 10);
    addReverseParallaxEffect(secondDollar, 10, 5);
});
