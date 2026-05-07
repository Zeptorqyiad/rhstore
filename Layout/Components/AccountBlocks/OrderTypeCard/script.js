document.addEventListener('DOMContentLoaded', function () {
    const radioButtons = document.querySelectorAll('.order-type-card__radio-button input[type="radio"]');
    const detailsSections = document.querySelectorAll('[data-details]');
    const hiddenSections = {};

    const showDetails = (type) => {
        detailsSections.forEach(section => {
            const sectionType = section.dataset.details;

            if (sectionType === type) {
                section.classList.remove('hidden');

                if (hiddenSections[sectionType]) {
                    const parent = hiddenSections[sectionType].parent;
                    const placeholder = hiddenSections[sectionType].placeholder;
                    parent.replaceChild(section, placeholder);
                    delete hiddenSections[sectionType];
                }
            } else {
                section.classList.add('hidden');

                if (!hiddenSections[sectionType]) {
                    const placeholder = document.createComment('placeholder for ' + sectionType);
                    hiddenSections[sectionType] = {
                        section: section,
                        parent: section.parentNode,
                        placeholder: placeholder
                    };
                    section.parentNode.replaceChild(placeholder, section);
                }
            }
        });
    }

    radioButtons.forEach(radio => {
        radio.addEventListener('change', function () {
            showDetails(this.dataset.id);
        });
    });

    const checkedRadio = document.querySelector('.order-type-card__radio-button input[type="radio"]:checked');
    if (checkedRadio) {
        showDetails(checkedRadio.dataset.id);
    }
});
