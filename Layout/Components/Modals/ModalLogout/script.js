document.addEventListener('DOMContentLoaded', () => {
    const modal = document.querySelector('.modal-logout');
    const closeButton = document.querySelector('.modal-logout__button_close');

    window.onclick = function (event) {
        if (event.target === modal) {
            modal.close();
        }
    };

    closeButton.addEventListener('click', () => {
        modal.close();
    })
})

