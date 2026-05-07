document.addEventListener('DOMContentLoaded', () => {
    const modal = document.querySelector('.modal-order-refund');
    const closeButton = document.querySelector('.modal-order-refund__button_close');

    window.onclick = function (event) {
        if (event.target === modal) {
            modal.close();
        }
    };

    closeButton.addEventListener('click', () => {
        modal.close();
    })
})

