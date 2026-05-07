document.addEventListener("DOMContentLoaded", () => {
    const banner = document.querySelector(".about-us-banner");

    if (!banner) return;

    const hand = banner.querySelector(".about-us-banner__parallax-img");

    addParallaxEffect(hand, 30, 20);
});
