document.addEventListener('DOMContentLoaded', () => {
    const modal = document.querySelector('.modal-invalid-email');
    const closeButton = document.querySelector('.modal-invalid-email__button_close');

    window.onclick = function (event) {
        if (event.target === modal) {
            modal.close();
        }
    };

    closeButton.addEventListener('click', () => {
        modal.close();
    })
})

