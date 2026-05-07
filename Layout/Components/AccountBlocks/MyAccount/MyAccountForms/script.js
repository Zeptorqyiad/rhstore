document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('my-account-forms');
    const changesIndicator = document.querySelector('.my-account-forms__changes');
    const submitButton = document.querySelector('.my-account-forms__submit');
    const passwordInput = document.querySelector('.my-account-forms__input_pass input');
    const passwordCheckInput = document.querySelector('.my-account-forms__input_pass_confirm input');
    const passwordLabel = document.querySelector('label[for="password"]');
    const passwordCheckLabel = document.querySelector('label[for="password_check"]');

    const originalPasswordLabel = passwordLabel.textContent;
    const originalPasswordCheckLabel = passwordCheckLabel.textContent;

    submitButton.classList.add('submit-disabled');
    submitButton.disabled = true;

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
            let passwordsValid = true;

            for (let input of inputs) {
                if (input.type === 'checkbox') {
                    if (input.checked !== initialValues.get(input)) {
                        hasChanges = true;
                    }
                } else {
                    if (input.value !== initialValues.get(input)) {
                        hasChanges = true;
                    }
                }
            }

            if (passwordInput.value || passwordCheckInput.value) {
                if (passwordInput.value.length < 8) {
                    passwordsValid = false;
                    passwordLabel.textContent = "Минимум 8 символов";
                    passwordLabel.classList.add('error');
                } else if (passwordInput.value !== passwordCheckInput.value) {
                    passwordsValid = false;
                    passwordLabel.textContent = "Пароли не совпадают";
                    passwordLabel.classList.add('error');
                    passwordCheckLabel.textContent = "Пароли не совпадают";
                    passwordCheckLabel.classList.add('error');
                } else {
                    passwordLabel.textContent = originalPasswordLabel;
                    passwordLabel.classList.remove('error');
                    passwordCheckLabel.textContent = originalPasswordCheckLabel;
                    passwordCheckLabel.classList.remove('error');
                }
            } else {
                passwordLabel.textContent = originalPasswordLabel;
                passwordLabel.classList.remove('error');
                passwordCheckLabel.textContent = originalPasswordCheckLabel;
                passwordCheckLabel.classList.remove('error');
            }

            if (hasChanges && passwordsValid) {
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

        form.addEventListener('submit', function(e) {
            e.preventDefault();
            if (passwordInput.value || passwordCheckInput.value) {
                if (passwordInput.value.length < 8) {
                    passwordLabel.textContent = "Минимум 8 символов";
                    passwordLabel.classList.add('error');
                    return;
                }
                if (passwordInput.value !== passwordCheckInput.value) {
                    passwordLabel.textContent = "Пароли не совпадают";
                    passwordLabel.classList.add('error');
                    passwordCheckLabel.textContent = "Пароли не совпадают";
                    passwordCheckLabel.classList.add('error');
                    return;
                }
            }
            // Add your form submission logic here
            console.log('Form submitted successfully');
        });
    }
});