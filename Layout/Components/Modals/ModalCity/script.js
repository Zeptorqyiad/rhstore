document.addEventListener("DOMContentLoaded", function () {
    const modal = document.querySelector(".modal-city");
    const modalOpener = document.querySelector(".header__location");

    if (!modal || !modalOpener) return;

    const inputCity = modal.querySelector(".modal-city__text-field input");
    const yesButton = modal.querySelector(".modal-city__yes-button");
    const selectionButton = modal.querySelector(".modal-city__selections-button");
    const saveButton = modal.querySelector(".modal-city__save-button");

    const firstContent = modal.querySelector(".modal-city__first-content");
    const secondContent = modal.querySelector(".modal-city__second-content");

    saveButton.disabled = true;
    saveButton.classList.add('submit-disabled');

    let dropdownItems = [];

    const showFirstContent = () => {
        firstContent.style.display = "block";
        secondContent.style.display = "none";
    };

    const showSecondContent = () => {
        firstContent.style.display = "none";
        secondContent.style.display = "block";
    };

    modalOpener.addEventListener("click", () => {
        showFirstContent();
        closeDropdown();
        modal.classList.toggle("open-modal");
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

    const modalDropdown = modal.querySelector(".modal-city__dropdown");
    const list = modal.querySelector(".modal-city__dropdown-list");

    const openDropdown = () => {
        modalDropdown.classList.add("modal-city__dropdown_active");
    };

    const closeDropdown = () => {
        modalDropdown.classList.remove("modal-city__dropdown_active");
    };

    async function searchCityHandler(ev) {
        const searchValue = ev.target.value.trim();
        if (searchValue) {
            openDropdown();
            api.search.city(searchValue, (data) => {
                list.innerHTML = '';
                dropdownItems = data.items;

                if (dropdownItems.length === 0) {
                    const noResultsItem = document.createElement('li');
                    noResultsItem.classList.add('modal-city__dropdown-item_not-found');
                    noResultsItem.textContent = 'Ничего не найдено';
                    list.appendChild(noResultsItem);
                } else {
                    dropdownItems.forEach(city => {
                        const listItem = document.createElement('li');
                        listItem.classList.add('modal-city__dropdown-item');
                        listItem.textContent = city;
                        list.appendChild(listItem);

                        listItem.addEventListener('click', () => {
                            inputCity.value = city;
                            validateInput(city);
                            closeDropdown();
                        });
                    });
                }
            });
        } else {
            closeDropdown();
        }
    }

    const validateInput = (inputValue) => {
        if (dropdownItems.includes(inputValue)) {
            saveButton.disabled = false;
            saveButton.classList.remove('submit-disabled');
        } else {
            saveButton.disabled = true;
            saveButton.classList.add('submit-disabled');
        }
    };

    inputCity.addEventListener("input", searchCityHandler);

    saveButton.addEventListener('click', () => {
        const inputValue = inputCity.value.trim();

        if (!inputValue || !dropdownItems.includes(inputValue)) {
            return;
        }

        // Proceed with form submission
        location.href = location.href.split('?')[0] + '?_geo=' + inputValue;
    });
});
