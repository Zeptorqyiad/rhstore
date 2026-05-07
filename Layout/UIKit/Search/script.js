document.addEventListener('DOMContentLoaded', () => {
    const searchComponents = document.querySelectorAll('.search');


    searchComponents.forEach(search => {
        const input = search.querySelector('.search__input');

        search.addEventListener('focusin', () => {
            search.classList.add('search_focused');
        });

        search.addEventListener('focusout', () => {
            search.classList.remove('search_focused');
        })

    });
})