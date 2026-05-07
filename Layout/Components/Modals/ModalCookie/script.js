document.addEventListener('DOMContentLoaded', () => {
    const cookie = document.querySelector('.cookie');
    const closeButton = cookie.querySelector('.button-modal-close');
    const secondButton = cookie.querySelector('.js--cookie__button');

    const closeCookie = () => {
        cookie.close();
        localStorage.setItem('cookieConsent', 'true');
    };

    if (!localStorage.getItem('cookieConsent')) cookie.show();
    closeButton.addEventListener('click', closeCookie);
    secondButton.addEventListener('click', closeCookie);
});