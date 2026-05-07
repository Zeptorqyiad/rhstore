function setupPags() {
    const pagItems = document.querySelectorAll('.pagination1__link');
    pagItems.forEach(e => {
        if (e.dataset.cb && !e.dataset.init) {
            e.addEventListener('click', ev => {
                ev.preventDefault();
                CALLBACKS[e.dataset.cb](e);
            });

            e.dataset.init = true;
        }
    });
}

const pagSearch = () => {
    const pageInputContainers = document.querySelectorAll('.pagination__search-input');
    const paginationContainer = document.getElementById('pagination-container');
    const link = paginationContainer ? paginationContainer.dataset.link : '';

    function goToPage(inputContainer) {
        const input = inputContainer.querySelector('input');
        if (!input || !(input instanceof HTMLInputElement)) {
            console.error('Invalid input element:', input);
            return;
        }
        let pageNumber = input.value.trim();
        if (pageNumber !== '') {
            pageNumber = parseInt(pageNumber, 10);
            if (!isNaN(pageNumber) && pageNumber > 0) {
                pageNumber = Math.min(pageNumber, Number(document.querySelector('.pagination__search').dataset.max));
                window.location.href = `${link}?page=${pageNumber - 1}&`;
            }
        }
    }

    pageInputContainers.forEach(function(container) {
        const input = container.querySelector('input');
        if (!input) {
            return;
        }

        input.addEventListener('keypress', function(event) {
            if (event.key === 'Enter') {
                goToPage(container);
            }
        });

        const button = container.nextElementSibling;
        if (button && button.classList.contains('pagination__search-button')) {
            button.addEventListener('click', function() {
                goToPage(container);
            });
        }
    });
}


document.addEventListener('DOMContentLoaded', () => {
    setupPags();
    pagSearch();
});
