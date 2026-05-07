document.addEventListener('DOMContentLoaded', function () {
    const banner = document.querySelector(".brands-banner");

    if (!banner) return;

    const img = banner.querySelector(".brands-banner__parallax");

    addParallaxEffect(img, 25, 30);
});
