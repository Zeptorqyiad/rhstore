document.addEventListener("DOMContentLoaded", function () {
    const modal = document.querySelector(".modal-city-mobile");
    const modalOpener = document.querySelector(".mobile-still__location");

    const modalButtonClose = document.querySelectorAll(".modal-city-mobile__icon");

    if (!modal || !modalOpener) return;

    const inputCity = modal.querySelector(".modal-city-mobile__text-field input");
    const yesButton = modal.querySelector(".modal-city-mobile__yes-button");
    const selectionButton = modal.querySelector(".modal-city-mobile__selections-button");
    const saveButton = modal.querySelector(".modal-city-mobile__save-button");

    const firstContent = modal.querySelector(".modal-city-mobile__first-content");
    const secondContent = modal.querySelector(".modal-city-mobile__second-content");

    saveButton.addEventListener('click', () => {
        if (!inputCity.value.trim()) {
            return;
        }

        location.href = location.href.split('?')[0] + '?_geo=' + inputCity.value.trim();
    });

    const showFirstContent = () => {
        firstContent.style.display = "flex";
        secondContent.style.display = "none";
    };

    const showSecondContent = () => {
        firstContent.style.display = "none";
        secondContent.style.display = "flex";
    };

    modalOpener.addEventListener("click", () => {
        showFirstContent();
        closeDropdown();
        modal.classList.toggle("open-modal");
    });

    modalButtonClose.forEach((button) =>{
        button.addEventListener("click", () => {
            modal.classList.remove("open-modal");
        })
    });

    yesButton.addEventListener("click", () => {
        modal.classList.remove("open-modal");
    });

    window.addEventListener("click", (e) => {
        const target = e.target;

        if (!modal.parentNode.contains(target)) {
            modal.classList.remove("open-modal");
        }
    });

    window.addEventListener("resize", () => {
        modal.classList.remove("open-modal");
    });

    selectionButton.addEventListener("click", () => {
        showSecondContent();
    });

    const modalDropdown = modal.querySelector(".modal-city-mobile__dropdown");
    const list = modal.querySelector(".modal-city-mobile__dropdown-list");

    const openDropdown = (event) => {
        modalDropdown.classList.add("modal-city-mobile__dropdown_active");
    };

    const closeDropdown = (event) => {
        modalDropdown.classList.remove("modal-city-mobile__dropdown_active");
    };

    async function searchCityHandler(ev) {
        if (ev.target.value.trim()) {
            openDropdown();
            api.search.city(ev.target.value.trim(), (data) => {
                list.innerHTML = '';
                data.items.forEach(e => {
                    list.innerHTML += `<li class="modal-city-mobile__dropdown-item">
                            ${e}
                        </li>`;
                });

                document.querySelectorAll('.modal-city-mobile__dropdown-item').forEach(e => {
                    e.addEventListener('click', () => {
                        inputCity.value = e.textContent.trim();
                        closeDropdown();
                    });
                });
            });
        } else {
            closeDropdown();
        }
    }

    //inputCity.addEventListener("focus", openDropdown);
    inputCity.addEventListener("input", searchCityHandler);
});
