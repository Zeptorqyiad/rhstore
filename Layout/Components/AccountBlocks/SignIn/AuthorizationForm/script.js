document.addEventListener('DOMContentLoaded', function () {
    const forms = document.querySelectorAll('.authorization-form');
    const modalInvalidUser = document.querySelector('.modal-invalid-user');

    forms.forEach(form => {
        const submitButton = form.querySelector('button[type="submit"]');

        form.addEventListener('submit', e => {
            e.preventDefault();

            submitButton.disabled = true;
            submitButton.classList.add('submit-disabled', 'loading');

            const email = form.querySelector('input[name="email"]').value.trim();
            const pass = form.querySelector('input[name="password"]').value.trim();

            if (!email || !pass) {
                console.log('Email or password is missing');
                submitButton.disabled = false;
                submitButton.classList.remove('submit-disabled', 'loading');
                return;
            }

            api.auth.login(email, pass, data => {
                if (data.success) {
                    sessionStorage.setItem('showSignInModal', 'true');

                    if (location.pathname === '/sign-in/') {
                        location.href = '/user/order/delivery/';
                    } else {
                        location.href = '/';
                    }
                } else if (data.error === 'invalid_user') {
                    modalInvalidUser.showModal();
                    submitButton.disabled = false;
                    submitButton.classList.remove('submit-disabled', 'loading');
                } else {
                    console.log('Login failed');
                    submitButton.disabled = false;
                    submitButton.classList.remove('submit-disabled', 'loading');
                }
            });
        });
    });
});

const restoreModal = (event) => {
    const previousModal = event.currentTarget.closest('dialog');
    const restoreModal = document.querySelector('.modal-restore-pass');
    restoreModal.showModal();

    if (previousModal) {
        previousModal.close();
    }
};
