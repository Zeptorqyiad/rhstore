document.addEventListener("DOMContentLoaded", function () {
    const badges = document.querySelectorAll(".catalog-badge");

    badges.forEach(badge => {
        const text = badge.querySelector(".catalog-badge__text");

        if (text.children.length === 2) {
            text.children[1].style.display = "none";
        }
    });
});
