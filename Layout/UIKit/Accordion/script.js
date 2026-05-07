document.addEventListener('DOMContentLoaded', function () {
    const items = document.querySelectorAll('.accordion');

    items.forEach(item => {
        const toggle = item.querySelector('.accordion__top');
        const body = item.querySelector('.accordion__body');
        const bodyHeight = body.querySelector('div').scrollHeight;


        window.addEventListener('resize', function () {
            if (item.classList.contains('accordion_active')) {
                body.style = `max-height: ${body.querySelector('div').scrollHeight}px`;
            }
        })

        item.addEventListener('click', () => {
            item.classList.toggle('accordion_active');

            if (item.classList.contains('accordion_active')) {
                body.style = `max-height: ${body.querySelector('div').scrollHeight}px`;
            } else {
                body.style = `max-height: 0px`;
            }
        })
    })
});
