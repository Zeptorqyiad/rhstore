document.addEventListener("DOMContentLoaded", () => {
    const secondarySwiper = new Swiper(".product-slider__secondary-slider", {
        freeMode: true,
        loop: true,


        breakpoints: {
            0: {
                slidesPerView: 1,
            },
            577: {
                slidesPerView: 5,
            },
            991: {
                slidesPerView: 5,
            },
            1401: {
                slidesPerView: 5,
            },
        },
    });


    const mainSwiper = new Swiper(".product-slider__main-slider", {
        navigation: {
            nextEl: '.product-slider__button-next',
        },
        loop: true,

        breakpoints: {
            0: {
                spaceBetween: 12,
                slidesPerView: 1.16,
            },
            577: {
                slidesPerView: 1,
            },
            991: {
                slidesPerView: 1,
            },
            1401: {
                slidesPerView: 1,
            },
        },

        spaceBetween: 10,
        simulateTouch: true,
        thumbs: {
            swiper: secondarySwiper,
        },
    });
});
