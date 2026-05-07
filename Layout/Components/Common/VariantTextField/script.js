document.addEventListener('DOMContentLoaded', function() {
    const passwordFields = document.querySelectorAll('input[type="password"]');

    passwordFields.forEach(function(passwordField) {
        const toggleButton = passwordField.parentElement.querySelector('.variant-text-field__toggle-password');
        if (toggleButton) {
            const showIcon = toggleButton.querySelector('.variant-text-field__icon--show');
            const hideIcon = toggleButton.querySelector('.variant-text-field__icon--hide');

            toggleButton.addEventListener('click', function(e) {
                e.preventDefault();

                if (passwordField.type === 'password') {
                    passwordField.type = 'text';
                    showIcon.classList.add('hidden');
                    hideIcon.classList.remove('hidden');
                } else {
                    passwordField.type = 'password';
                    showIcon.classList.remove('hidden');
                    hideIcon.classList.add('hidden');
                }
            });

            hideIcon.classList.add('hidden')
        }
    });
});