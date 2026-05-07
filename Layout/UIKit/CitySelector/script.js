document.addEventListener("DOMContentLoaded", function () {
    const citySelectors = document.querySelectorAll('.city-selector');

    citySelectors.forEach(cityDropdown => {
        const cityInput = cityDropdown.querySelector('.city-selector__input_phone input');
        const dropdownWrapper = cityDropdown.querySelector('.city-selector__dropdown-wrapper');
        const dropdownList = cityDropdown.querySelector('.city-selector__dropdown-list');

        let dropdownItems = [];

        const openDropdown = () => {
            cityDropdown.classList.add('city-selector__dropdown_active');
        };

        const closeDropdown = () => {
            cityDropdown.classList.remove('city-selector__dropdown_active');
        };

        async function searchCityHandler(ev) {
            const searchValue = ev.target.value.trim();
            if (searchValue) {
                openDropdown();
                api.search.city(searchValue, (data) => {
                    dropdownList.innerHTML = '';
                    dropdownItems = data.items;

                    if (dropdownItems.length === 0) {
                        const noResultsItem = document.createElement('li');
                        noResultsItem.classList.add('city-selector__dropdown-item_not-found');
                        noResultsItem.textContent = 'Ничего не найдено';
                        dropdownList.appendChild(noResultsItem);
                    } else {
                        dropdownItems.forEach(city => {
                            const listItem = document.createElement('li');
                            listItem.classList.add('city-selector__dropdown-item');
                            listItem.textContent = city;
                            dropdownList.appendChild(listItem);

                            listItem.addEventListener('click', () => {
                                cityInput.value = city;
                                closeDropdown();
                            });
                        });
                    }
                });
            } else {
                closeDropdown();
            }
        }

        cityInput.addEventListener("input", searchCityHandler);

        document.addEventListener('click', (e) => {
            if (!dropdownWrapper.contains(e.target) && e.target !== cityInput) {
                closeDropdown();
            }
        });
    });
});
