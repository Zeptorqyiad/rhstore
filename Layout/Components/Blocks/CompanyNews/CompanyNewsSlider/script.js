document.addEventListener("DOMContentLoaded", () => {
    const newsSlider = document.querySelector(".company-news-slider__slider");

    if (!newsSlider) return;

    new Swiper(newsSlider, {
        slidesPerView: 1,
        loop: true,
        initialSlide: 0,
        autoplay: true,

        navigation: {
            prevEl: '.company-news-slider__button-prev',
            nextEl: '.company-news-slider__button-next',
        },

        breakpoints: {
            0: {
                spaceBetween: 0,
                slidesPerView: 1,
            },
            577: {
                spaceBetween: 0,
                slidesPerView:1,
            },
            991: {
                spaceBetween: 0,
                slidesPerView: 1,
            },
            1401: {
                spaceBetween: 0,
                slidesPerView: 1,
            },
        },
    });

});