document.addEventListener("DOMContentLoaded", function () {
    const organizationSelects = document.querySelectorAll('.organization-select');

    organizationSelects.forEach((select) => {
        const checkbox = select.querySelector('.organization-select__checkbox input[type="checkbox"]');
        const wrapper = select.querySelector('.organization-select__wrapper');
        const orgInput = select.querySelector('.js--inn input');
        const orgButton = select.querySelector('.js--find-inn');
        const orgName = select.querySelector('.js--org-name');
        const orgInnInput = select.querySelector('input[name="org_inn"]');
        const orgNameInput = select.querySelector('input[name="org_name"]');
        const dropdown = select.querySelector('.organization-select__dropdown');
        const dropdownList = select.querySelector('.organization-select__dropdown-list');

        let dropdownItems = [];

        const openDropdown = () => {
            dropdown.classList.add('organization-select__dropdown_active');
        };

        const closeDropdown = () => {
            dropdown.classList.remove('organization-select__dropdown_active');
        };

        checkbox.addEventListener('change', function () {
            if (this.checked) {
                wrapper.classList.add('organization-select__wrapper_active');
            } else {
                wrapper.classList.remove('organization-select__wrapper_active');
            }
        });

        async function searchOrgHandler(ev) {
            const searchValue = ev.target.value.trim();
            if (searchValue) {
                openDropdown();
                api.user.findOrg(searchValue, (data) => {
                    dropdownList.innerHTML = '';
                    dropdownItems = data;

                    if (dropdownItems.length === 0) {
                        const noResultsItem = document.createElement('li');
                        noResultsItem.classList.add('organization-select__dropdown-item', 'organization-select__dropdown-item_not-found');
                        noResultsItem.textContent = 'Ничего не найдено';
                        dropdownList.appendChild(noResultsItem);
                    } else {
                        dropdownItems.forEach(org => {
                            const listItem = document.createElement('li');
                            listItem.classList.add('organization-select__dropdown-item');
                            listItem.textContent = `${org.value} (ИНН: ${org.data.inn})`;
                            dropdownList.appendChild(listItem);

                            listItem.addEventListener('click', () => {
                                orgInput.value = org.data.inn;
                                orgName.textContent = org.value;
                                orgInnInput.value = org.data.inn;
                                orgNameInput.value = org.value;
                                closeDropdown();
                            });
                        });
                    }
                });
            } else {
                closeDropdown();
            }
        }

        orgInput.addEventListener("input", searchOrgHandler);

        orgButton.addEventListener('click', () => {
            const inputValue = orgInput.value.trim();
            if (!inputValue) return;

            orgName.textContent = 'Ищем организацию...';
            api.user.findOrg(inputValue, (data) => {
                if (!data.length) {
                    orgName.textContent = 'Не найдено!';
                } else {
                    const org = data[0];
                    orgName.textContent = `${org.value} (ИНН: ${org.data.inn})`;
                    orgInnInput.value = org.data.inn;
                    orgNameInput.value = org.value;
                }
            });
        });

        document.addEventListener('click', (e) => {
            if (!dropdown.contains(e.target) && e.target !== orgInput) {
                closeDropdown();
            }
        });
    });
});