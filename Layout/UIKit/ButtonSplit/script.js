document.addEventListener("DOMContentLoaded", () => {
    const buttons = document.querySelectorAll('.button-split');

    buttons.forEach(btn => {
        btn.addEventListener('click', ()=> {
            document.querySelector('.dialog-split__price-val').textContent = btn.dataset.price;
            openSplitModal();
        })
    })
});