document.addEventListener("DOMContentLoaded", function () {
    const menu = document.querySelector(".mobile-menu");
    const modals = document.querySelectorAll(".mobile-catalog, .mobile-account, .mobile-still");
    const otherModals = document.querySelectorAll(".modal");
    const tabs = menu.querySelectorAll("li");
    const runningLine = document.querySelector(".running-line");

    const openModal = (modal) => modal.classList.add("open-mobile-modal");
    const closeModal = (modal) => modal.classList.remove("open-mobile-modal");
    const addActiveClass = (element) => element.classList.add("mobile-menu__item_active");
    const removeActiveClass = (element) => element.classList.remove("mobile-menu__item_active");
    const lockScroll = () => document.body.classList.add("scroll-lock");
    const returnScroll = () => document.body.classList.remove("scroll-lock");

    const closeTabsAndModals = () => {
        tabs.forEach(item => item.classList.remove("mobile-menu__item_active"));
        modals.forEach(modal => closeModal(modal));
        returnScroll();
        showRunningLine();
    };

    const toggleModal = (modal, index, item) => {
        otherModals.forEach(modal => modal.classList.remove("open-modal"));

        if (modals[index].classList.contains("open-mobile-modal")) {
            closeModal(modals[index]);
            removeActiveClass(item);
            // returnScroll();
            showRunningLine();
        } else {
            closeTabsAndModals();
            addActiveClass(item);
            openModal(modals[index]);
            // lockScroll();
            hideRunningLine();
        }
    };

    const hideRunningLine = () => {
        if (runningLine) {
            runningLine.style.height = 0;
        }
    };

    const showRunningLine = () => {
        if (runningLine) {
            runningLine.style.height = "";
        }
    };

    menu.addEventListener("click", (e) => {
        const target = e.target;
        const itemCatalog = target.closest(".mobile-menu__item-catalog");
        const itemAccount = target.closest(".mobile-menu__item-account");
        const itemStill = target.closest(".mobile-menu__item-still");

        if (itemCatalog) {
            toggleModal(modals[0], 0, itemCatalog);
        }

        if (itemAccount) {
            toggleModal(modals[1], 1, itemAccount);
        }

        if (itemStill) {
            toggleModal(modals[2], 2, itemStill);
        }
    });

    window.addEventListener("resize", () => {
        //closeTabsAndModals();


    });

    modals.forEach(modal => {
        const closeButton = modal.querySelector(".mobile-modal__close");

        closeButton?.addEventListener("click", closeTabsAndModals);
        returnScroll();
    });
});
