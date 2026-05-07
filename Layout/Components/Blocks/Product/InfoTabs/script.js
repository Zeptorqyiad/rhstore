document.addEventListener("DOMContentLoaded", () => {
    const buttonsPanel = document.querySelector(".info-tabs__buttons");
    const tabContent = document.querySelectorAll(".info-tabs__item");
    const tabsButtons = buttonsPanel.querySelectorAll(".info-tabs__button");
    const aboutLinksContainer = document.querySelector('.about-product__container')
    const aboutLinks = aboutLinksContainer.querySelectorAll('.about-product__item-link')

    const hideTabs = () => {
        tabContent.forEach(item => item.style.display = "none");
        tabsButtons.forEach(button => button.classList.remove("info-tabs__button_active"));
    };

    const showTab = (i = 0) => {
        tabContent[i].style.display = "block";
        tabsButtons[i].classList.add("info-tabs__button_active");
    };

    hideTabs();
    showTab();

    buttonsPanel.addEventListener("click", (e) => {
        const target = e.target;

        if (target && target.classList.contains("info-tabs__button")) {
            tabsButtons.forEach((item, i) => {

                if (target === item || target.parentNode === item) {
                    hideTabs();
                    showTab(i);
                }
            });
        }
    });

    aboutLinksContainer.addEventListener("click", (e) => {
        const target = e.target;

        if (target && target.classList.contains("about-product__item-link")) {
            aboutLinks.forEach((item, i) => {

                if (target === item || target.parentNode === item) {
                    hideTabs();
                    showTab(i);
                }
            });
        }
    });

});