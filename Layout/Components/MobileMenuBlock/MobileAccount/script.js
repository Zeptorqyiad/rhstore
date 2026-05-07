document.addEventListener('DOMContentLoaded', () => {
    const accountModal = document.querySelector('.mobile-account');
    const closeButtons = document.querySelectorAll('.mobile-account__icon');

    closeButtons.forEach((button) => {
        button.addEventListener("click", () => {
            accountModal.classList.remove("open-mobile-modal");
        })
    });

})