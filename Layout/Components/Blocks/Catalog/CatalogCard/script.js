document.addEventListener("DOMContentLoaded", function () {
    const addHoverEffect = () => {
        const cards = document.querySelectorAll(".catalog-card");

        cards.forEach(card => {
            const image = card.querySelector(".catalog-card__image");
            const title = card.querySelector(".catalog-card__product-name");

            image.addEventListener("mouseenter", () => {
                title.style.color = "#FF3838";
            });

            image.addEventListener("mousedown", () => {
                title.style.color = "#D93030";
            });

            image.addEventListener("mouseleave", (e) => {
                title.style.color = "";
            });


            title.addEventListener("mouseenter", () => {
                image.style.filter = "brightness(80%)";
            });

            title.addEventListener("mousedown", () => {
                image.style.filter = "brightness(90%)";
            });

            title.addEventListener("mouseleave", (e) => {
                image.style.filter = "";
            });
        });
    };

    addHoverEffect();
});
