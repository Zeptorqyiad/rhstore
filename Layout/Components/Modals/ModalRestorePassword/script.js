document.addEventListener('DOMContentLoaded', () => {
    const modal = document.querySelector('.modal-restore-pass');
    const authModal = document.querySelector('.modal-auth');
    const notification = document.querySelector('.modal-notification');
    const modalInvalidUser = document.querySelector('.modal-invalid-user');

    const backButton = document.querySelector('.modal-restore-pass__back');
    const submitButton = document.querySelector('.modal-restore-pass__submit');

    backButton.addEventListener('click', (e) => {
        e.preventDefault();
        modal.close();
        if (authModal) {
            authModal.showModal();
        }
    })

    submitButton.addEventListener('click', (e) => {
        e.preventDefault();

        submitButton.disabled = true;
        submitButton.classList.add('submit-disabled');

        api.auth.reset(document.querySelector('#emailRestore').value, d => {
            if (d.success) {
                modal.close();
                notification.showModal();
                submitButton.disabled = false;
                submitButton.classList.remove('submit-disabled');
            } else if (d.error === 'user_not_found') {
                modalInvalidUser.showModal();
                submitButton.disabled = false;
                submitButton.classList.remove('submit-disabled');
            } else {
                submitButton.disabled = false;
                submitButton.classList.remove('submit-disabled');
            }
        });
    })
})