document.addEventListener('DOMContentLoaded', () => {
    const moreButton = document.querySelector('.order-archived__show-more');

    if (!moreButton) {
        return
    }

    moreButton.addEventListener('click', () => {
        const span = moreButton.querySelector('span');

        if (moreButton.classList.contains('order-archived__show-more_active')) {
            moreButton.classList.remove('order-archived__show-more_active');
            span.textContent = 'Развернуть';
        } else {
            moreButton.classList.add('order-archived__show-more_active');
            span.textContent = 'Свернуть';
        }
    })
})
