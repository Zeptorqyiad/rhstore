document.addEventListener('DOMContentLoaded', () => {
    const form = document.querySelector('.ask-form');
    form.addEventListener('submit', e => {
        e.preventDefault();

        const msg = form.querySelector('.ask-form__textarea textarea');
        api.user.makeQuestion(msg.value, () => {
            window.location.reload();
        });
    });
});