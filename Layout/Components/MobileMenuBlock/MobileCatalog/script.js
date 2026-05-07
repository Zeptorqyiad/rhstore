document.addEventListener("DOMContentLoaded", function () {
    const catalog = document.querySelector(".mobile-catalog");
    const inputs = catalog.querySelectorAll("input[type=radio]");
    const button = document.querySelector(".mobile-catalog__button");
    const currentUrl = window.location.href;

    const allChildren = catalog.querySelectorAll('.mobile-catalog__items-children');

    const hideAllChildren = () => {
        allChildren.forEach(child => child.classList.remove('visible'));
    };

    const makeAncestorsVisible = (element) => {
        let parent = element.closest('.mobile-catalog__items-children');
        while (parent) {
            parent.classList.add('visible');
            parent = parent.parentElement.closest('.mobile-catalog__items-children');
        }
    };

    const updateButtonState = () => {
        const isAnyInputChecked = Array.from(inputs).some(input => input.checked);
        button.classList.toggle('submit-disabled', !isAnyInputChecked);
    };

    // Function to find the most specific matching input
    const findMostSpecificInput = (url) => {
        let bestMatch = null;
        let maxLength = 0;

        inputs.forEach(input => {
            if (url.includes(input.value) && input.value.length > maxLength) {
                bestMatch = input;
                maxLength = input.value.length;
            }
        });

        return bestMatch;
    };

    // Find the most specific matching input
    let relevantInput = findMostSpecificInput(currentUrl);

    // If no relevant input found, default to the first input (root catalog)
    if (!relevantInput && inputs.length > 0) {
        relevantInput = inputs[0];
    }

    // Check the relevant input and make its ancestors visible
    if (relevantInput) {
        relevantInput.checked = true;
        makeAncestorsVisible(relevantInput);
    }

    // Initial button state
    updateButtonState();

    catalog.addEventListener('click', (event) => {
        const input = event.target.closest('input[type=radio]');
        if (!input) return;

        event.stopPropagation();
        hideAllChildren();
        makeAncestorsVisible(input);

        const childUl = input.closest('li').querySelector('.mobile-catalog__items-children');
        if (childUl) {
            childUl.classList.add('visible');
        }

        updateButtonState();
    });

    button.addEventListener("click", () => {
        if (!button.classList.contains('submit-disabled')) {
            const checkedInput = catalog.querySelector('input[type=radio]:checked');
            if (checkedInput) {
                window.location.href = checkedInput.value;
            }
        }
    });
});