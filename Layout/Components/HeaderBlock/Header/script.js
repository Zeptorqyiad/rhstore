(function() {
    // Constants
    const SELECTORS = {
        SEARCH_INPUT: '.header__search',
        SEARCH_INPUT_FOCUS: '.header__search-input',
        SEARCH_MODAL: '.modal-search-main',
        SEARCH_MODAL_MOBILE: '.modal-search-mobile',
        MODAL_OVERLAY: '.modal-search-main__overlay',
        SEARCH_BUTTON_MOBILE: '.header__button-mob-search',
        LOGO_BLOCK: '.header__logo-swap',
        ITEMS_LIST: '.modal-search-main__items',
        CATS_LIST: '.modal-search-main__categories',
        SUBMIT_BUTTON: '.modal-search-main__submit',
        NO_RESULTS_TEXT: '.modal-search-main__text',
        RESULTS_CONTAINER: '.modal-search-main__results',
        PROFILE_BUTTON: '.header__button-profile',
        SIGN_IN_MODAL: '.modal-auth',
        CATS_CONTAINER: '.modal-search-main__categories-wrapper',
    };

    const CLASSES = {
        MODAL_ACTIVE: 'modal-search-main_active',
        MODAL_MOBILE_ACTIVE: 'modal-search-mobile_active',
        SCROLL_LOCK: 'scroll-lock',
        TEXT_ACTIVE: 'modal-search-main__text_active',
        RESULTS_ACTIVE: 'modal-search-main__results_active',
        LOGO_SCROLLED: 'header__logo-swap_scrolled',
        LOGO_PINNED: 'header__logo-swap_pinned'
    };

    const MESSAGES = {
        NO_RESULTS: 'По вашему запросу ничего не найдено',
        ENTER_QUERY: 'Введите название или артикул',
        SHOW_ALL: 'Показать все {0} товаров'
    };

    // Search Bar Toggle
    function searchBarToggle() {
        const searchInput = document.querySelector(SELECTORS.SEARCH_INPUT);
        const searchInputFocus = document.querySelector(SELECTORS.SEARCH_INPUT_FOCUS);
        const searchModal = document.querySelector(SELECTORS.SEARCH_MODAL);
        const searchModalMobile = document.querySelector(SELECTORS.SEARCH_MODAL_MOBILE);
        const modalOverlay = document.querySelector(SELECTORS.MODAL_OVERLAY);
        const searchButtonMobile = document.querySelector(SELECTORS.SEARCH_BUTTON_MOBILE);

        if (!searchInput || !searchInputFocus || !searchModal || !searchModalMobile || !modalOverlay || !searchButtonMobile) {
            return;
        }

        searchInputFocus.addEventListener('focus', () => {
            if (!searchModal.classList.contains(CLASSES.MODAL_ACTIVE)) {
                searchModal.classList.add(CLASSES.MODAL_ACTIVE);
                document.body.classList.add(CLASSES.SCROLL_LOCK);
            }
        });

        searchInput.addEventListener('click', () => {
            if (!searchModal.classList.contains(CLASSES.MODAL_ACTIVE)) {
                searchModal.classList.add(CLASSES.MODAL_ACTIVE);
                document.body.classList.add(CLASSES.SCROLL_LOCK);
            }
        });

        searchButtonMobile.addEventListener('click', () => {
            if (!searchModalMobile.classList.contains(CLASSES.MODAL_MOBILE_ACTIVE)) {
                searchModalMobile.classList.add(CLASSES.MODAL_MOBILE_ACTIVE);
                document.body.classList.add(CLASSES.SCROLL_LOCK);
            }
        });

        modalOverlay.addEventListener('click', closeSearchModal);

        document.addEventListener('click', (event) => {
            if (searchModal.classList.contains(CLASSES.MODAL_ACTIVE) &&
                !searchModal.contains(event.target) && !searchInput.contains(event.target)) {
                closeSearchModal();
            }
        });

        document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape' && searchModal.classList.contains(CLASSES.MODAL_ACTIVE)) {
                closeSearchModal();
            }
        });

        function closeSearchModal() {
            searchModal.classList.remove(CLASSES.MODAL_ACTIVE);
            document.body.classList.remove(CLASSES.SCROLL_LOCK);
        }
    }

    // Header Scroll Handler
    function headerScrollHandler() {
        let prevScrollPos = 0;
        let visible = true;
        let atTop = true;

        const logoBlock = document.querySelector(SELECTORS.LOGO_BLOCK);

        if (!logoBlock) {
            return;
        }

        function handleScroll() {
            const currentScrollPos = window.scrollY;
            visible = prevScrollPos > currentScrollPos || currentScrollPos < 10;
            atTop = currentScrollPos <= 40;
            prevScrollPos = currentScrollPos;

            logoBlock.className = `header__logo-swap ${atTop ? '' : CLASSES.LOGO_SCROLLED} ${!atTop && visible ? CLASSES.LOGO_PINNED : ''}`;
        }

        window.addEventListener('scroll', handleScroll);
    }

    // Search Functionality
    async function fetchSearchItems(q) {
        try {
            const response = await new Promise((resolve, reject) => {
                api.search.products(q, (data, error) => {
                    if (error) reject(error);
                    else resolve(data);
                });
            });
            updateHTML(response.items, response.cats, response.tot);
        } catch (error) {
            console.error('Fetch error:', error);
            updateHTML([], [], 0, true);
        }
    }

    function updateHTML(items, cats, totalItems, error = false) {
        const itemsList = document.querySelector(SELECTORS.ITEMS_LIST);
        const catsList = document.querySelector(SELECTORS.CATS_LIST);
        const submitButton = document.querySelector(SELECTORS.SUBMIT_BUTTON);
        const noResultsText = document.querySelector(SELECTORS.NO_RESULTS_TEXT);
        const resultsContainer = document.querySelector(SELECTORS.RESULTS_CONTAINER);
        const catsContainer = document.querySelector(SELECTORS.CATS_CONTAINER);

        if (!itemsList || !catsList || !submitButton || !noResultsText || !resultsContainer) {
            return;
        }

        itemsList.innerHTML = '';
        catsList.innerHTML = '';

        if (cats.length === 0) {
            catsContainer.style.display = 'none';
        } else {
            catsContainer.style.display = '';
        }

        if (error) {
            noResultsText.textContent = MESSAGES.NO_RESULTS;
            noResultsText.classList.add(CLASSES.TEXT_ACTIVE);
            resultsContainer.classList.remove(CLASSES.RESULTS_ACTIVE);
        } else if (items.length === 0 && cats.length === 0) {
            noResultsText.textContent = MESSAGES.NO_RESULTS;
            noResultsText.classList.add(CLASSES.TEXT_ACTIVE);
            resultsContainer.classList.remove(CLASSES.RESULTS_ACTIVE);
        } else {
            noResultsText.classList.remove(CLASSES.TEXT_ACTIVE);
            resultsContainer.classList.add(CLASSES.RESULTS_ACTIVE);
            submitButton.textContent = MESSAGES.SHOW_ALL.replace('{0}', totalItems);

            const itemsFragment = document.createDocumentFragment();
            items.forEach(item => {
                const listItem = document.createElement('li');
                listItem.classList.add('modal-search-main__item');
                listItem.innerHTML = `
                <a href="${item.path}" class="modal-search-main__link" draggable="false">
                    <span>${item.name}</span>
                    <svg xmlns="http://www.w3.org/2000/svg" fill="#404040" viewBox="0 0 24 24" aria-hidden="true">
                        <path fill-rule="evenodd" d="M9.793 16.207a1 1 0 0 1 0-1.414l2.293-2.293-2.293-2.293a1 1 0 0 1 1.414-1.414l3 3a1 1 0 0 1 0 1.414l-3 3a1 1 0 0 1-1.414 0Z" clip-rule="evenodd"/>
                    </svg>
                </a>
            `;
                itemsFragment.appendChild(listItem);
            });
            itemsList.appendChild(itemsFragment);

            const catsFragment = document.createDocumentFragment();
            cats.forEach(cat => {
                const listItem = document.createElement('li');
                listItem.classList.add('modal-search-main__category');
                listItem.innerHTML = `
                <a href="${cat.path}" class="modal-search-main__link" draggable="false">
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
        return function(...args) {
            clearTimeout(timeoutId);
            timeoutId = setTimeout(() => func(...args), delay);
        };
    }

    function initSearchInput() {
        const searchInput = document.getElementById('search-input');
        const noResultsText = document.querySelector(SELECTORS.NO_RESULTS_TEXT);
        const resultsContainer = document.querySelector(SELECTORS.RESULTS_CONTAINER);

        if (!searchInput || !noResultsText || !resultsContainer) {
            return;
        }

        searchInput.addEventListener('focus', () => {
            const query = searchInput.value;
            if (query) {
                fetchSearchItems(query);
            } else {
                noResultsText.textContent = MESSAGES.ENTER_QUERY;
                noResultsText.classList.add(CLASSES.TEXT_ACTIVE);
                resultsContainer.classList.remove(CLASSES.RESULTS_ACTIVE);
            }
        });

        searchInput.addEventListener('input', debounce((event) => {
            const query = event.target.value;
            if (query) {
                fetchSearchItems(query);
            } else {
                noResultsText.textContent = MESSAGES.ENTER_QUERY;
                noResultsText.classList.add(CLASSES.TEXT_ACTIVE);
                resultsContainer.classList.remove(CLASSES.RESULTS_ACTIVE);
            }
        }, 300));
    }

    function initProfileButton() {
        const profileButton = document.querySelector(SELECTORS.PROFILE_BUTTON);
        const signInModal = document.querySelector(SELECTORS.SIGN_IN_MODAL);

        if (profileButton && signInModal) {
            profileButton.addEventListener('click', () => signInModal.showModal());
        }
    }

    function init() {
        searchBarToggle();
        headerScrollHandler();
        initSearchInput();
        initProfileButton();
    }

    document.addEventListener('DOMContentLoaded', init);
})();