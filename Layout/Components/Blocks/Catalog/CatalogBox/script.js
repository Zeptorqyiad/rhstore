/**
 * @fileoverview Скрипт для обработки тэгов десктоп каталога
 */

/** Инициализирует обработчики событий для тегов каталога */
document.addEventListener('DOMContentLoaded', () => {
    const tags = document.querySelectorAll('.catalog-box__view-badges .catalog-badge');

    tags.forEach(tag => {
        tag.addEventListener('click', () => handleTagClick(tag));
    });
});

/**
 * Обрабатывает клик по тегу
 * @param {HTMLElement} tag - Элемент тега, по которому был произведен клик
 */
function handleTagClick(tag) {
    if (tag.dataset.reset === 'reset') {
        window.location.href = './';
        return;
    }

    const currentParams = new URLSearchParams(window.location.search);

    if (tag.dataset.param) {
        handleParamTag(tag, currentParams);
    } else if (tag.dataset.price) {
        handlePriceTag(currentParams);
    } else if (tag.dataset.brand) {
        handleBrandTag(tag, currentParams);
    } else if (tag.dataset.tags) {
        handleCustomTag(tag, currentParams);
    } else {
        handleResetTag(currentParams);
    }

    window.location.search = currentParams.toString();
}

/**
 * Обрабатывает тег параметра
 * @param {HTMLElement} tag - Элемент тега параметра
 * @param {URLSearchParams} params - Текущие параметры URL
 */
function handleParamTag(tag, params) {
    const key = `param_${tag.dataset.param}[]`;
    const value = tag.dataset.pval;
    const encodedValue = encodeURIComponent(value).replace(/%20/g, '+');

    if (params.getAll(key).includes(encodedValue)) {
        params.delete(key, encodedValue);
    }
}

/**
 * Обрабатывает тег цены
 * @param {URLSearchParams} params - Текущие параметры URL
 */
function handlePriceTag(params) {
    for (const [key] of params) {
        if (key.startsWith('price_')) {
            params.delete(key);
        }
    }
}

/**
 * Обрабатывает тег бренда
 * @param {HTMLElement} tag - Элемент тега бренда
 * @param {URLSearchParams} params - Текущие параметры URL
 */
function handleBrandTag(tag, params) {
    const key = 'brand[]';
    const value = encodeURIComponent(tag.dataset.brand);

    if (params.getAll(key).includes(value)) {
        params.delete(key, value);
    }
}

/**
 * Обрабатывает пользовательский тег
 * @param {HTMLElement} tag - Элемент пользовательского тега
 * @param {URLSearchParams} params - Текущие параметры URL
 */
function handleCustomTag(tag, params) {
    params.delete(`${tag.dataset.tags}`);
}

/**
 * Обрабатывает тег сброса
 * @param {URLSearchParams} params - Текущие параметры URL
 */
function handleResetTag(params) {
    for (const [key] of params) {
        if (key.startsWith('price_') || key.startsWith('param_')) {
            params.delete(key);
        }
    }
}