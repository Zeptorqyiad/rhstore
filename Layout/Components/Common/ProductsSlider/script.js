document.addEventListener("DOMContentLoaded", () => {
    const sliders = document.querySelectorAll(".products-slider");

    sliders.forEach(sliderContainer => {
        const slider = sliderContainer.querySelector(".products-slider__slider");
        const prevButton = sliderContainer.querySelector(".products-slider__button-prev");
        const nextButton = sliderContainer.querySelector(".products-slider__button-next");

        if (!slider || !prevButton || !nextButton) return;

        new Swiper(slider, {
            loop: true,
            initialSlide: 0,

            navigation: {
                prevEl: prevButton,
                nextEl: nextButton,
            },

            breakpoints: {
                0: {
                    spaceBetween: 12,
                    slidesPerView: 2,
                },
                577: {
                    spaceBetween: 20,
                    slidesPerView: 6,
                },
                991: {
                    spaceBetween: 20,
                    slidesPerView: 6,
                },
                1401: {
                    spaceBetween: 20,
                    slidesPerView: 6,
                },
            },
        });
    });
});