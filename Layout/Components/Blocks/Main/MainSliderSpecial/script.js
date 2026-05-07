document.addEventListener("DOMContentLoaded", () => {
    const newsSlider = document.querySelector(".main-slider-special__slider");

    if (!newsSlider) return;

    new Swiper(newsSlider, {
        loop: true,
        initialSlide: 0,
        autoplay: {
            delay: 3000,
        },

        navigation: {
            prevEl: '.main-slider-special__button-prev',
            nextEl: '.main-slider-special__button-next',
        },

        breakpoints: {
            0: {
                spaceBetween: 12,
                slidesPerView: 1.31,
            },
            577: {
                spaceBetween: 20,
                slidesPerView: 4,
            },
            991: {
                spaceBetween: 20,
                slidesPerView: 4.27,
            },
            1401: {
                spaceBetween: 20,
                slidesPerView: 5.4,
            },
        },
    });

});