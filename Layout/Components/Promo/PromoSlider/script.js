document.addEventListener("DOMContentLoaded", () => {
    const newsSlider = document.querySelector(".promo-slider__slider");

    if (!newsSlider) return;

    if (new Swiper) {
        new Swiper(newsSlider, {
            slidesPerView: 4,
            loop: true,
            initialSlide: 0,

            navigation: {
                prevEl: '.promo-slider__button-prev',
                nextEl: '.promo-slider__button-next',
            },

            breakpoints: {
                0: {
                    spaceBetween: 12,
                    slidesPerView: 1,
                },
                577: {
                    spaceBetween: 20,
                    slidesPerView: 4,
                },
                991: {
                    spaceBetween: 20,
                    slidesPerView: 4,
                },
                1401: {
                    spaceBetween: 20,
                    slidesPerView: 4,
                },
            },
        });
    }
});