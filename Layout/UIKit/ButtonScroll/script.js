document.addEventListener('DOMContentLoaded', function() {
    const scrollButton = document.querySelector('.button-scroll');
    const screenHeight = window.innerHeight;

    function toggleButtonVisibility() {
        if (window.scrollY > screenHeight) {
            scrollButton.classList.add('button-scroll_visible');
        } else {
            scrollButton.classList.remove('button-scroll_visible');
        }
    }

    toggleButtonVisibility();
    window.addEventListener('scroll', toggleButtonVisibility);

    scrollButton.addEventListener('click', function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
});