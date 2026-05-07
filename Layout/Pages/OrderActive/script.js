document.addEventListener('DOMContentLoaded', () => {
    const moreButton = document.querySelector('.order-active__show-more');

    moreButton.addEventListener('click', () => {
        const span = moreButton.querySelector('span');

        if (moreButton.classList.contains('order-active__show-more_active')) {
            moreButton.classList.remove('order-active__show-more_active');
            span.textContent = 'Развернуть';
        } else {
            moreButton.classList.add('order-active__show-more_active');
            span.textContent = 'Свернуть';
        }
    })
})
