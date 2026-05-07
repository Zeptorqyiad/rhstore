document.addEventListener('DOMContentLoaded', () => {
    document.querySelector('.js--send-email').addEventListener('click', () => {
        api.auth.resendMail(() => {
            document.querySelector('.modal-notification').showModal();
        });
    });
});