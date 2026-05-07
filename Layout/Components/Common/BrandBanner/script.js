document.addEventListener('DOMContentLoaded', () => {
    const closeButton = document.querySelector('.brand-banner__close-button');
    const banner = document.querySelector('.brand-banner');

    closeButton.addEventListener('click', () => {
        banner.remove();
    });
});