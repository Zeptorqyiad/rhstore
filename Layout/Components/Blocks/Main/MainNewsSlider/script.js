document.addEventListener("DOMContentLoaded", () => {
    const newsSlider = document.querySelector(".main-news-slider__slider");

    if (!newsSlider) return;

    if (new Swiper) {
        new Swiper(newsSlider, {
            slidesPerView: 3,
            loop: true,
            initialSlide: 0,

            navigation: {
                prevEl: '.main-news-slider__button-prev',
                nextEl: '.main-news-slider__button-next',
            },

            breakpoints: {
                0: {
                    spaceBetween: 12,
                    slidesPerView: 1,
                },
                577: {
                    spaceBetween: 20,
                    slidesPerView: 3,
                },
                991: {
                    spaceBetween: 20,
                    slidesPerView: 3,
                },
                1401: {
                    spaceBetween: 20,
                    slidesPerView: 3,
                },
            },
        });
    }
});