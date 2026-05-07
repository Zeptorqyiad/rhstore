document.addEventListener('DOMContentLoaded', () => {
    const cancelButtons = document.querySelectorAll('.order-cards__cancel, .order-active__cancel');
    const cancelModal = document.querySelector('.modal-order-cancel');
    const confirmCancelButton = document.querySelector('.modal-order-cancel__button');
    let currentOrderId;

    cancelButtons.forEach(button => {
        button.addEventListener('click', () => {
            const orderCard = button.closest('.order-cards__card') || button.closest('.order-active__details');

            if (orderCard) {
                currentOrderId = orderCard.dataset.id;

                if (currentOrderId) {
                    cancelModal.showModal();
                } else {
                    console.error('Could not find order ID');
                }
            }
        });
    });

    confirmCancelButton.addEventListener('click', () => {
        if (currentOrderId) {
            api.user.orderCancel(currentOrderId)
            cancelModal.close();
            location.href = '/active-orders/';
        }
    });
});