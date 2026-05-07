document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.text-field').forEach(textField => {
        const input = textField.querySelector('input');

        if (textField.hasAttribute('data-validate')) {

            input.addEventListener('input', (ev) => {
               const value =  ev.target.value.trim();
               const validateType = textField.dataset.validate;

               switch (validateType) {
                   case 'name': {
                       if (!value) {
                           textField.classList.add('text-field_error');
                           textField.removeAttribute('data-valid');
                       } else {
                           textField.classList.remove('text-field_error');
                           textField.setAttribute('data-valid', '');
                       }
                   } break;
                   case 'phone': {
                       if (!value) {
                           textField.classList.add('text-field_error');
                           textField.removeAttribute('data-valid');
                       } else if (value.length < 16) {
                           textField.classList.add('text-field_error');
                           textField.removeAttribute('data-valid');
                       } else {
                           textField.setAttribute('data-valid', '');
                           textField.classList.remove('text-field_error');
                       }
                   } break;
                   case 'email': {
                       if (!value) {
                           textField.classList.add('text-field_error');
                           textField.removeAttribute('data-valid');
                       } else if (!isValidEmail(value)) {
                           textField.classList.add('text-field_error');
                           textField.removeAttribute('data-valid');
                       } else {
                           textField.classList.remove('text-field_error');
                           textField.setAttribute('data-valid', '');
                       }
                   } break;
                   default: {

                   } break;
               }
            });
        }


        if (input.type === 'tel') {
            const maskOptions = {
                mask: '+{7} 000 000-00-00'
            };
            const mask = IMask(input, maskOptions);
        }
    });
});