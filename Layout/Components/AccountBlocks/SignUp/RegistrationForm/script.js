document.addEventListener('DOMContentLoaded', function () {
    const forms = document.querySelectorAll('.registration-form');
    const modalInvalidEmail = document.querySelector('.modal-invalid-email');

    forms.forEach(form => {
        form.addEventListener('submit', e => {
            e.preventDefault();

            const lastName = form.querySelector('input[name="last_name"]').value.trim();
            const name = form.querySelector('input[name="name"]').value.trim();
            const email = form.querySelector('input[name="email"]').value.trim();
            const phone = form.querySelector('input[name="phone"]').value.trim();
            const password = form.querySelector('input[name="password"]').value.trim();

            const submitButton = form.querySelector('button[type="submit"]');

            submitButton.disabled = true;
            submitButton.classList.add('submit-disabled', 'loading');

            api.auth.register(lastName, name, email, phone, password, data => {

                if (!data.success) {
                    console.log('Registration failed');
                    if (data.error === "system_error" && data.extra && data.extra.includes("Duplicate entry") && data.extra.includes("for key 'user.email'")) {
                        modalInvalidEmail.showModal();
                        submitButton.disabled = false;
                        submitButton.classList.remove('submit-disabled', 'loading');
                    }
                    if (data.error === "invalid_user" || data.error === "already_exists") {
                        modalInvalidEmail.showModal();
                        submitButton.disabled = false;
                        submitButton.classList.remove('submit-disabled', 'loading');
                    } else {
                        submitButton.disabled = false;
                        submitButton.classList.remove('submit-disabled', 'loading');
                        console.log('Other registration error:', data.error);
                    }
                } else {
                    sessionStorage.setItem('showSignUpModal', 'true');

                    if (location.pathname === '/sign-up/') {
                        location.href = '/user/order/delivery/';
                    } else {
                        location.href = '/';
                    }
                }
            });
        });
    });
});