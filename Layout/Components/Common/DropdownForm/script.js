document.addEventListener("DOMContentLoaded", () => {
    const dropdowns = document.querySelectorAll('.dropdown-form');

    if (!dropdowns.length) return;

    document.addEventListener('click', function (e) {
        dropdowns.forEach(dropdown => {
            const isClickInside = dropdown.contains(e.target);

            if (isClickInside) {
                dropdown.classList.toggle('open');
            } else {
                dropdown.classList.remove('open');
            }
        });
    });

    dropdowns.forEach(dropdown => {
        const input = dropdown.querySelector('.dropdown-form__input');
        const hidden = dropdown.querySelector('input[type="hidden"]');
        const options = dropdown.querySelectorAll('.dropdown-form__option');

        options.forEach(option => {
            option.addEventListener('click', (e) => {
                input.value = option.textContent.trim();
                hidden.value = option.dataset.value;

                dropdown.classList.remove('open');
                e.stopPropagation();
            });
        });
    });
});