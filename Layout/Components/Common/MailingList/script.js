document.addEventListener('DOMContentLoaded', function () {
    const form = document.querySelector('.mailing-list__mail-card');

    // const submitButton = form.querySelector('button[type="submit"]');
    // const requiredInputs = form.querySelectorAll('input[required]');
    const modal = document.querySelector('.mailing-list__modal');
    const buttonModalOpen = document.querySelector('.mailing-list__card-button_modal');

    const modalSuccess = document.querySelector('.modal-form-submitted');

    buttonModalOpen.addEventListener('click', () => {
        modal.showModal();
    })

    // function checkFormValidity() {
    //     const allValid = Array.from(requiredInputs).every(input => {
    //         if (input.type === 'checkbox') {
    //             return input.checked;
    //         } else {
    //             return input.value.trim() !== '';
    //         }
    //     });
    //     submitButton.disabled = !allValid;
    //     submitButton.classList.toggle('submit-disabled', !allValid);
    // }
    //
    // requiredInputs.forEach(input => {
    //     if (input.type === 'checkbox') {
    //         input.addEventListener('change', checkFormValidity);
    //     } else {
    //         input.addEventListener('input', checkFormValidity);
    //     }
    // });

    form.addEventListener('submit', e => {
        e.preventDefault();

        modalSuccess.showModal();

    });
});