/**
 * Проверяет, находится ли пользователь на странице корзины.
 * @returns {boolean} True, если текущая страница - корзина, иначе false.
 */
function isCartPage() {
    return window.location.pathname.includes('/cart/');
}

/**
 * Обновляет информацию о покупке в карточке корзины.
 * @param {HTMLElement} e - Элемент карточки корзины.
 * @param {Object} d - Данные для обновления.
 */
function updateCartPurchase(e, d) {
    const count = e.querySelector('.cart-purchase-card__t-right');
    const total = e.querySelector('.cart-purchase-card__line-products');
    const discount = e.querySelector('.cart-purchase-card__line-discount');
    const actual = e.querySelector('.cart-purchase-card__line-result');
    const dcRow = e.querySelector('.js--discount');

    if (count) count.textContent = d.info.count_plur;
    if (total) total.textContent = d.info.sum_total;
    if (discount) discount.textContent = d.info.discount;
    if (actual) actual.textContent = d.info.sum;

    if (dcRow) dcRow.classList.toggle('hidden', d.info.discount[0] == '0');

    const level = e.querySelector('.cart-purchase-card__sale-info');
    if (level) {
        const levelText = level.querySelector('.sale-info__text');
        if (levelText) levelText.textContent = d.level.cur;

        const hint = level.querySelector('.sale-info__hint-text');
        if (hint) {
            hint.textContent = d.level.cur_text;
        }
    }

    const nextLevel = e.querySelector('.cart-purchase-card__sale-info-2');
    if (nextLevel && d.level.next) {
        const nextLevelText = nextLevel.querySelector('.sale-info__text');
        if (nextLevelText) nextLevelText.textContent = d.level.next;

        const hint2 = nextLevel.querySelector('.sale-info__hint-text');
        if (hint2) hint2.textContent = d.level.next_text;

        const conditionsText = e.querySelector('.cart-purchase-card__conditions-text');
        if (conditionsText) conditionsText.textContent = d.level.is_personal ? 'Для персонального расчёта:' : 'Для расчёта товаров по прайсу:';

        const bottomLinePrice = e.querySelector('.cart-purchase-card__bottom-line-price');
        if (bottomLinePrice) bottomLinePrice.textContent = d.level.till_next;
    }

    const pricesMin = e.querySelector('.js--prices-min');
    if (pricesMin) pricesMin.classList.toggle('hidden', d.min);

    const purchaseMin = e.querySelector('.js--purchase-min');
    if (purchaseMin) purchaseMin.classList.toggle('hidden', !d.min);

    const cartBtn = e.querySelector('.js--cartbtn');
    if (cartBtn) cartBtn.classList.toggle('hidden', !d.min);

    const calc = e.querySelector('.js--calc');
    if (calc) calc.classList.toggle('hidden', d.min || d.max);

    const purchaseNext = e.querySelector('.js--purchase-next');
    if (purchaseNext) purchaseNext.classList.toggle('hidden', !d.level.next);

    const personal = e.querySelector('.js--personal');
    if (personal) personal.classList.toggle('hidden', !d.max);

    const bottomLine = e.querySelector('.cart-purchase-card__bottom-line');
    if (bottomLine) bottomLine.classList.toggle('hidden', !d.level.next);

    const buttonCart = e.querySelector('.button-cart');
    if (buttonCart) buttonCart.classList.toggle('hidden', d.min);

    const min = e.querySelector('.cart-purchase-card__amount.discount');
    if (min) min.textContent = d.min_left;

    const actualBottom = document.querySelector('.cart__bottom-result');
    if (actual && actualBottom) {
        if (actual.textContent && actualBottom.textContent !== actual.textContent) {
            actualBottom.textContent = actual.textContent;
        }
    }
}

/**
 * Обновляет информацию о покупке на странице товара.
 * @param {HTMLElement} e - Элемент карточки покупки.
 * @param {Object} d - Данные для обновления.
 */
