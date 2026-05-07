document.addEventListener("DOMContentLoaded", () => {
    const banner = document.querySelector(".main-banner");

    if (!banner) return;

    const firstBox = banner.querySelector(".main-banner__box-first");
    const secondBox = banner.querySelector(".main-banner__box-second");
    const thirdBox = banner.querySelector(".main-banner__box-third");
    const phone = banner.querySelector(".main-banner__phone");

    addReverseParallaxEffect(firstBox, 10, 10);
    addParallaxEffect(secondBox, 5, 10);
    addReverseParallaxEffect(thirdBox, 10, 5);
    addParallaxEffect(phone, 25, 30);
});
