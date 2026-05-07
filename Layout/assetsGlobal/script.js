document.addEventListener('DOMContentLoaded', () => {
    // ---------------- modals
    const showModal = (dialog) => {
        dialog.classList.add('open-modal');
    };

    const closeModal = (dialog) => {
        dialog.classList.remove('open-modal');
    };

    const closeOnBackDropClick = ({currentTarget, target}, dialogSelector) => {
        const dialog = currentTarget;
        const backDrop = dialogSelector + '__mask';
        const isClickedOnBackDrop = target.classList.contains(backDrop.slice(1));

        if (isClickedOnBackDrop) {
            close(dialog);
            returnScroll();
        }
    };

    const openModalAndLockScroll = (dialog) => {
        showModal(dialog);
        document.body.classList.add('scroll-lock');
    };

    const returnScroll = () => {
        document.body.classList.remove('scroll-lock');
    };

    const close = (dialog) => {
        closeModal(dialog);
        returnScroll();
    };

    window.initModal = function initModal(dialogSelector, dialogOpenerSelector, dialogCloserSelector) {
        const dialog = document.querySelector(dialogSelector);
        const dialogOpener = document.querySelector(dialogOpenerSelector);

        if (!dialog || !dialogOpener) return;

        const dialogCloser = dialog.querySelector(dialogCloserSelector);

        dialog.addEventListener('click', (event) => {
            closeOnBackDropClick(event, dialogSelector);
        });

        dialogOpener.addEventListener('click', () => {
            openModalAndLockScroll(dialog);
        });

        dialogCloser.addEventListener('click', (event) => {
            event.stopPropagation();
            close(dialog);
        });
    };

    // ---------------- end modals
    // ----------------
    // ----------------
    // ---------------- parallax
    window.addParallaxEffect = function addParallaxEffect(elem, speedX, speedY) {
        if (!elem) return;

        window.addEventListener('mousemove', function (e) {
            let x = e.clientX / (window.innerWidth * 2);
            let y = e.clientY / window.innerHeight;
            elem.style.transform = 'translate(-' + x * speedX + 'px, -' + y * speedY + 'px)';
        });
    };

    window.addReverseParallaxEffect = function addReverseParallaxEffect(elem, speedX, speedY) {
        if (!elem) return;

        window.addEventListener('mousemove', function (e) {
            let x = e.clientX / (window.innerWidth * 2);
            let y = e.clientY / window.innerHeight;
            elem.style.transform = 'translate(' + x * speedX + 'px, ' + y * speedY + 'px)';
        });
    };

    // ---------------- end parallax

    // ---------------- api

    window.number_format = function (number, decimals, dec_point, thousands_sep) {
        // Strip all characters but numerical ones.
        number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
        let n = !isFinite(+number) ? 0 : +number,
            prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
            sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
            dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
            s = '',
            toFixedFix = function (n, prec) {
                var k = Math.pow(10, prec);
                return '' + Math.round(n * k) / k;
            };
        // Fix for IE parseFloat(0.55).toFixed(0) = 0;
        s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
        if (s[0].length > 3) {
            s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
        }
        if ((s[1] || '').length < prec) {
            s[1] = s[1] || '';
            s[1] += new Array(prec - s[1].length + 1).join('0');
        }
        return s.join(dec);
    };

    window.format_price = function (num) {
        return number_format(num, 0, '.', ' ') + ' ₽';
    };

    window.api = {
        catalog: {
            count: function (fd, callback) {
                let str = window.location.href.toString();
                if (str.includes('?')) {
                    str += '&';
                } else {
                    str += '?';
                }

                fetch(str + 'action=count', {
                    method: 'POST',
                    body: fd,
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                }).then(res => res.text()).then(response => {
                    if (callback) {
                        callback(response);
                    }
                });
            },
            getProductLevels: function (callback) {
                let str = window.location.href.toString();
                if (str.includes('?')) {
                    str += '&';
                } else {
                    str += '?';
                }
                fetch(str + 'action=levels', {
                    method: 'POST',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                }).then(res => res.json()).then(response => {
                    if (callback) {
                        callback(response);
                    }
                });
            }
        },
        favorite: {
            add: function (id, variant_id, callback) {
                fetch(`/fav/?action=add&id=${id}&var=${variant_id}`, {
                    method: 'POST',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                    .then((response) => response.json())
                    .then((data) => {
                        if (callback) {
                            callback(data);
                        }
                    });
            },

            remove: function (id, variant_id, callback) {
                fetch(`/fav/?action=remove&id=${id}&var=${variant_id}`, {
                    method: 'POST',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                    .then((response) => response.json())
                    .then((data) => {
                        if (callback) {
                            callback(data);
                        }
                    });
            }
        },
        search: {
            city: function (q, callback) {
                fetch(`/qs/?a=city&q=${q}`, {
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                    .then((response) => response.json())
                    .then((data) => {
                        if (callback) {
                            callback(data);
                        }
                    });
            },
            products: function (q, callback) {
                fetch(`/qs/?a=products&q=${q}`, {
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                    .then((response) => response.json())
                    .then((data) => {
                        if (callback) {
                            callback(data);
                        }
                    });
            },
        },
        cart: {
            update: function (id, variant_id, qty, callback) {
                fetch(`/cart/?action=updateCart&product_id=${id}&variant_id=${variant_id}&qty=${qty}`, {
                    method: 'POST',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                    .then((response) => response.json())
                    .then((data) => {
                        if (callback) {
                            callback(data);
                        }
                    });
            },
            remove: function (id, variant_id, callback) {
                fetch(`/cart/?action=removeFromCart&product_id=${id}&variant_id=${variant_id}`, {
                    method: 'POST',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                    .then((response) => response.json())
                    .then((data) => {
                        if (callback) {
                            callback(data);
                        }
                    });
            },
            get: function (callback) {
                fetch(`/cart/?action=getCartInfo`, {
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                    .then((response) => response.json())
                    .then((data) => {
                        if (callback) {
                            callback(data);
                        }
                    });
            }
        },
        auth: {
            login: function (login, pw, callback) {
                const fd = new FormData();
                fd.append('phone', login);
                fd.append('pwd', pw);

                fetch('/auth/?action=login', {
                    method: 'POST',
                    body: fd,
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                }).then((response) => response.json())
                    .then((data) => {
                        if (callback) {
                            callback(data);
                        }
                    });
            },

            register: function (last_name, name, email, phone, pwd, callback) {
                const fd = new FormData();
                fd.append('last_name', last_name);
                fd.append('name', name);
                fd.append('email', email);
                fd.append('phone', phone);
                fd.append('pwd', pwd);

                fetch('/auth/?action=register', {
                    method: 'POST',
                    body: fd,
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                }).then((response) => response.json())
                    .then((data) => {
                        if (callback) {
                            callback(data);
                        }
                    });
            },

            resendMail: function (callback) {
                fetch('/auth/?action=resendMail', {
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                }).then((response) => response.json())
                    .then((data) => {
                        if (callback) {
                            callback(data);
                        }
                    });
            },

            reset: function (email, callback) {
                fetch(`/auth/?action=reset&email=${email}`, {
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                }).then(r => r.json()).then(d => {
                    if (callback) {
                        callback(d);
                    }
                });
            }
        },
        user: {
            findOrg: function (q, callback) {
                fetch('/user/?action=onFindCompany&q=' + q, {
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                }).then(r => r.json()).then(d => {
                    if (callback) {
                        callback(d);
                    }
                });
            },
            updateDelivery: function (fd, callback) {
                fetch('/user/order/delivery/', {
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    method: 'POST',
                    body: fd,
                }).then(r => r.json()).then(d => {
                    if (callback) {
                        callback(d);
                    }
                });
            },
            makeQuestion: function (message, callback) {
                const fd = new FormData();
                fd.append('question', message);
                fetch('/question/', {
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    method: 'POST',
                    body: fd,
                }).then(r => r.json()).then(d => {
                    if (callback) {
                        callback(d);
                    }
                });
            },
            orderCancel: function (id) {
                const fd = new FormData();
                fd.append('order_id', id);

                fetch('/user/order/cancel/', {
                    method: 'POST',
                    body: fd,
                }).then(() => {

                });
            }
            // refund: async function (id, comment) {
            //     const fd = new FormData();
            //     fd.append('id', id);
            //     fd.append('comment', comment);
            //
            //     return await fetch(`/refund/`, {
            //         method: "POST",
            //         body: fd,
            //     });
            // }
        }
    };
// ---------------- end api
});

// ---------------- catalog menu button handler
const catalogMenuHandler = () => {
    let activeContainer = null;

    function toggleIcons(button) {
        const iconDefault = button.querySelector('.nav__button-icon');
        const iconActive = button.querySelector('.nav__button-icon--active');
        if (iconDefault && iconActive) {
            iconDefault.classList.toggle('hidden');
            iconActive.classList.toggle('hidden');
        }
    }

    function toggleCatalog(container, isActive) {
        const button = container.querySelector('.nav__button');
        const modal = container.querySelector('.modal-catalog-menu');

        button.classList.toggle('nav__catalog-btn--active', isActive);
        toggleIcons(button);
        document.body.classList.toggle('scroll-lock', isActive);

        if (modal) {
            if (isActive) {
                activeContainer = container;
                modal.style.display = 'block';
                modal.querySelector('.modal-catalog-menu__overlay').addEventListener('click', closeModal);
            } else {
                modal.style.display = 'none';
                modal.querySelector('.modal-catalog-menu__overlay').removeEventListener('click', closeModal);
                activeContainer = null;
            }
        }
    }

    function closeModal() {
        if (activeContainer) {
            toggleCatalog(activeContainer, false);
        }
    }

    document.querySelectorAll('.catalog-button').forEach(container => {
        const button = container.querySelector('.nav__button');
        button.addEventListener('click', function (event) {
            event.stopPropagation();
            const isActive = !this.classList.contains('nav__catalog-btn--active');
            if (activeContainer && activeContainer !== container) {
                toggleCatalog(activeContainer, false);
            }
            toggleCatalog(container, isActive);
        });
    });
}

document.addEventListener('DOMContentLoaded', catalogMenuHandler);
// ---------------- end catalog menu button handler

// ---------------- auth onclick
const logout = () => {
    window.location.href = '/auth/?action=logout';
    // localStorage.clear();
}

const logoutModal = (event) => {
    const modal = document.querySelector('.modal-logout');
    modal.showModal();
};

// ---------------- vibration api
document.addEventListener('DOMContentLoaded', function () {
    const buttons = document.querySelectorAll('.vibrate-button');

    if ('vibrate' in navigator) {
        buttons.forEach(button => {
            button.addEventListener('click', function () {
                window.navigator?.vibrate?.(50);
            });
        });
    }
});

/**
 * A class to interact with Yandex Metrika for tracking events.
 * It automatically detects the Yandex Metrika counter ID from the page
 * or uses a default if not found.
 * @example tracker.track('event_name');
 * @class
 */
class YandexMetrikaTracker {
    /**
     * Private property to store the cached counter ID.
     * @private
     * @type {string|null}
     */
    #counterId = null;

    /**
     * The default counter ID to use if no ID is found on the page.
     * This can be overridden by the user.
     * @public
     * @type {string}
     */
    defaultCounterId = '105906625';

    /**
     * Flag to enable or disable logging.
     * Set to `false` to suppress console logs.
     * @public
     * @type {boolean}
     */
    enableLogging = true;

    /**
     * Internal method to log messages conditionally based on `enableLogging`.
     * @private
     * @param {string} level - The console log level (e.g., 'warn', 'error').
     * @param {string} message - The message to log.
     * @param {...any} args - Additional arguments to log.
     */
    #log(level, message, ...args) {
        if (this.enableLogging) {
            console[level](message, ...args);
        }
    }

    /**
     * Retrieves or finds the Yandex Metrika counter ID.
     * It first checks if the ID is already cached. If not, it attempts to find it
     * from the page's `<noscript>` or `<script>` tags. If still not found, it uses
     * the `defaultCounterId`.
     *
     * @public
     * @returns {string} The Yandex Metrika counter ID.
     */
    findCounterId() {
        if (this.#counterId) {
            return this.#counterId;
        }
        this.#counterId = this.#findIdFromNoscript() || this.#findIdFromScripts();
        if (!this.#counterId) {
            this.#log('warn', `[Yandex Metrika] Counter ID not found. Using default ID ${this.defaultCounterId}.`);
            this.#counterId = this.defaultCounterId;
        }
        return this.#counterId;
    }

    /**
     * Searches for the counter ID in `<noscript>` tags containing Yandex Metrika image URLs.
     * @private
     * @returns {string|null} The counter ID if found, otherwise null.
     */
    #findIdFromNoscript() {
        const noscriptImg = document.querySelector('noscript img[src*="mc.yandex.ru/watch/"]');
        if (noscriptImg) {
            const match = noscriptImg.src.match(/watch\/(\d+)/);
            return match ? match[1] : null;
        }
        return null;
    }

    /**
     * Searches for the counter ID in `<script>` tags that initialize Yandex Metrika.
     * Looks for patterns like `ym(counterId, "init")`.
     * @private
     * @returns {string|null} The counter ID if found, otherwise null.
     */
    #findIdFromScripts() {
        const scripts = document.querySelectorAll('script');
        for (const script of scripts) {
            const content = script.textContent || script.innerText;
            if (content.includes('ym(') && content.includes('"init"')) {
                const match = content.match(/ym\((\d+),\s*"init"/);
                if (match) {
                    return match[1];
                }
            }
        }
        return null;
    }

    /**
     * Tracks an event using Yandex Metrika's `reachGoal` method.
     * It ensures the `ym` function is available and uses the counter ID to track the event.
     *
     * @public
     * @param {string} eventName - The name of the event to track.
     * @returns {boolean} True if the event was successfully tracked, false otherwise.
     */
    track(eventName) {
        try {
            if (typeof window === 'undefined' || typeof window.ym !== 'function') {
                this.#log('error', '[Yandex Metrika] ym function is not available.');
                return false;
            }
            const counterId = this.findCounterId();
            window.ym(counterId, 'reachGoal', eventName);
            this.#log('warn', `Event '${eventName}' tracked with counter ID ${counterId}.`);
            return true;
        } catch (error) {
            this.#log('error', '[Yandex Metrika] Error tracking event:', error);
            return false;
        }
    }
}
const tracker = new YandexMetrikaTracker();

// Modal Handler
function openModal(modalId) {
    if (!modalId) {
        return;
    } else {
        const modalOverlays = document.querySelectorAll(`[data-modal="${modalId}"]`);
        modalOverlays.forEach(overlay => {
            overlay.classList.add('open-modal');
        })

        const modals = document.querySelectorAll(`[data-modal-content="${modalId}"]`);
        modals.forEach(modal => {
            modal.classList.add('opened');
        })
        document.body.classList.add('scroll-lock');
    }
}

function closeModal(modalId) {
    const modalOverlays = document.querySelectorAll(`[data-modal="${modalId}"]`);
    modalOverlays.forEach(overlay => {
        overlay.classList.remove('open-modal');
    })

    const modals = document.querySelectorAll(`[data-modal-content="${modalId}"]`);
    modals.forEach(modal => {
        modal.classList.remove('opened');
    })
    document.body.classList.remove('scroll-lock');
}

function handleOverlayClick(e, modalId) {
    const modalOverlay = document.querySelector(`[data-modal="${modalId}"]`);
    if (e.target === modalOverlay) {
        closeModal(modalId);
    }
}

document.querySelectorAll('[data-open]').forEach(button => {
    button.addEventListener('click', () => {
        const modalId = button.getAttribute('data-open');
        openModal(modalId);
    });
});

document.querySelectorAll('[data-close]').forEach(button => {
    button.addEventListener('click', () => {
        const modalId = button.getAttribute('data-close');
        closeModal(modalId);
    });
});

document.querySelectorAll('[data-modal]').forEach(modalOverlay => {
    const modalId = modalOverlay.getAttribute('data-modal');
    modalOverlay.addEventListener('click', (e) => {
        handleOverlayClick(e, modalId);
    });
});

// ------------------- lazy-load
document.addEventListener('DOMContentLoaded', () => {
    const lazyImages = document.querySelectorAll('.lazy-image');

    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    loadImage(entry.target);
                    observer.unobserve(entry.target);
                }
            });
        });

        lazyImages.forEach(img => imageObserver.observe(img));
    } else {
        // Fallback for browsers that don't support IntersectionObserver
        lazyImages.forEach(img => loadImage(img));
    }
});

function loadImage(img) {
    const src = img.dataset.src;

    img.onload = () => {
        img.classList.add('loaded');
        const skeleton = img.previousElementSibling;
        if (skeleton && skeleton.classList.contains('skeleton')) {
            skeleton.style.display = 'none';
        }
    };

    img.src = src;
}

// ------------------- end lazy-load

/**
 * Селекторы формы для валидации
 * @type {{input: string, submitButton: string, form: string, label: string, phoneInput: string, passwordInput: string, formElements: string}}
 */
const formSelectors = {
    form: 'form[data-validate]',
    input: 'input[data-validate]',
    phoneInput: 'input[name="phone"]',
    submitButton: 'button[type="submit"]',
    label: '.variant-text-field__label',
    formElements: 'input, button, select, textarea',
    passwordInput: 'input[type="password"]',
    checkbox: 'input[type="checkbox"][data-validate]',
};

/**
 * Функция валидации выбранной формы
 * @param {Object} config - Конфигурация обработчика формы
 * @returns {{init: Function}} Объект с методом инициализации
 */
const createFormHandler = (config = {}) => {
    const defaultConfig = {
        onSuccess: () => {
        },
        onError: () => {
        },
        customValidations: {}
    };

    const mergedConfig = {...defaultConfig, ...config};

    /**
     * Валидирует поля ввода пароля, разрешая только буквенно-цифровой ввод и специальные символы
     * @param {string} value - Значение поля пароля
     * @returns {boolean} Валидность пароля
     */
    const isValidPassword = (value) => {
        const passwordRegex = /^[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>/?]*$/;
        return passwordRegex.test(value);
    };

    /**
     * Форматирует номер телефона
     * @param {HTMLInputElement} input - Поле ввода телефона
     */
    const formatPhone = (input) => {
        const inputNumbersValue = input.value.replace(/\D/g, '');
        let formattedInputValue = '';

        if (!inputNumbersValue) {
            input.value = '';
            return;
        }

        if (inputNumbersValue.startsWith('8')) {
            formattedInputValue = '8 (';
        } else {
            formattedInputValue = '+7 (';
        }

        if (inputNumbersValue.startsWith('9')) {
            formattedInputValue = '+7 (9';
        }

        if (inputNumbersValue.length > 1) {
            formattedInputValue += inputNumbersValue.substring(1, 4);
        }
        if (inputNumbersValue.length >= 5) {
            formattedInputValue += ') ' + inputNumbersValue.substring(4, 7);
        }
        if (inputNumbersValue.length >= 8) {
            formattedInputValue += '-' + inputNumbersValue.substring(7, 9);
        }
        if (inputNumbersValue.length >= 10) {
            formattedInputValue += '-' + inputNumbersValue.substring(9, 11);
        }

        input.value = formattedInputValue;
    };

    /**
     * Устанавливает состояние отключения для формы
     * @param {HTMLFormElement} form - Форма
     * @param {boolean} disabled - Флаг отключения
     */
    const setFormDisabled = (form, disabled) => {
        const elements = form.querySelectorAll(formSelectors.formElements);
        elements.forEach(element => element.disabled = disabled);
        const submitButton = form.querySelector(formSelectors.submitButton);
        if (submitButton) {
            submitButton.classList.toggle('submit-disabled', disabled);
        }
    };

    /**
     * Валидирует отдельное поле
     * @param {HTMLInputElement} input - Поле для валидации
     * @param {string[]} rules - Правила валидации
     * @param {HTMLFormElement} form - Форма, содержащая поле
     * @returns {{isValid: boolean, errorMessage: string}} Результат валидации
     */
    const validateField = (input, rules, form) => {
        if (!input.name || !input.dataset.validate) {
            return {isValid: true, errorMessage: ''};
        }

        if (!input.offsetParent) {
            return {isValid: true, errorMessage: ''};
        }

        let isValid = true;
        let errorMessage = '';

        if (rules.includes('unrequired')) {
            return {isValid: true, errorMessage: ''};
        }

        rules.forEach(rule => {
            const [validationType] = rule.split(':');
            switch (validationType) {
                case 'required':
                    if (input.type === 'checkbox') {
                        if (!input.checked) {
                            isValid = false;
                            errorMessage = 'Необходимо подтверждение';
                        }
                    } else if (!input.value.trim()) {
                        isValid = false;
                        errorMessage = 'Обязательно для заполнения';
                    }
                    break;
                case 'phone':
                    if (input.value.replace(/\D/g, '').length !== 10) {
                        isValid = false;
                        errorMessage = '';
                    }
                    break;
                case 'email':
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailRegex.test(input.value)) {
                        isValid = false;
                        errorMessage = 'Неверный формат email';
                    }
                    break;
                case 'password':
                    if (input.value.length < 8) {
                        isValid = false;
                        errorMessage = 'Не менее 8 символов';
                    } else if (!isValidPassword(input.value)) {
                        isValid = false;
                        errorMessage = 'Недопустимые символы';
                    }
                    break;
                case 'passwordMatch':
                    const passwordInput = form.querySelector('input[type="password"][name="password"]');
                    if (passwordInput && input.value !== passwordInput.value) {
                        isValid = false;
                        errorMessage = 'Пароли не совпадают';
                    }
                    break;
                case 'checkbox':
                    if (!input.checked) {
                        isValid = false;
                        errorMessage = 'Необходимо подтверждение';
                    }
                    break;
            }

            if (!isValid) return;
        });

        return {isValid, errorMessage};
    };

    /**
     * Выполняет тихую валидацию поля
     * @param {HTMLInputElement} input - Поле для валидации
     * @param {HTMLFormElement} form - Форма, содержащая поле
     * @returns {boolean} Результат валидации
     */
    const silentValidateField = (input, form) => {
        const rules = input.dataset.validate.split('|');
        const {isValid} = validateField(input, rules, form);

        input.classList.toggle('success', isValid);
        return isValid;
    };

    /**
     * Валидирует одно поле и обновляет его состояние
     * @param {HTMLInputElement} input - Поле для валидации
     * @param {HTMLFormElement} form - Форма, содержащая поле
     * @returns {boolean} Результат валидации
     */
    const validateSingleField = (input, form) => {
        const rules = input.dataset.validate.split('|');
        const { isValid, errorMessage } = validateField(input, rules, form);

        input.classList.toggle('error', !isValid);
        input.classList.toggle('success', isValid);

        if (input.type === 'checkbox') {
            const label = input.closest('.checkbox-policy');
            if (label) {
                label.classList.toggle('error', !isValid);
                label.classList.toggle('success', isValid);
            }
        } else {
            const label = input.closest('.variant-text-field')?.querySelector(formSelectors.label);
            if (label) {
                label.classList.toggle('error', !isValid);
                label.classList.toggle('success', isValid);

                if (!isValid) {
                    if (!label.dataset.placeholder) {
                        label.dataset.placeholder = label.textContent;
                    }
                    label.textContent = errorMessage;
                } else {
                    if (label.dataset.placeholder) {
                        label.textContent = label.dataset.placeholder;
                        delete label.dataset.placeholder;
                    }
                }
            }
        }

        return isValid;
    };

    /**
     * Валидирует всю форму
     * @param {HTMLFormElement} form - Форма для валидации
     * @param {boolean} forceValidateAll - Флаг принудительной валидации всех полей
     * @returns {boolean} Результат валидации формы
     */
    const validateForm = (form, forceValidateAll = false) => {
        let isValid = true;
        const inputs = form.querySelectorAll(formSelectors.input);

        inputs.forEach(input => {
            if (!input.offsetParent) {
                return;
            }

            const rules = input.dataset.validate.split('|');

            if (rules.includes('unrequired')) {
                return;
            }

            const isRequired = rules.includes('required');

            if (forceValidateAll || input.dataset.touched === 'true' || isRequired) {
                const fieldValid = validateSingleField(input, form);
                if (!fieldValid) isValid = false;
            } else if (isRequired) {
                isValid = false;
            }
        });

        updateSubmitButtonState(form);

        return isValid;
    };

    /**
     * Выполняет тихую валидацию формы
     * @param {HTMLFormElement} form - Форма для валидации
     * @returns {boolean} Результат валидации формы
     */
    const silentValidateForm = (form) => {
        const inputs = form.querySelectorAll(formSelectors.input);
        let isValid = true;

        inputs.forEach(input => {
            if (!input.offsetParent) return;

            if (input.value.trim() !== '' || input.type === 'checkbox') {
                const fieldValid = silentValidateField(input, form);
                if (!fieldValid) isValid = false;
            }
        });

        return isValid;
    };

    /**
     * Обновляет состояние кнопки отправки формы
     * @param {HTMLFormElement} form - Форма
     */
    const updateSubmitButtonState = (form) => {
        const inputs = form.querySelectorAll(formSelectors.input);
        const isValid = Array.from(inputs).every(input => {
            const rules = input.dataset.validate.split('|');

            if (rules.includes('unrequired')) {
                return true;
            }

            if (input.type === 'checkbox') {
                return input.checked;
            }

            const isRequired = rules.includes('required');

            if (isRequired) {
                return input.classList.contains('success') ||
                    (input.value.trim() !== '' && !input.classList.contains('error'));
            }
            return true;
        });

        const submitButton = form.querySelector(formSelectors.submitButton);
        if (submitButton) {
            submitButton.disabled = !isValid;
            submitButton.classList.toggle('submit-disabled', !isValid);
        }
    };

    /**
     * Обрабатывает отправку формы
     * @param {Event} event - Событие отправки формы
     */
    const handleFormSubmit = (event) => {
        event.preventDefault();
        const form = event.target;

        // Mark all inputs as touched before final validation
        form.querySelectorAll(formSelectors.input).forEach(input => {
            input.dataset.touched = 'true';
        });

        if (!validateForm(form, true)) {
            mergedConfig.onError('Validation failed');
            return;
        }

        setFormDisabled(form, true);

        const submitButton = form.querySelector(formSelectors.submitButton);
        if (submitButton) {
            submitButton.disabled = true;
            submitButton.classList.add('submit-disabled');
        }

        // Form is valid, but we're not sending it
        // You can add custom logic here if needed

        setFormDisabled(form, false);
        mergedConfig.onSuccess();
    };

    /**
     * Инициализирует форму
     * @param {HTMLFormElement} form - Форма для инициализации
     */
    const initForm = (form) => {
        form.addEventListener('submit', handleFormSubmit);

        const phoneInputs = form.querySelectorAll(formSelectors.phoneInput);
        phoneInputs.forEach(input => {
            input.addEventListener('input', () => {
                // formatPhone(input);
                input.dataset.touched = 'true';
                validateSingleField(input, form);
                updateSubmitButtonState(form);
            });
        });

        const passwordInputs = form.querySelectorAll(formSelectors.passwordInput);
        passwordInputs.forEach(input => {
            input.addEventListener('input', (event) => {
                const validInput = event.target.value.replace(/[^a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>/?]/g, '');
                if (validInput !== event.target.value) {
                    event.target.value = validInput;
                }
                input.dataset.touched = 'true';
                validateSingleField(input, form);
                updateSubmitButtonState(form);

                if (input.name === 'password') {
                    const confirmInput = form.querySelector('input[name="passwordConfirmation"]');
                    if (confirmInput && confirmInput.dataset.touched === 'true') {
                        validateSingleField(confirmInput, form);
                    }
                }
            });
        });

        const inputs = form.querySelectorAll(formSelectors.input);
        inputs.forEach(input => {
            const inputHandler = () => {
                input.dataset.touched = 'true';
                validateSingleField(input, form);
                updateSubmitButtonState(form);

                if (input.type === 'password' && input.name === 'password') {
                    const confirmInput = form.querySelector('input[name="passwordConfirmation"]');
                    if (confirmInput && confirmInput.dataset.touched === 'true') {
                        validateSingleField(confirmInput, form);
                    }
                }
            };

            if (input.type === 'checkbox') {
                input.addEventListener('change', inputHandler);
            } else {
                input.addEventListener('input', inputHandler);
            }
        });

        // Perform silent validation on prefilled fields
        silentValidateForm(form);

        // Update submit button state based on silent validation
        updateSubmitButtonState(form);
    };

    return {
        /** Инициализирует обработчик форм */
        init: () => {
            document.querySelectorAll(formSelectors.form).forEach(initForm);
        }
    };
};

const formHandler = createFormHandler({
    onSuccess: () => {
        // Custom success logic (e.g., show a success message)
    },
    onError: () => {
        // Custom error logic (e.g., show an error message)
    },
    customValidations: {
        // Add any custom validations here
    }
});

document.addEventListener('DOMContentLoaded', formHandler.init);


// ---------------- login success modal
window.addEventListener('load', function () {
    const modalSuccess = document.querySelector('.modal-login-success');

    if (sessionStorage.getItem('showSignInModal') === 'true') {
        if (modalSuccess) {
            modalSuccess.showModal();
            sessionStorage.removeItem('showSignInModal');
        } else {
        }
    } else {
    }
});

// ------------- registration success modal
window.addEventListener('load', function () {
    const modalSuccess = document.querySelector('.modal-registration-success');

    if (sessionStorage.getItem('showSignUpModal') === 'true') {
        if (modalSuccess) {
            modalSuccess.showModal();
            sessionStorage.removeItem('showSignUpModal');
        } else {
        }
    } else {
    }
});

// ------------- dialogs close handler
const dialogs = document.querySelectorAll('dialog');
dialogs.forEach(dialog => {
    dialog.addEventListener('click', (e) => {
        // e.preventDefault();
        if (!dialog.classList.contains('cookie')) {
            if (e.target === dialog) {
                dialog.close();
            }
        }
    })
});

// -------------- feedback form submission
const submitForm = async (form, endpoint, extraData = {}) => {
    const formData = new FormData(form);

    const closestModal = form.closest('.modal');

    Object.entries(extraData).forEach(([key, value]) => formData.append(key, value));
    formData.set('from', window.location.href);
    formData.set('from_title', document.title);

    const urlParams = new URLSearchParams(window.location.search);
    const utms = ['utm_source', 'utm_medium', 'utm_campaign', 'utm_term', 'utm_content'];

    utms.forEach(utm => {
        let value = urlParams.get(utm);
        if (value) {
            formData.append(utm, value);
        } else {
            const cookieValue = document.cookie.match(new RegExp('(^| )' + utm + '=([^;]+)'));
            if (cookieValue) {
                formData.append(utm, decodeURIComponent(cookieValue[2]));
            }
        }
    });

    const submitBtn = form.querySelector('button[type="submit"]');
    if (submitBtn) {
        submitBtn.classList.add('submit-disabled', 'loading');
        submitBtn.disabled = true;
    }

    try {
        const response = await fetch(endpoint, {method: 'POST', body: formData});
        if (response.ok) {
            form.reset();

            tracker.track('sendform');

            if (closestModal) {
                closestModal.classList.remove('open-modal');
            }

            const modalSuccess = document.querySelector('.modal-form-submitted');
            if (modalSuccess) {
                modalSuccess.showModal();
                form.closest('dialog')?.close();
            }
        } else {
            const errorText = await response.text();
            console.error('Server error:', response.status, errorText);
            alert('Произошла ошибка на сервере. Попробуйте позже.');
        }
    } catch (error) {
        console.error(error);
        console.error('Network error:', error);
    } finally {
        if (submitBtn) {
            submitBtn.classList.remove('submit-disabled', 'loading');
            submitBtn.disabled = false;
        }
    }
};

document.body.addEventListener('submit', (event) => {
    const form = event.target;

    if (form.matches('.modal-help__form, .mailing-list__mail-card, .modal-feedback__form, .modal-sales__form, .modal-consultation__form')) {
        event.preventDefault();
        submitForm(form, '/form/', {form_type: 'feedback'});
    } else if (form.matches('.modal-checklist__form')) {
        event.preventDefault();
        submitForm(form, '/form/', {form_type: 'checklist'});
    }
});

//! Сохранение UTM
function getUTM(name) {
    const params = new URLSearchParams(window.location.search);
    return params.get(name) || '';
}

function saveUTMToCookies() {
    const utms = ['utm_source', 'utm_medium', 'utm_campaign', 'utm_term', 'utm_content'];
    utms.forEach(key => {
        const value = getUTM(key);
        if (value) {
            document.cookie = `${key}=${encodeURIComponent(value)}; path=/; max-age=2592000`; // 30 дней
        }
    });
}

saveUTMToCookies();