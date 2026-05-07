document.addEventListener('DOMContentLoaded', () => {
    const modal = document.querySelector('.modal-notification');
    const closeButton = document.querySelector('.modal-notification__button_close');

    window.onclick = function (event) {
        if (event.target === modal) {
            modal.close();
        }
    };

    closeButton.addEventListener('click', () => {
        modal.close();
    })
})

