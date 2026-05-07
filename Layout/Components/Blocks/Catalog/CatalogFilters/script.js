/**
 * Обработчик событий для фильтров каталога и сортировки.
 * Инициализируется после полной загрузки DOM.
 */
document.addEventListener('DOMContentLoaded', () => {
    const filterForm = document.querySelector('.catalog-filters__form');

    if (!filterForm) return;

    const selectedCountWrap = document.querySelector('.catalog-filters__amount');
    const resetButton = selectedCountWrap.querySelector('.catalog-filters__reset');
    const selectedCount = selectedCountWrap.querySelector('.catalog-filters__selected');
    const hiddenInput = document.querySelector('input[type="hidden"]');
    const categoryItems = filterForm.querySelectorAll('.catalog-categories__item');
    const currentUrl = window.location.href;
    const applyBtn = document.querySelector('.js--apply');

    const modalQuantityText = document.querySelector('.modal-quantity__text');
    const modalQuantitySubmit = document.querySelector('.modal-quantity__button');
    const quantityModal = document.querySelector('.modal-quantity');
    let lastChangedInput = null;
    let hideModalTimeout;

    /**
     * Позиционирует модальное окно количества относительно input элемента.
     * @param {HTMLElement} input - Input элемент, относительно которого позиционируется модальное окно.
     */
    const positionModal = (input) => {
        const inputRect = input.getBoundingClientRect();
        const modalRect = quantityModal.getBoundingClientRect();

        quantityModal.style.position = 'absolute';

        quantityModal.style.top = `${inputRect.top + window.scrollY - 20}px`;

        const rightEdge = inputRect.right + 10 + modalRect.width;
        if (rightEdge > window.innerWidth) {
            quantityModal.style.left = `${inputRect.left - modalRect.width - 10}px`;
        }
    };

    /**
     * Показывает модальное окно количества и устанавливает таймер для его скрытия.
     */
    const showModal = () => {
        quantityModal.classList.add('modal-quantity_active');
        if (lastChangedInput) {
            positionModal(lastChangedInput);
        }

        if (hideModalTimeout) {
            clearTimeout(hideModalTimeout);
        }

        hideModalTimeout = setTimeout(() => {
            quantityModal.classList.remove('modal-quantity_active');
        }, 3000);
    };

    /**
     * Callback-функция для обновления текста в модальном окне количества.
     * @param {number|string} msg - Количество выбранных элементов или сообщение.
     */
    const quantityCallback = (msg) => {
        modalQuantityText.textContent = `${msg ? `Выбрано ${msg}` : 'Не найдено'}`;

        if (msg === 0) {
            modalQuantitySubmit.classList.add('modal-quantity__button_disabled');
        } else {
            modalQuantitySubmit.classList.remove('modal-quantity__button_disabled');
        }

    }

    /**
     * Проверяет начальное состояние фильтров и обновляет счетчик.
     */
    const checkInitialFilters = () => {
        const selectedFilters = filterForm.querySelectorAll('input:checked').length;
        selectedCount.textContent = selectedFilters;

        if (selectedFilters > 0) {
            selectedCountWrap.classList.add('visible');
        } else {
            selectedCountWrap.classList.remove('visible');
        }
    };

    checkInitialFilters();

    /**
     * Обновляет счетчик выбранных фильтров и показывает модальное окно.
     */
    const updateCount = () => {
        const selectedFilters = filterForm.querySelectorAll('input:checked').length;
        selectedCount.textContent = selectedFilters;

        if (selectedFilters > 0) {
            selectedCountWrap.classList.add('visible');
        } else {
            selectedCountWrap.classList.remove('visible');
        }

        if (selectedFilters > 0) {
            showModal();
        } else {
            quantityModal.classList.remove('modal-quantity_active');
        }

        const fd = new FormData(filterForm);
        api.catalog.count(fd, quantityCallback);
    };

    /**
     * Сбрасывает все фильтры в исходное состояние.
     */
    const resetFilters = () => {
        const inputs = filterForm.querySelectorAll(
            'input[type="checkbox"], input[type="radio"]');
        inputs.forEach(input => {
            input.checked = false;
        });
        selectedCountWrap.classList.remove('visible');
        selectedCount.textContent = '0';
    };

    /**
     * Обработчик клика по кнопке "Применить".
     * Формирует URL с параметрами фильтров и перенаправляет на него.
     */
    applyBtn.addEventListener('click', () => {
        const fd = new FormData(filterForm);

        let is = [];
        for (const kv of fd.entries()) {
            is.push(`${kv[0]}=${encodeURIComponent(kv[1])}`);
        }

        const q = is.join('&');
        location.href = `${location.origin}${location.pathname}?${q}`;
    });

    /**
     * Обработчик клика по кнопке "Применить" в модальном окне количества.
     * Формирует URL с параметрами фильтров и перенаправляет на него.
     */
    modalQuantitySubmit.addEventListener('click', () => {
        const fd = new FormData(filterForm);

        let is = [];
        for (const kv of fd.entries()) {
            is.push(`${kv[0]}=${encodeURIComponent(kv[1])}`);
        }

        const q = is.join('&');
        location.href = `${location.origin}${location.pathname}?${q}`;
    });

    /**
     * Обработчик отправки формы фильтров.
     * Предотвращает стандартную отправку и обновляет счетчик.
     */
    filterForm.addEventListener('submit', (event) => {
        event.preventDefault();
        const form = event.target;
        const formData = new FormData(form)

        api.catalog.count(formData, quantityCallback)

        updateCount();
    });

    /**
     * Обработчик клика по кнопке "Применить" в форме фильтров.
     */
    const applyButton = document.querySelector('.catalog-filters__apply-button');
    applyButton.addEventListener('click', () => {
        updateCount();
    });

    /**
     * Обработчик клика по кнопке "Сбросить".
     */
    resetButton.addEventListener('click', () => {
        resetFilters();
        updateCount();
    });

    /**
     * Инициализация обработчиков изменения состояния чекбоксов и радиокнопок.
     */
    const inputs = filterForm.querySelectorAll(
        'input[type="checkbox"], input[type="radio"]');
    inputs.forEach(input => {
        input.addEventListener('change', (event) => {
            lastChangedInput = event.target;
            updateCount();
        });
    });

    /**
     * Инициализирует сортировку в выпадающем списке.
     * @param {HTMLElement} parent - Родительский элемент выпадающего списка.
     */
    const sort = (parent) => {
        const sortItems = parent.querySelectorAll('.dropdown__option');
        const sortText = parent.querySelector('.dropdown__input');

        const urlParams = new URLSearchParams(window.location.search);

        if (urlParams.has('sort')) {
            const sortValue = urlParams.get('sort');
            const selectedOption = parent.querySelector(
                `.dropdown__option[data-value="${sortValue}"]`);
            if (selectedOption) {
                sortText.value = selectedOption.textContent.trim();
            }
        }

        sortItems.forEach(item => {
            item.addEventListener('click', () => {
                const value = item.dataset.value;

                urlParams.set('sort', value);
                window.location.href = '?' + urlParams.toString();
            });
        });
    };

    const sortDropdown = document.querySelector('.dropdown');
    sort(sortDropdown);

    /**
     * Инициализация обработчиков для элементов категорий.
     */
    categoryItems.forEach(item => {
        const link = item.querySelector('.catalog-categories__link');
        const linkUrl = link.getAttribute('href');

        if (currentUrl === linkUrl) {
            item.classList.add('catalog-categories__item_active');
        }

        link.addEventListener('click', (event) => {
            event.preventDefault();

            categoryItems.forEach(item => {
                item.classList.remove('catalog-categories__item_active');
            });

            item.classList.add('catalog-categories__item_active');

            const pageUrl = link.getAttribute('href');

            window.location.href = pageUrl;
        });
    });
});
