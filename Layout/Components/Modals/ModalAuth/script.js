document.addEventListener('DOMContentLoaded', () => {
    const modal = document.querySelector('.modal-auth');
    const closeButton = document.querySelector('.button-modal-close');

    closeButton.addEventListener('click', () => {
        modal.close();
    })

    function setupFormSwitching(formGroupId) {
        const signInForm = document.getElementById(`sign-in-form-${formGroupId}`);
        const signUpForm = document.getElementById(`sign-up-form-${formGroupId}`);
        const switchToSignUpBtn = document.getElementById(`switch-to-sign-up-${formGroupId}`);
        const switchToSignInBtn = document.getElementById(`switch-to-sign-in-${formGroupId}`);

        if (!signInForm || !signUpForm || !switchToSignUpBtn || !switchToSignInBtn) {
            return;
        }

        signInForm.style.display = 'block';
        signUpForm.style.display = 'none';

        switchToSignUpBtn.addEventListener('click', function() {
            signInForm.setAttribute('novalidate', '');
            signUpForm.removeAttribute('novalidate');

            signInForm.style.display = 'none';
            signUpForm.style.display = 'block';
        });

        switchToSignInBtn.addEventListener('click', function() {
            signUpForm.setAttribute('novalidate', '');
            signInForm.removeAttribute('novalidate');

            signUpForm.style.display = 'none';
            signInForm.style.display = 'block';
        });
    }

    setupFormSwitching('1');
    setupFormSwitching('2');
})