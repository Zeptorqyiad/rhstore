document.addEventListener('DOMContentLoaded', function() {

    function checklistSteps() {
        let currentIndex = 0;
        let markedCheckboxes = 0;
        let inputsCounter = 0;

        let isBonus = false;

        const btnStart = document.querySelector('.modal-checklist__btn');
        const btnNext = document.querySelector('.modal-checklist__form-btn');
        const btnClose = document.querySelector('.modal-checklist__close');
        const btnNote = document.querySelector('.modal-checklist__form-note-btn');
        const btnSubmit = document.querySelector('.modal-checklist__submit');

        // Form
        const popupForm = document.querySelector('.modal-checklist__form');
        const popupFormWrap = document.querySelector('.modal-checklist__form-wrap');
        const popupFormTitle = document.querySelector('.modal-checklist__form-title');
        const popupFormFields = document.querySelectorAll('.modal-checklist__form-fields');

        // Progress bar
        const progressBarInitialValue = popupForm.querySelector('.progress__value--start');
        const progressBarFinalValue = popupForm.querySelector('.progress__value--end');
        const progressBar = popupForm.querySelector('.progress__bar-progress');

        // Popups
        const popup = document.querySelector('.modal-checklist');
        const popupFormScreen = document.querySelector('.modal-checklist__firstscreen');
        const popupResult = document.querySelector('.modal-checklist__result');
        const popupResultTitle = popupResult.querySelector('.modal-checklist__result-title');
        const popupResultText = popupResult.querySelector('.modal-checklist__result-text');

        function btnStartHandler() {
            isBonus = false;
            resetForm();
            currentIndex = 0;
            markedCheckboxes = 0;
            inputsCounter = 0;
            popupFormTitle.classList.remove('modal-checklist__form-title--blue');

            btnNext.textContent = "Далее";

            renderContent(currentIndex);

            popupFormScreen.style.display = 'none';
            popupForm.style.display = 'block';
        }

        function btnCloseHandler() {
            resetForm();
            popupForm.style.display = 'none';
            popupFormWrap.style.display = 'block';
            popupFormScreen.style.display = 'block';
        }

        function btnNextHandler() {
            const currentFields = popupForm.querySelector(`[data-index="${ currentIndex }"]`);
            const checkboxInputs = currentFields.querySelectorAll('input[type="checkbox"]');
            checkboxInputs.forEach(el => {
                if (el.checked) {
                    markedCheckboxes++;
                }
            });

            inputsCounter += checkboxInputs.length;

            currentIndex++;
            if (currentIndex < popupFormFields.length) {
                renderContent(currentIndex);
                // Change button text to "Результат" on the last form field
                if (currentIndex === popupFormFields.length - 1) {
                    btnNext.textContent = "Результат";
                } else {
                    btnNext.textContent = "Далее";
                }
            }
            else {
                const allChecked = markedCheckboxes === inputsCounter; // Determine if all checkboxes are checked
                showResult(allChecked);
            }
        }

        function renderContent(index) {
            popupFormFields.forEach((field, idx) => {
                field.style.display = idx === index ? 'block' : 'none';
            });

            const progressValue = ((index + 1) / Math.min(popupFormFields.length, 5)) * 100;
            progressBar.style.width = `${progressValue}%`;
            progressBarFinalValue.textContent = '5';
            progressBarInitialValue.textContent = (index + 1).toString();
        }

        function resetForm() {
            isBonus = false;
            currentIndex = 0;
            markedCheckboxes = 0;
            inputsCounter = 0;
            popupForm.reset();
            renderContent(currentIndex);
            popupFormFields[0].style.display = 'block';
            popupResult.style.display = 'none';
        }

        function showResult(allChecked) {
            if (isBonus) {
                popupResultTitle.textContent = 'Получить бонусы от rh store';
                popupResultText.textContent = 'Оставьте свои контакты и мы вам перезвоним в течение 15 минут (в рабочее время)';
            }
            else if (allChecked) {
                popupResultTitle.textContent = 'Вы полностью готовы стать успешным селлером!';
                popupResultText.textContent = 'А значит, это повод заказать нашу продукцию. Оставьте свои контакты и мы вам перезвоним в течение 15 минут (в рабочее время)';
            }
            else {
                popupResultTitle.textContent = 'Не удалось отметить всё? Мы поможем это исправить';
                popupResultText.textContent = 'Мы можем вам помочь стать успешным селлером. Оставьте свои контакты и мы вам перезвоним в течение 15 минут (в рабочее время)';
            }

            popupResult.style.display = 'block';
            popupFormWrap.style.display = 'none';
            document.querySelector('.modal-checklist__fifth').style.display = 'none';
        }

        btnStart.addEventListener('click', btnStartHandler);
        btnNext.addEventListener('click', btnNextHandler);
        btnClose.addEventListener('click', btnCloseHandler);
        btnNote.addEventListener('click', () => {
            isBonus = true;
            showResult(true);
        });
        btnSubmit.addEventListener('click', () => {
            const allChecked = markedCheckboxes === inputsCounter;
            showResult(allChecked);
        });
        popup.addEventListener('click', (e) => {
            if (e.target === popup) {
                btnCloseHandler();
            }
        });
    }

    checklistSteps();
});
