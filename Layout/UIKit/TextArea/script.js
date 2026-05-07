document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.text-area').forEach(textArea => {
        const input = textArea.querySelector('textarea');

        if (textArea.hasAttribute('data-validate')) {

            input.addEventListener('input', (ev) => {
                const value =  ev.target.value.trim();
                const validateType = textArea.dataset.validate;

                switch (validateType) {
                    case 'name': {
                        if (!value) {
                            textArea.classList.add('text-area_error');
                            textArea.removeAttribute('data-valid');
                        } else {
                            textArea.classList.remove('text-area_error');
                            textArea.setAttribute('data-valid', '');
                        }
                    } break;
                    case 'phone': {
                        if (!value) {
                            textArea.classList.add('text-area_error');
                            textArea.removeAttribute('data-valid');
                        } else if (value.length < 16) {
                            textArea.classList.add('text-area_error');
                            textArea.removeAttribute('data-valid');
                        } else {
                            textArea.setAttribute('data-valid', '');
                            textArea.classList.remove('text-area_error');
                        }
                    } break;
                    case 'email': {
                        if (!value) {
                            textArea.classList.add('text-area_error');
                            textArea.removeAttribute('data-valid');
                        } else if (!isValidEmail(value)) {
                            textArea.classList.add('text-area_error');
                            textArea.removeAttribute('data-valid');
                        } else {
                            textArea.classList.remove('text-area_error');
                            textArea.setAttribute('data-valid', '');
                        }
                    } break;
                    default: {

                    } break;
                }
            });
        }
    });
});