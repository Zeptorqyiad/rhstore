document.addEventListener("DOMContentLoaded", () => {
    const firstSlider = document.querySelector(".about-us-approach__f-slider");
    const secondSlider = document.querySelector(".about-us-approach__slider");

    if (!secondSlider || !firstSlider) return;

    new Swiper(firstSlider, {
        slidesPerView: 1,
        autoplay: {
            delay: 5000,
            disableOnInteraction: false,
        },
    });

    new Swiper(secondSlider, {
        slidesPerView: 1,
        spaceBetween: 0,
        autoplay: {
            delay: 3000,
            disableOnInteraction: false,
        },
    });

});
