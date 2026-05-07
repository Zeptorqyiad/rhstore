document.addEventListener("DOMContentLoaded", () => {
    const newsSlider = document.querySelector(".about-us-slider__slider");

    if (!newsSlider) return;

    new Swiper(newsSlider, {
        loop: true,
        initialSlide: 0,

        navigation: {
            prevEl: ".about-us-slider__button-prev",
            nextEl: ".about-us-slider__button-next",
        },

        breakpoints: {
            0: {
                spaceBetween: 12,
                slidesPerView: 1.12,
            },
            577: {
                spaceBetween: 20,
                slidesPerView: 2,
            },
            991: {
                spaceBetween: 20,
                slidesPerView: 2,
            },
            1401: {
                spaceBetween: 20,
                slidesPerView: 2,
            },
        },
    });

    const initVideo = () => {
        const slides = newsSlider.querySelectorAll(".about-us-slider__slide");

        slides.forEach(slide => {
            const button = slide.querySelector(".about-us-slider__video-play");
            const video = slide.querySelector("video");

            const playVideo = () => {
                if (video.paused) {
                    slide.classList.add("about-us-slider__slide_play");
                    video.controls = true;
                    video.play();
                }
            };

            const stopVideo = () => {
                if (!video.paused) {
                    slide.classList.remove("about-us-slider__slide_play");
                    video.controls = false;
                    video.pause();
                }
            };

            const endVideo = () => {
                slide.classList.remove("about-us-slider__slide_play");
                video.controls = false;
                video.pause();
                video.currentTime = 0;
            };

            button.addEventListener("click", playVideo);
            video.addEventListener("click", stopVideo);
            video.addEventListener("touchend", stopVideo);
            video.addEventListener("ended", endVideo);
        });
    };

    initVideo();
});
