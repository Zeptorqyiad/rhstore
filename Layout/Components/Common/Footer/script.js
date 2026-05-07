function ProfileButton() {
    const profileButton = document.querySelector('.footer__item-link_profile');
    const signInModal = document.querySelector('.modal-auth');

    if (profileButton && signInModal) {
        profileButton.addEventListener('click', () => signInModal.showModal());
    }
}

function initFooter() {
    ProfileButton();
}

document.addEventListener('DOMContentLoaded', initFooter);