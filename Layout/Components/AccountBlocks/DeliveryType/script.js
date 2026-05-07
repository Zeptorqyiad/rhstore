document.addEventListener('DOMContentLoaded', function () {

    const form = document.querySelector('.delivery-type');
    const submitButton = form.querySelector('button[type="submit"]');

    form.addEventListener('submit', e => {
        e.preventDefault();

        submitButton.classList.add('submit-disabled');
        submitButton.disabled = true;

        const fd = new FormData(form);
        api.user.updateDelivery(fd, data => {
            if (data.success) {
                location.href = '/user/order/';

            } else {
                submitButton.classList.remove('submit-disabled');
                submitButton.disabled = false;
            }
        });
    });

});