function updatePagePurchase(e, d) {
    api.catalog.getProductLevels((data) => {
        let i = 0;
        for (const k of e.querySelectorAll('.js--price')) {
            if (!data[i]) {
                k.style.display = 'none';
                i++;
                continue;
            }

            const inf = data[i];
            k.style.display = 'block';

            if (i === 0) {
                const price = e.querySelector('.purchase-card__discounted-price');
                const old = e.querySelector('.purchase-card__old-price');

                price.textContent = parseFloat(inf.price.price) > 0
                    ? format_price(inf.price.price - inf.price.price * inf.mod)
                    : 'По уточнению';

                if (old) {
                    old.textContent = format_price(inf.price.price);
                }
            }

            if (i !== 0) {
                const p = k.querySelector('.purchase-card__price-list-price');
                p.textContent = format_price(inf.price.price - inf.price.price * inf.mod);
            }

            const text = k.querySelector('.sale-info__text');
            text.textContent = inf.level.name;

            const desc = k.querySelector('.purchase-card__sale-info-text');
            desc.textContent = inf.level.desc;

            const desc2 = k.querySelector('.sale-info__hint-text');
            if (desc2) {
                desc2.textContent = inf.level.desc;
            }

            i++;
        }
    });
}

function initializeCartData() {
    api.cart.get((data) => {
        try {
            document.querySelectorAll('.product-card__result').forEach((e) => {
                const cartSum = e.querySelector('.js--cart-sum');
                const id = e.dataset.id + '.' + e.dataset.variant;
                if (data.items[id]) {
                    cartSum.textContent = 'Стоимость: ' + data.items[id];
                    cartSum.classList.remove('invisible');
                } else {
                    cartSum.classList.add('invisible');
                }
            });

        } catch (error) {
            console.error('Error initializing cart data:', error);
        }
    });
}

/** Обрабатывает обновление корзины, обновляя различные элементы UI. */
function onCartUpdated() {
    api.cart.get((data) => {
        try {
            // Обновление кнопки корзины в шапке
            const cart = document.querySelector('.header__button-cart');
            if (cart) {
                const result = cart.querySelector('.header__button-cart-result');
                if (result) {
                    cart.classList.toggle('active', data.info.count > 0);
                    result.style.display = data.info.count > 0 ? 'unset' : 'none';
                    result.textContent = data.info.sum;
                }
            }

            // Обновление отображения корзины в мобильном меню
            const mobileCartDisplay = document.getElementById('mobile-cart-display');
            if (mobileCartDisplay) {
                if (parseInt(data.info.sum_actual) !== 0) {
                    mobileCartDisplay.textContent = `${data.info.sum} `;
                } else {
                    mobileCartDisplay.textContent = 'Корзина';
                }
            }

            // Обновление информации о распродаже и цен на карточках каталога
            const hdr = document.querySelectorAll('.sale-info[data-level]');
            const prod = document.querySelectorAll('.catalog-card__price[data-level]');
            const isCart = location.href.includes('/cart/');

            hdr.forEach((el) => {
                el.classList.toggle('inactive', el.dataset.level != data.info.level);
                if (isCart) {
                    el.classList.toggle('hide', el.dataset.level != data.info.level);
                }
            });

            prod.forEach((el) => {
                el.classList.toggle('inactive', el.dataset.level != data.info.level);
                if (isCart) {
                    el.classList.toggle('hide', el.dataset.level != data.info.level);
                }
            });

            document.querySelectorAll('.sale-info.js--mob').forEach(e => {
                e.querySelector('.sale-info__text').textContent = data.level.cur;
                const hint = e.querySelector('.sale-info__hint-text');
                if (hint) {
                    hint.textContent = data.level.cur_text;
                }
            });

            document.querySelectorAll('.product-card__price[data-level]').forEach(e => {
                e.classList.toggle('hidden', data.info.level != e.dataset.level);
            });

            // Обновление элементов управления карточки каталога, кнопок карточки покупки и результатов карточки товара
            document.querySelectorAll('.product-card__result, .catalog-card__controls, .purchase-card__buttons-bottom').forEach((e) => {
                const cartSum = e.querySelector('.js--cart-sum, .quantity-input__amount');
                const id = e.dataset.id + '.' + e.dataset.variant;
                if (data.items[id]) {
                    cartSum.textContent = 'Стоимость: ' + data.items[id];
                    cartSum.classList.remove('invisible');
                } else {
                    cartSum.classList.add('invisible');
                }
            });

            // Обновление карточек покупки в корзине
            const cartData = document.querySelectorAll('.cart-purchase-card');
            if (cartData.length) {
                cartData.forEach(cd => {
                    updateCartPurchase(cd, data);
                });
            }

            // Обновление карточки покупки на странице товара
            const pageData = document.querySelector('.purchase-card');
            if (pageData) {
                updatePagePurchase(pageData, data);
            }
        } catch (error) {
            console.error(error);
        }
    });
}

