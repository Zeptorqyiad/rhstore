(function () {
    // Constants
    const SELECTORS = {
        CLOSE_BUTTON: '.modal-search-mobile__button-close',
        MODAL: '.modal-search-mobile',
        ITEMS_LIST: '.modal-search-mobile__items',
        CATS_LIST: '.modal-search-mobile__categories',
        SUBMIT_BUTTON: '.modal-search-mobile__submit',
        NO_RESULTS_TEXT: '.modal-search-mobile__text',
        RESULTS_CONTAINER: '.modal-search-mobile__results',
        SEARCH_INPUT: '.modal-search-mobile__search-input',
        BOTTOM: '.modal-search-mobile__bottom',
        CATS_CONTAINER: '.modal-search-mobile__categories-wrapper',
    };

    const CLASSES = {
        MODAL_ACTIVE: 'modal-search-mobile_active',
        SCROLL_LOCK: 'scroll-lock',
        TEXT_ACTIVE: 'modal-search-mobile__text_active',
        RESULTS_ACTIVE: 'modal-search-mobile__results_active',
        BOTTOM_ACTIVE: 'modal-search-mobile__bottom_active',
    };

    const MESSAGES = {
        NO_RESULTS: 'По вашему запросу ничего не найдено',
        ENTER_QUERY: 'Введите название или артикул',
        SHOW_ALL: 'Показать все {0} товаров',
        API_ERROR: 'Произошла ошибка при поиске. Пожалуйста, попробуйте еще раз.',
    };

    const searchModalMobile = () => {
        const closeButton = document.querySelector(SELECTORS.CLOSE_BUTTON);
        const modal = document.querySelector(SELECTORS.MODAL);

        if (closeButton && modal) {
            closeButton.addEventListener('click', function (e) {
                e.preventDefault();
                modal.classList.remove(CLASSES.MODAL_ACTIVE);
                document.body.classList.remove(CLASSES.SCROLL_LOCK);
            });
        }
    };

    document.addEventListener('DOMContentLoaded', searchModalMobile);

    async function fetchMobileSearchItems(q) {
        function processMobileSearchResults(data, error) {
            if (error) {
                console.error('Fetch error:', error);
                updateMobileHTML([], [], 0, MESSAGES.API_ERROR);
            } else {
                updateMobileHTML(data.items, data.cats, data.tot);
            }
        }

        try {
            const response = await new Promise((resolve, reject) => {
                api.search.products(q, (data, error) => {
                    if (error) {
                        reject(error);
                    } else {
                        resolve(data);
                    }
                });
            });

            processMobileSearchResults(response);
        } catch (error) {
            processMobileSearchResults(null, error);
        }
    }

    function updateMobileHTML(items, cats, totalItems, errorMessage = null) {
        const itemsList = document.querySelector(SELECTORS.ITEMS_LIST);
        const catsList = document.querySelector(SELECTORS.CATS_LIST);
        const submitButton = document.querySelector(SELECTORS.SUBMIT_BUTTON);
        const noResultsText = document.querySelector(SELECTORS.NO_RESULTS_TEXT);
        const resultsContainer = document.querySelector(SELECTORS.RESULTS_CONTAINER);
        const bottomSection = document.querySelector(SELECTORS.BOTTOM);
        const catsContainer = document.querySelector(SELECTORS.CATS_CONTAINER);

        if (!itemsList || !catsList || !submitButton || !noResultsText || !resultsContainer || !bottomSection) {
            return;
        }

        itemsList.innerHTML = '';
        catsList.innerHTML = '';

        if (errorMessage) {
            noResultsText.textContent = errorMessage;
            noResultsText.classList.add(CLASSES.TEXT_ACTIVE);
            resultsContainer.classList.remove(CLASSES.RESULTS_ACTIVE);
            bottomSection.classList.remove(CLASSES.BOTTOM_ACTIVE);
            return;
        }

        if (cats.length === 0) {
            catsContainer.style.display = 'none';
        } else {
            catsContainer.style.display = '';
        }

        if (items.length === 0 && cats.length === 0) {
            noResultsText.textContent = MESSAGES.NO_RESULTS;
            noResultsText.classList.add(CLASSES.TEXT_ACTIVE);
            resultsContainer.classList.remove(CLASSES.RESULTS_ACTIVE);
            bottomSection.classList.remove(CLASSES.BOTTOM_ACTIVE);
        } else {
            noResultsText.classList.remove(CLASSES.TEXT_ACTIVE);
            resultsContainer.classList.add(CLASSES.RESULTS_ACTIVE);
            bottomSection.classList.add(CLASSES.BOTTOM_ACTIVE);
            submitButton.textContent = MESSAGES.SHOW_ALL.replace('{0}', totalItems);
            catsContainer.classList.remove('hidden')

            const fragment = document.createDocumentFragment();

            items.forEach(item => {
                const listItem = document.createElement('li');
                listItem.classList.add('modal-search-mobile__item');
                listItem.innerHTML = `
                    <a href='${item.path}' class='modal-search-mobile__link' draggable='false'>
                        <span>${item.name}</span>
                        <svg xmlns='http://www.w3.org/2000/svg' fill='#404040' viewBox='0 0 24 24' aria-hidden='true'>
                            <path fill-rule='evenodd' d='M9.793 16.207a1 1 0 0 1 0-1.414l2.293-2.293-2.293-2.293a1 1 0 0 1 1.414-1.414l3 3a1 1 0 0 1 0 1.414l-3 3a1 1 0 0 1-1.414 0Z' clip-rule='evenodd'/>
                        </svg>
                    </a>
                `;
                fragment.appendChild(listItem);
            });

            itemsList.appendChild(fragment);

            const catsFragment = document.createDocumentFragment();

            cats.forEach(cat => {
                const listItem = document.createElement('li');
                listItem.classList.add('modal-search-mobile__category');
                listItem.innerHTML = `
                    <a href='${cat.path}' class='modal-search-mobile__link' draggable='false'>
                        <span>${cat.name}</span>
                    </a>
                `;
                catsFragment.appendChild(listItem);
            });

            catsList.appendChild(catsFragment);
        }
    }

    function debounce(func, delay) {
        let timeoutId;
        return function (...args) {
            if (timeoutId) {
                clearTimeout(timeoutId);
            }
            timeoutId = setTimeout(() => {
                func(...args);
            }, delay);
        };
    }

    const mobileSearchInput = document.querySelector(SELECTORS.SEARCH_INPUT);
    const noResultsText = document.querySelector(SELECTORS.NO_RESULTS_TEXT);
    const resultsContainer = document.querySelector(SELECTORS.RESULTS_CONTAINER);
    const bottomSection = document.querySelector(SELECTORS.BOTTOM);

    if (mobileSearchInput && noResultsText && resultsContainer && bottomSection) {
        // Set initial state
        noResultsText.textContent = MESSAGES.ENTER_QUERY;
        noResultsText.classList.add(CLASSES.TEXT_ACTIVE);
        resultsContainer.classList.remove(CLASSES.RESULTS_ACTIVE);
        bottomSection.classList.remove(CLASSES.BOTTOM_ACTIVE);

        mobileSearchInput.addEventListener('focus', () => {
            const query = mobileSearchInput.value;

            if (!query) {
                noResultsText.textContent = MESSAGES.ENTER_QUERY;
                noResultsText.classList.add(CLASSES.TEXT_ACTIVE);
                resultsContainer.classList.remove(CLASSES.RESULTS_ACTIVE);
                bottomSection.classList.remove(CLASSES.BOTTOM_ACTIVE);
            } else {
                fetchMobileSearchItems(query);
            }
        });

        mobileSearchInput.addEventListener('input', debounce((event) => {
            const query = event.target.value;
            if (query) {
                fetchMobileSearchItems(query);
            } else {
                noResultsText.textContent = MESSAGES.ENTER_QUERY;
                noResultsText.classList.add(CLASSES.TEXT_ACTIVE);
                resultsContainer.classList.remove(CLASSES.RESULTS_ACTIVE);
                bottomSection.classList.remove(CLASSES.BOTTOM_ACTIVE);
            }
        }, 300));
    }
})();