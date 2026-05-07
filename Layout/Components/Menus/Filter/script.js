/**
 * Модуль для обработки функциональности меню фильтров.
 * @module filterMenusHandler
 */

/**
 * Главная функция для обработки функциональности меню фильтров.
 * Инициализирует все элементы управления и устанавливает обработчики событий.
 * @function
 */
const filterMenusHandler = () => {
    // Получаем основной элемент меню фильтров
    const menu = document.querySelector('.filter-menu');
    if (!menu) return;

    /**
     * Объект, содержащий ссылки на ключевые элементы интерфейса.
     * @type {Object.<string, HTMLElement>}
     */
    const elements = {
        menuButtonClose: menu.querySelector('.filter-menu__btn-close'),
        menuButtonOpen: document.querySelector('.catalog-box__filters-button'),
        submit: menu.querySelector('.filter-menu__btn-submit.main'),
        form: menu.querySelector('.filter-menu__content'),
        priceReset: menu.querySelector('.d-filter-menu__reset'),
        priceMin: menu.querySelector('input[name="price_min"]'),
        priceMax: menu.querySelector('input[name="price_max"]'),
        resetButtons: document.querySelectorAll('.filter-menu__reset'),
        submitButtons: menu.querySelectorAll('.filter-menu__btn-submit')
    };

    // Проверяем наличие всех необходимых элементов
    if (!Object.values(elements).every(Boolean)) return;

    /**
     * Обновляет URL страницы на основе данных формы.
     * @param {FormData} formData - Данные формы для обновления URL
     */
    const updateURL = (formData) => {
        // Формируем строку запроса из данных формы
        const queryParams = Array.from(formData.entries())
            .filter(([, value]) => value)
            .map(([key, value]) => `${encodeURIComponent(key)}=${encodeURIComponent(value)}`);

        // Создаем новый URL с параметрами и хэшем
        const newUrl = `${window.location.pathname}?${queryParams.join('&')}#${new URLSearchParams(formData).toString()}`;

        // Обновляем историю браузера
        history.pushState(null, '', newUrl);
    };

    /** Закрывает меню фильтров. */
    const closeFilterMenu = () => {
        menu.classList.remove('filter-menu_active');
        document.body.classList.remove("scroll-lock");
    };

    // Добавляем обработчик отправки формы
    elements.form.addEventListener('submit', (e) => {
        e.preventDefault();
        const formData = new FormData(elements.form);

        // Вызываем API для подсчета результатов
        api.catalog.count(formData, () => {});
        updateURL(formData);
        closeFilterMenu();
        window.location.reload();
    });

    /** Восстанавливает состояние формы из URL. */
    const restoreFormState = () => {
        // Получаем параметры из хэша URL
        const urlParams = new URLSearchParams(window.location.hash.slice(1));

        // Устанавливаем значения полей формы
        elements.form.querySelectorAll('input').forEach((input) => {
            const value = urlParams.get(input.name);
            if (value) {
                if (input.type === 'checkbox' || input.type === 'radio') {
                    input.checked = input.value === value;
                } else {
                    input.value = value;
                }
            }
        });
    };

    /** Обновляет видимость кнопок сброса и отправки формы. */
    const updateResetAndSubmitButtons = () => {
        const allInputs = menu.querySelectorAll('input');

        // Проверяем, есть ли несохраненные изменения
        const hasUnsavedChanges = Array.from(allInputs).some(input =>
            ((input.type === 'checkbox' || input.type === 'radio') && input.checked !== input.defaultChecked) ||
            ((input.type === 'text' || input.type === 'number') && input.value.trim() !== input.defaultValue.trim())
        );

        // Обновляем видимость кнопок сброса
        elements.resetButtons.forEach(button => {
            button.style.opacity = hasUnsavedChanges ? '1' : '0';
            button.style.visibility = hasUnsavedChanges ? 'visible' : 'hidden';
        });

        // Обновляем текст кнопок отправки
        elements.submitButtons.forEach(button => {
            button.textContent = hasUnsavedChanges ? 'Применить' : 'Закрыть';
        });
    };

    /** Обновляет видимость кнопки сброса цены. */
    const updatePriceButtons = () => {
        const hasPriceValue = elements.priceMin.value.trim() !== '' || elements.priceMax.value.trim() !== '';
        elements.priceReset.style.opacity = hasPriceValue ? '1' : '0';
        updateResetAndSubmitButtons();
    };

    /**
     * Обновляет видимость контейнера тегов.
     * @param {HTMLElement} tagContainer - Контейнер тегов
     */
    const updateTagVisibility = (tagContainer) => {
        if (tagContainer) {
            const visibleTags = tagContainer.querySelectorAll('.tag-filter[data-tag]:not([style*="display: none"])');
            tagContainer.style.display = visibleTags.length > 0 ? '' : 'none';
        }
    };

    /**
     * Синхронизирует состояние чекбокса с тегом.
     * @param {string} paramName - Имя параметра
     * @param {string} tagValue - Значение тега
     */
    const syncCheckboxWithTag = (paramName, tagValue) => {
        const inputs = elements.form.querySelectorAll(`input[name="${paramName}"]`);
        inputs.forEach(input => {
            if (input.value === tagValue || input.value === decodeURIComponent(tagValue)) {
                input.checked = false;
                input.dispatchEvent(new Event('change', { bubbles: true }));
            }
        });
    };

    /**
     * Добавляет новый тег в контейнер тегов.
     * @param {HTMLInputElement} input - Связанный с тегом инпут
     * @param {HTMLElement} tagContainer - Контейнер тегов
     */
    const addTag = (input, tagContainer) => {
        // Проверяем, не существует ли уже такой тег
        if (tagContainer.querySelector(`[data-tag="${input.value}"]`)) return;

        // Получаем текст для тега
        const tagText = input.closest('.checkbox-mobile-list__check').querySelector('.checkbox__text').textContent.trim();

        // Создаем новый тег
        const newTag = document.createElement('div');
        newTag.className = 'tag-filter tag-filter_style-red';
        newTag.dataset.tag = input.value;
        newTag.innerHTML = `
            <span class="tag-filter__text">${tagText}</span>
            <i class="tag-filter__icon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.29289 5.29289C5.68342 4.90237 6.31658 4.90237 6.70711 5.29289L12 10.5858L17.2929 5.29289C17.6834 4.90237 18.3166 4.90237 18.7071 5.29289C19.0976 5.68342 19.0976 6.31658 18.7071 6.70711L13.4142 12L18.7071 17.2929C19.0976 17.6834 19.0976 18.3166 18.7071 18.7071C18.3166 19.0976 17.6834 19.0976 17.2929 18.7071L12 13.4142L6.70711 18.7071C6.31658 19.0976 5.68342 19.0976 5.29289 18.7071C4.90237 18.3166 4.90237 17.6834 5.29289 17.2929L10.5858 12L5.29289 6.70711C4.90237 6.31658 4.90237 5.68342 5.29289 5.29289Z" fill="white"></path>
                </svg>
            </i>
        `;

        // Добавляем обработчик клика для удаления тега
        newTag.addEventListener('click', (event) => {
            event.stopPropagation();
            removeTag(newTag);
        });

        // Добавляем тег в контейнер
        tagContainer.insertAdjacentElement('afterbegin', newTag);
        updateTagVisibility(tagContainer);
    };

    /**
     * Удаляет тег и обновляет URL.
     * @param {HTMLElement} tag - Тег для удаления
     */
    const removeTag = (tag) => {
        const currentParams = new URLSearchParams(window.location.search);
        const tagContainer = tag.closest('.tab-filter-m__tags');
        const paramName = tagContainer.dataset.tags;
        const tagValue = tag.dataset.tag;

        // Удаляем параметр из URL
        if (paramName.startsWith('param_')) {
            const encodedValue = encodeURIComponent(tagValue).replace(/%20/g, '+').replace(/\//g, '%2F');
            currentParams.delete(paramName, encodedValue);
        } else if (paramName === 'brand[]') {
            currentParams.delete(paramName, encodeURIComponent(tagValue));
        }

        // Удаляем тег из DOM
        tag.remove();
        updateTagVisibility(tagContainer);

        // Обновляем URL
        const newUrl = `${window.location.pathname}?${currentParams.toString()}`;
        history.pushState(null, '', newUrl);

        // Синхронизируем состояние чекбокса
        syncCheckboxWithTag(paramName, tagValue);
        updateResetAndSubmitButtons();
    };

    /** Устанавливает обработчики событий для элементов формы. */
    const setupEventListeners = () => {
        // Обработчики для всех инпутов формы
        elements.form.querySelectorAll('input').forEach(input => {
            input.addEventListener('input', updateResetAndSubmitButtons);
            if (input.type === 'checkbox' || input.type === 'radio') {
                input.addEventListener('change', () => {
                    updateTagVisibility(document.querySelector(`[data-tags="${input.name}"]`));
                });
            }
        });

        // Обработчики для полей цены
        [elements.priceMin, elements.priceMax].forEach(input =>
            input.addEventListener('input', updatePriceButtons)
        );

        // Обработчик для кнопки сброса цены
        elements.priceReset.addEventListener('click', (e) => {
            e.preventDefault();
            elements.priceMin.value = elements.priceMax.value = '';
            updatePriceButtons();
        });

        // Обработчики для кнопок сброса
        elements.resetButtons.forEach(resetButton => {
            resetButton.addEventListener('click', (e) => {
                e.preventDefault();
                const categoryName = resetButton.dataset.category;
                const inputSelector = categoryName ? `input[name^="${categoryName}"]` : 'input';

                // Сбрасываем значения инпутов и удаляем соответствующие теги
                elements.form.querySelectorAll(inputSelector).forEach(input => {
                    if (input.type === 'checkbox' || input.type === 'radio') {
                        input.checked = false;
                    } else {
                        input.value = '';
                    }
                    const tagContainer = document.querySelector(`[data-tags="${input.name}"]`);
                    if (tagContainer) {
                        const tag = tagContainer.querySelector(`[data-tag="${input.value}"]`);
                        if (tag) tag.remove();
                        updateTagVisibility(tagContainer);
                    }
                });

                // Если это общий сброс, удаляем все теги
                if (!categoryName) {
                    document.querySelectorAll('.tag-filter[data-tag]').forEach(tag => tag.remove());
                    document.querySelectorAll('.tab-filter-m__tags').forEach(updateTagVisibility);
                }

                updateResetAndSubmitButtons();
                updatePriceButtons();
            });
        });

        // Обработчики для тегов сброса
        document.querySelectorAll('.tag-filter[data-reset="reset"]').forEach(resetTag => {
            resetTag.addEventListener('click', (e) => {
                e.stopPropagation();
                const categoryName = resetTag.closest('.tab-filter-m__tags').dataset.tags.replace('[]', '');
                elements.form.querySelectorAll(`input[name^="${categoryName}"]`).forEach(input => {
                    input.checked = false;
                    const tagContainer = document.querySelector(`[data-tags="${input.name}"]`);
                    if (tagContainer) {
                        const tag = tagContainer.querySelector(`[data-tag="${input.value}"]`);
                        if (tag) tag.remove();
                        updateTagVisibility(tagContainer);
                    }
                });
                updateResetAndSubmitButtons();
            });
        });

        // Обработчик для закрытия меню фильтров
        elements.menuButtonClose.addEventListener('click', closeFilterMenu);

        // Обработчик для открытия меню фильтров
        elements.menuButtonOpen.addEventListener('click', () => {
            menu.classList.add('filter-menu_active');
            document.body.classList.add("scroll-lock");
        });

        // Обработчики для удаления тегов
        document.querySelectorAll('.tab-filter-m__tags .tag-filter').forEach(tag => {
            tag.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                removeTag(tag);
            });
        });
    };

    /** Настраивает функциональность вкладок фильтров. */
    const setupTabs = () => {
        const tabs = document.querySelectorAll('.tab-filter-m');
        tabs.forEach(tab => {
            // Предотвращаем распространение события touchstart для тегов внутри вкладок
            tab.querySelectorAll('.tag-filter').forEach(tag => {
                tag.addEventListener('touchstart', (ev) => ev.stopPropagation(), { passive: true });
            });

            // Добавляем эффект нажатия для вкладок на мобильных устройствах
            ['touchstart', 'touchend'].forEach(event =>
                tab.addEventListener(event, () =>
                        tab.classList.toggle('tab-filter-m_pressed', event === 'touchstart'),
                    { passive: true }
                )
            );

            // Открываем подменю при клике на вкладку
            tab.addEventListener('click', () => tab.nextElementSibling.classList.add('active'));
        });
    };

    /** Настраивает функциональность подменю фильтров.*/
    const setupSubMenus = () => {
        const subMenus = document.querySelectorAll('.filter-menu.filter-sub-menu');
        subMenus.forEach(subMenu => {
            const closeBtn = subMenu.querySelector('.filter-menu__btn-close');
            const search = subMenu.querySelector('input[type="text"]');
            const selectors = subMenu.querySelectorAll('.filter-menu__selector');
            const subMenuSubmit = subMenu.querySelector('.filter-menu__btn-submit');

            if (!closeBtn || !subMenuSubmit) return;

            // Настройка функции поиска в подменю
            if (search) {
                search.addEventListener('input', () => {
                    const searchValue = search.value.toLowerCase();
                    selectors.forEach(selector => {
                        const checkboxText = selector.querySelector('.checkbox__text').textContent.toLowerCase();
                        selector.style.display = checkboxText.includes(searchValue) ? 'flex' : 'none';
                    });
                });
            }

            // Настройка обработчиков для селекторов (чекбоксов) в подменю
            selectors.forEach(selector => {
                const input = selector.querySelector('input');
                const tagContainer = document.querySelector(`[data-tags="${input.name}"]`);

                // Удаляем старый обработчик, если он существует
                input.removeEventListener('change', input.changeHandler);

                // Создаем новый обработчик изменения состояния чекбокса
                input.changeHandler = () => {
                    if (input.checked) {
                        addTag(input, tagContainer);
                    } else {
                        const tag = tagContainer.querySelector(`[data-tag="${input.value}"]`);
                        if (tag) removeTag(tag);
                    }
                    updateResetAndSubmitButtons();
                    updateTagVisibility(tagContainer);
                };

                // Добавляем новый обработчик
                input.addEventListener('change', input.changeHandler);
            });

            // Добавляем обработчики для кнопок закрытия и применения в подменю
            [subMenuSubmit, closeBtn].forEach(btn =>
                btn.addEventListener('click', (e) => {
                    e.preventDefault();
                    subMenu.classList.remove('active');
                    updateResetAndSubmitButtons();
                })
            );
        });
    };

    /** Инициализирует все компоненты меню фильтров. */
    const init = () => {
        restoreFormState();
        updateResetAndSubmitButtons();
        updatePriceButtons();
        document.querySelectorAll('.tab-filter-m__tags').forEach(updateTagVisibility);
        setupEventListeners();
        setupTabs();
        setupSubMenus();
    };

    // Запускаем инициализацию
    init();
};

document.addEventListener('DOMContentLoaded', filterMenusHandler);

/**
 * @typedef {Object} FilterMenuElements
 * @property {HTMLElement} menuButtonClose - Кнопка закрытия меню фильтров
 * @property {HTMLElement} menuButtonOpen - Кнопка открытия меню фильтров
 * @property {HTMLElement} submit - Основная кнопка отправки формы
 * @property {HTMLFormElement} form - Форма меню фильтров
 * @property {HTMLElement} priceReset - Кнопка сброса цены
 * @property {HTMLInputElement} priceMin - Поле ввода минимальной цены
 * @property {HTMLInputElement} priceMax - Поле ввода максимальной цены
 * @property {NodeList} resetButtons - Коллекция кнопок сброса
 * @property {NodeList} submitButtons - Коллекция кнопок отправки формы
 */

/**
 * @typedef {Object} Tag
 * @property {string} value - Значение тега
 * @property {string} text - Текст, отображаемый на теге
 */

/**
 * @typedef {Object} FilterState
 * @property {Object.<string, string|string[]>} params - Параметры фильтрации
 * @property {Tag[]} tags - Активные теги фильтров
 */