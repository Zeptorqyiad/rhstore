document.addEventListener('DOMContentLoaded', () => {
    const modal = document.querySelector('.modal-invalid-user');
    const closeButton = document.querySelector('.modal-invalid-user__button_close');

    window.onclick = function (event) {
        if (event.target === modal) {
            modal.close();
        }
    };

    closeButton.addEventListener('click', () => {
        modal.close();
    })
})