/**
 * Создает функцию, которая откладывает вызовы функции-аргумента.
 * @param {Function} func - Функция для обертки.
 * @param {number} wait - Время ожидания в миллисекундах.
 * @returns {Function} Обернутая функция с отложенным выполнением.
 */
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

const debouncedOnCartUpdated = debounce(onCartUpdated, 150);

document.addEventListener('DOMContentLoaded', () => {
    initializeCartData();

    const wrappers = document.querySelectorAll(
        '.catalog-card__controls, .purchase-card__buttons-bottom, .product-card__cart-wrap, .product__purchase-bottom');

    wrappers.forEach(wrapper => {
        const plusBtn = wrapper.querySelector('[data-action="plus"]');
        const minusBtn = wrapper.querySelector('[data-action="minus"]');
        const input = wrapper.querySelector('[data-qty]');
        const btnCart = wrapper.querySelector(
            '.catalog-card__add-button, .catalog-card__add-button--active, .purchase-card__button-cart, .product-card__button, .purchase-card__button-cart--active')
        const amount = wrapper.querySelector('.quantity-input__amount');
        const thing = wrapper.querySelector('.product-card__result');

        const catalogCard = wrapper.closest('.catalog-card');
        const productCard = wrapper.closest('.product-card');
        const purchaseCard = wrapper.closest('.purchase-card');

        const getConditionsElement = () => {
            if (catalogCard) {
                return catalogCard.querySelector('.catalog-card__conditions');
            }
            if (productCard) {
                return productCard.querySelector('.product-card__conditions');
            }
            if (purchaseCard) {
                return purchaseCard.querySelector('.purchase-card__add-info');
            }
            return null;
        };

        const preloader = document.querySelector('.preloader-pulse');

        /** Получает количество штук в упаковке */
        function getStepSize() {
            const conditions = getConditionsElement();
            if (conditions && conditions.dataset.conditions) {
                const value = parseFloat(conditions.dataset.conditions);
                return value === 0 ? 1 : value;
            }
            return 1;
        }

        function roundToNearestStep(quantity, step) {
            return Math.ceil(quantity / step) * step;
        }

        function validateDecimalInput(value) {
            let sanitized = value.replace(/[^\d.]/g, '');

            const parts = sanitized.split('.');
            if (parts.length > 2) {
                sanitized = parts[0] + '.' + parts.slice(1).join('');
            }

            if (sanitized === '' || sanitized === '.') {
                return '';
            }

            const num = parseFloat(sanitized);
            return isNaN(num) ? '' : num.toString();
        }

        input.addEventListener('input', (event) => {
            const validValue = validateDecimalInput(event.target.value);
            if (validValue !== event.target.value) {
                event.target.value = validValue;
            }
        });

        input.addEventListener('paste', (event) => {
            event.preventDefault();
            const pastedText = (event.clipboardData || window.clipboardData).getData('text');
            const validValue = validateDecimalInput(pastedText);
            event.target.value = validValue;
        });

        input.addEventListener('focus', (event) => {
            if (event.target.value === '0') {
                event.target.select();
            }
        });

        input.addEventListener('blur', (event) => {
            if (event.target.value !== '') {
                const num = parseFloat(event.target.value);
                if (!isNaN(num)) {
                    event.target.value = num.toString();
                }
            }
        });

        input.addEventListener('change', () => {
            const stepSize = getStepSize();
            const currentQty = parseInt(input.value.replace(/ /g, ''), 10) || 0;
            const roundedQty = roundToNearestStep(currentQty, stepSize);

            input.value = roundedQty || '';

            if (roundedQty > 0 && btnCart.className.includes('--active')) {
                api.cart.update(wrapper.dataset.id, wrapper.dataset.variant, roundedQty, debouncedOnCartUpdated);
            }

            updateCounterpart(wrapper.dataset.id, wrapper.dataset.variant, roundedQty);
        });

        /** Обрабатывает прибавление товара в корзину. */
        plusBtn.addEventListener('click', () => {
            const stepSize = getStepSize();
            const currentQty = parseInt(input.value.replace(/ /g, ''), 10) || 0;
            const newQty = roundToNearestStep(currentQty + stepSize, stepSize);
            input.value = newQty;

            if (btnCart.className.includes('--active')) {
                api.cart.update(wrapper.dataset.id, wrapper.dataset.variant, newQty, debouncedOnCartUpdated);
            } else {
                const ev = new Event('click');
                btnCart.dispatchEvent(ev);
            }

            updateCounterpart(wrapper.dataset.id, wrapper.dataset.variant, newQty);
        });

        /** Обрабатывает вычитание товара из корзины. */
        minusBtn.addEventListener('click', () => {
            const stepSize = getStepSize();
            const currentQty = parseInt(input.value.replace(/ /g, ''), 10) || 0;
            const newQty = Math.max(0, roundToNearestStep(currentQty - stepSize, stepSize));
            input.value = newQty || '';
            if (newQty <= 0) {
                input.value = '';
            }
            if (btnCart.className.includes('--active')) {
                if (newQty <= 0) {
                    api.cart.remove(wrapper.dataset.id, wrapper.dataset.variant, () => {
                        debouncedOnCartUpdated();
                        if (isCartPage()) {
                            preloader.classList.remove('hidden')
                            location.reload();
                        }
                    });
                    amount.classList.remove('visible');

                    if (thing) {
                        thing.querySelector('.js--cart-sum').textContent = '';
                        amount.classList.add('invisible');
                    }

                    if (btnCart.className.includes('catalog-card')) {
                        btnCart.classList.remove(
                            'catalog-card__add-button--active');
                        btnCart.classList.add('catalog-card__add-button');
                    }

                    if (btnCart.classList.contains('purchase-card__button-cart--active')) {
                        btnCart.classList.remove('purchase-card__button-cart--active');
                        btnCart.querySelector('span').textContent = 'В корзину';
                    }

                    if (btnCart.classList.contains('product-card__button')) {
                        btnCart.classList.remove('product-card__button--active');
                        const inputWrap = wrapper.querySelector(
                            '.product__quantity-input');
                        inputWrap.classList.remove('product__quantity-input--active');
                    }
                } else {
                    api.cart.update(wrapper.dataset.id, wrapper.dataset.variant,
                        newQty, debouncedOnCartUpdated);
                }
            }

            updateCounterpart(wrapper.dataset.id, wrapper.dataset.variant, newQty);
        });

        /**
         * Обновляет связанные элементы управления количеством товара.
         * @param {string} id - ID товара.
         * @param {string} variant - Вариант товара.
         * @param {number} qty - Новое количество.
         */
        function updateCounterpart(id, variant, qty) {
            document.querySelectorAll(`[data-id="${id}"][data-variant="${variant}"]`).forEach(counterpart => {
                const counterpartInput = counterpart.querySelector('[data-qty]');
                const counterpartCartBtn = counterpart.querySelector('.purchase-card__button-cart');

                if (counterpartInput) {
                    counterpartInput.value = qty > 0 ? qty : '';
                }

                if (counterpartCartBtn) {
                    if (qty > 0) {
                        if (counterpartCartBtn.classList.contains('purchase-card__button-cart')) {
                            counterpartCartBtn.classList.add('purchase-card__button-cart--active');
                            counterpartCartBtn.querySelector('span').textContent = 'В корзине';
                        }
                    } else {
                        if (counterpartCartBtn.classList.contains('purchase-card__button-cart')) {
                            counterpartCartBtn.classList.remove('purchase-card__button-cart--active');
                            counterpartCartBtn.querySelector('span').textContent = 'В корзину';
                        }
                    }
                }
            });
        }

        /** Добавляет товар в корзину. */
        function addToCart() {
            let qty = parseInt(input.value.replace(/ /g, ''), 10) || 0;
            api.cart.update(wrapper.dataset.id, wrapper.dataset.variant, qty,
                debouncedOnCartUpdated);
            if (isCartPage()) {
                location.reload();
            }

            if (thing) {
                amount.classList.remove('invisible');
            }
        }

        /** Удаляет товар из корзины. */
        function removeFromCart() {
            api.cart.remove(wrapper.dataset.id, wrapper.dataset.variant, () => {
                debouncedOnCartUpdated();
                if (isCartPage()) {
                    location.reload();
                }
            });

            if (thing) {
                amount.classList.add('invisible');
            }
        }

        /** Обработчик кнопок добавления в корзину. */
        btnCart.addEventListener('click', () => {
            const stepSize = getStepSize();
            let newQty = parseInt(input.value.replace(/ /g, ''), 10) || 0;

            if (btnCart.classList.contains('purchase-card__button-cart--active') ||
                btnCart.classList.contains('catalog-card__add-button--active') ||
                btnCart.classList.contains('product-card__button--active')) {
                newQty = 0;
                removeFromCart();
            } else {
                newQty = Math.max(stepSize, newQty);
                input.value = newQty;
                addToCart();
            }

            if (btnCart.className.includes('--active')) {
                if (btnCart.className.includes('purchase-card__button-cart')) {
                    location.href = '/cart/';
                    return;
                }

                if (btnCart.classList.contains('product-card__button')) {
                    btnCart.classList.remove('product-card__button--active');
                    const inputWrap = wrapper.querySelector('.product__quantity-input');
                    inputWrap.classList.remove('product__quantity-input--active');
                    btnCart.querySelector('span').textContent = 'В корзину';
                }

                removeFromCart();
                input.value = '';
                amount.classList.remove('visible');

                if (btnCart.className.includes('catalog-card__add-button')) {
                    btnCart.classList.remove(
                        'catalog-card__add-button--active');
                    btnCart.classList.add('catalog-card__add-button');
                }

            } else {
                if (input.value === '0' || input.value === '') {
                    input.value = 1;
                }

                addToCart();

                if (btnCart.className.includes('catalog-card__add-button')) {
                    btnCart.classList.add('catalog-card__add-button--active');
                    btnCart.classList.remove('catalog-card__add-button');
                }

                if (btnCart.className.includes('purchase-card__button-cart')) {
                    btnCart.classList.add('purchase-card__button-cart--active');
                    const inputWrap = wrapper.querySelector('.quantity-input');
                    inputWrap.classList.add('quantity-input--active');
                    btnCart.querySelector('span').textContent = 'В корзине';
                }

                if (btnCart.classList.contains('product-card__button')) {
                    btnCart.classList.add('product-card__button--active');
                    const inputWrap = wrapper.querySelector('.product__quantity-input');
                    inputWrap.classList.add('product__quantity-input--active');
                }

                if (wrapper.classList.contains('catalog-card__controls')) {
                    amount.classList.add('visible');
                }
            }

            updateCounterpart(wrapper.dataset.id, wrapper.dataset.variant, newQty);
        });

        /**
         * Обрабатывает событие нажатия клавиши в поле ввода количества.
         * @param {KeyboardEvent} event - Событие нажатия клавиши.
         */
        function handleKeydownEvent(event) {
            if (event.key === 'Enter') {
                if (input.value === '0' || input.value === '') {
                    if (btnCart.classList.contains('product-card__button')) {
                        btnCart.classList.remove('product-card__button--active');
                        const inputWrap = wrapper.querySelector('.product__quantity-input');
                        inputWrap.classList.remove('product__quantity-input--active');
                        btnCart.querySelector('span').textContent = 'В корзину';
                    }

                    removeFromCart();
                    input.value = '';
                    amount.classList.remove('visible');

                    if (isCartPage()) {
                        location.reload();
                    }

                    if (btnCart.className.includes('catalog-card__add-button')) {
                        btnCart.classList.remove(
                            'catalog-card__add-button--active');
                        btnCart.classList.add('catalog-card__add-button');
                    }
                } else {
                    addToCart();

                    if (btnCart.className.includes('catalog-card__add-button')) {
                        btnCart.classList.add('catalog-card__add-button--active');
                        btnCart.classList.remove('catalog-card__add-button');
                    }

                    if (btnCart.className.includes('purchase-card__button-cart')) {
                        btnCart.classList.add('purchase-card__button-cart--active');
                        const inputWrap = wrapper.querySelector('.quantity-input');
                        inputWrap.classList.add('quantity-input--active');
                        btnCart.querySelector('span').textContent = 'В корзине';
                    }

                    if (btnCart.classList.contains('product-card__button')) {
                        btnCart.classList.add('product-card__button--active');
                        const inputWrap = wrapper.querySelector('.product__quantity-input');
                        inputWrap.classList.add('product__quantity-input--active');
                    }

                    if (wrapper.classList.contains('catalog-card__controls')) {
                        amount.classList.add('visible');
                    }
                }
            }
        }

        wrapper.addEventListener('keydown', handleKeydownEvent);
    });

    /**
     * Переключает состояние кнопки "Добавить в корзину".
     * @param {string} elClass - Класс элемента для переключения.
     */
    function toggleCartProduct(elClass) {
        const btns = document.querySelectorAll(`.${elClass}`);

        btns.forEach(btn => {
            btn.addEventListener('click', () => {
                const span = btn.querySelector('span');
                if (btn.classList.contains('purchase-card__button-cart')) {
                    if (span.textContent !== 'В корзине') {
                        span.textContent = 'В корзине';
                    } else {
                        span.textContent = 'В корзину';
                    }
                }
            });
        });
    }

    toggleCartProduct('catalog-card__add-button');
});
