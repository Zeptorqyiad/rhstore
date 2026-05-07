/**
 * @file Скрипт для управления выпадающими списками на странице.
 * @description Этот скрипт инициализирует функциональность выпадающих списков,
 * обрабатывает выбор опций и обновляет соответствующие элементы на странице.
 */
document.addEventListener("DOMContentLoaded", () => {
    const dropdowns = document.querySelectorAll('.dropdown');
    const body = document.body;

    if (!dropdowns.length) return;

    dropdowns.forEach((dropdown) => {
        const input = dropdown.querySelector('input[type="text"]');
        const val = dropdown.querySelector('input[type="hidden"]');
        const listOfOptions = dropdown.querySelectorAll('.dropdown__option');

        /**
         * Переключает состояние выпадающего списка (открыт/закрыт).
         * @param {Event} event - Событие клика.
         */
        const toggleDropdown = (event) => {
            event.stopPropagation();
            dropdown.classList.toggle('dropdown__opened');
        };

        /**
         * Обрабатывает выбор опции в выпадающем списке.
         * @param {Event|HTMLElement} event - Событие клика или HTML элемент опции.
         */
        const selectOption = (event) => {
            const selectedOption = event.currentTarget || event;

            // Обновляем значение текстового поля выбранным текстом
            input.value = selectedOption.textContent;

            // Обновляем значение скрытого поля выбранным значением
            val.value = selectedOption.dataset.value;

            // Проверяем, является ли это выпадающим списком типа заказа
            if (dropdown.classList.contains('order-type-card__dropdown')) {
                const selectedPrice = selectedOption.dataset.price;

                if (selectedPrice) {
                    // Обновляем цену в соответствующей карточке типа заказа
                    const card = dropdown.closest('.order-type-card');
                    const orderTypePickupPriceElement = card.querySelector('.order-type-card_pickup .order-type-card__radio-item-price');

                    if (orderTypePickupPriceElement) {
                        orderTypePickupPriceElement.textContent = `от ${selectedPrice}`;
                    }

                    // Обновляем цену доставки, если применимо
                    const deliveryPriceElement = document.querySelector('.checkout-card__delivery-price');
                    const deliverySection = document.querySelector('.checkout-card__delivery');

                    if (deliveryPriceElement) {
                        deliveryPriceElement.textContent = `от ${selectedPrice}`;
                    }

                    // Показываем секцию доставки
                    if (deliverySection) {
                        deliverySection.classList.remove('hidden');
                    }
                }
            }

            // Отправляем форму, если это необходимо
            const f = input.closest('form');
            if (f && !dropdown.dataset.ns) {
                f.submit();
            }
        };

        /** Закрывает выпадающий список при клике вне его области. */
        const closeDropdownFromOutside = () => {
            if (dropdown.classList.contains('dropdown__opened')) {
                dropdown.classList.remove('dropdown__opened');
            }
        };

        // Добавляем слушатель для закрытия dropdown при клике вне его области
        body.addEventListener('click', closeDropdownFromOutside);

        // Добавляем слушатели для каждой опции
        listOfOptions.forEach((option) => {
            option.addEventListener('click', selectOption);
        });

        dropdown.addEventListener('click', toggleDropdown);

        // Устанавливаем значение по умолчанию для выпадающего списка типа заказа
        if (dropdown.classList.contains('order-type-card__dropdown') && listOfOptions.length > 0) {
            selectOption(listOfOptions[0]);
        }
    });
});