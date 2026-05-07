const toggleDropdown = () => {
    const dropdownItems = document.querySelectorAll('.mobile-still__item_dropdown');

    dropdownItems.forEach(function (item) {
        const toggleButton = item.querySelector('.mobile-still__item-link-icon');

        item.addEventListener('click', function () {
            this.classList.toggle('mobile-still__item_dropdown_visible');
            toggleButton.classList.toggle('mobile-still__item-link-icon_active');
        });
    });
}

document.addEventListener('DOMContentLoaded', toggleDropdown);