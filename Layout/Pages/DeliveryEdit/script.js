document.addEventListener('DOMContentLoaded', function () {

    const form = document.querySelector('.delivery-edit-type');
    const submitButton = form.querySelector('button[type="submit"]');
    const requiredInputs = form.querySelectorAll('input[required]');
    const changesIndicator = document.querySelector('.delivery-edit-type__changes');

    changesIndicator.classList.add('hidden');
    submitButton.classList.add('submit-disabled');
    submitButton.disabled = true;

    function checkFormValidity() {
        const allValid = Array.from(requiredInputs).every(input => {
            if (input.type === 'checkbox') {
                return input.checked;
            } else {
                return input.value.trim() !== '';
            }
        });
        submitButton.disabled = !allValid;
        submitButton.classList.toggle('submit-disabled', !allValid);
    }

    requiredInputs.forEach(input => {
        if (input.type === 'checkbox') {
            input.addEventListener('change', checkFormValidity);
        } else {
            input.addEventListener('input', checkFormValidity);
        }
    });

    if (form && changesIndicator) {
        const inputs = form.querySelectorAll('input, select, textarea');
        const initialValues = new Map();

        inputs.forEach(input => {
            if (input.type === 'checkbox') {
                initialValues.set(input, input.checked);
            } else {
                initialValues.set(input, input.value);
            }
        });

        function checkChanges() {
            let hasChanges = false;
            for (let input of inputs) {
                if (input.type === 'checkbox') {
                    if (input.checked !== initialValues.get(input)) {
                        hasChanges = true;
                        break;
                    }
                } else {
                    if (input.value !== initialValues.get(input)) {
                        hasChanges = true;
                        break;
                    }
                }
            }

            if (hasChanges) {
                changesIndicator.classList.remove('hidden');
                submitButton.classList.remove('submit-disabled');
                submitButton.disabled = false;
            } else {
                changesIndicator.classList.add('hidden');
                submitButton.classList.add('submit-disabled');
                submitButton.disabled = true;
            }
        }

        inputs.forEach(input => {
            input.addEventListener('input', checkChanges);
            input.addEventListener('change', checkChanges);
        });
    }

    form.addEventListener('submit', e => {
        e.preventDefault();

        // todo: validation
        const fd = new FormData(form);
        api.user.updateDelivery(fd, data => {
            if (data.success) {
                location.href = '/user/order/';
            }
        });
    });

});