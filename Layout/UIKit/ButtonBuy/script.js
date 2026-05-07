function initBuyButtons() {
    const buyBlocks = document.querySelectorAll('.buy-block');

    buyBlocks.forEach(block => {
        if (block.dataset.init && block.dataset.init !== "false") {
            return;
        }

        block.dataset.init = true;

        const addToCart = block.querySelector('[data-action="add-to-cart"]');
        const plusBtn = block.querySelector('[data-action="plus"]');
        const minusBtn = block.querySelector('[data-action="minus"]');
        const counter = block.querySelector('[data-counter]');
        const reqBtn = block.querySelector('[data-action="out-of-stock"]');

        if (reqBtn) {
            reqBtn.addEventListener('click', () => {
                updateOutOfStockModalContent(reqBtn.dataset.name);
                openOutOfStockModal();
            });

            return;
        }

        addToCart.addEventListener('click', async () => {
            const res = await addItemToCart(addToCart.dataset.id, addToCart.dataset.variant, 1);
            if (!res) {
                return;
            }

            PROD_QTY[block.dataset.id + '.' + block.dataset.variant] = 1;

            const allBlocks = document.querySelectorAll(`.buy-block[data-id="${block.dataset.id}"][data-variant="${block.dataset.variant}"]`);
            allBlocks.forEach(e => {
                const ec = e.querySelector('[data-counter]');
                ec.textContent = `1`;
                e.classList.add('buy-block_active');
                e.dispatchEvent(new Event('active'));
            });

            // const dataId = addToCart.dataset.id;
            // const buttonsAddToCart = document.querySelectorAll(`[data-id="${dataId}"][data-action="add-to-cart"]`)
            // // buttonsAddToCart.filter(item => {
            // //    return  item.dataset.action === "add-to-cart"
            // // })

            // console.log(...buttonsAddToCart);


            notify.addNotification({
                title: 'Товар добавлен в корзину',
                linkText: 'Перейти',
                link: '/cart/'
            });
        });

        plusBtn.addEventListener('click', async () => {
            const counterValue = parseInt(counter.textContent.replace(/ /g, ""));
            const res = await addItemToCart(plusBtn.dataset.id, plusBtn.dataset.variant, counterValue + 1);
            if (!res) {
                return;
            }

            PROD_QTY[block.dataset.id + '.' + block.dataset.variant] = counterValue + 1;

            const allBlocks = document.querySelectorAll(`.buy-block[data-id="${block.dataset.id}"][data-variant="${block.dataset.variant}"]`);
            allBlocks.forEach(e => {
                const ec = e.querySelector('[data-counter]');
                const counterValue = parseInt(ec.textContent.replace(/ /g, ""));
                ec.textContent = `${numberFormat((counterValue + 1), '', '', ' ')}`;
                e.dispatchEvent(new Event('plus'));
            });
        });

        minusBtn.addEventListener('click', async () => {
            const counterValue = parseInt(counter.textContent.replace(/ /g, ""));
            const res = addItemToCart(minusBtn.dataset.id, minusBtn.dataset.variant, counterValue - 1);
            if (!res) {
                return;
            }

            PROD_QTY[block.dataset.id + '.' + block.dataset.variant] = counterValue - 1;

            const allBlocks = document.querySelectorAll(`.buy-block[data-id="${block.dataset.id}"][data-variant="${block.dataset.variant}"]`);
            allBlocks.forEach(e => {
                const ec = e.querySelector('[data-counter]');
                const counterValue = parseInt(ec.textContent.replace(/ /g, ""));
                if (counterValue > 1) {
                    ec.textContent = `${numberFormat((counterValue - 1), '', '', ' ')}`;
                    e.dispatchEvent(new Event('minus'));
                } else {
                    removeItemFromCart(minusBtn.dataset.id, minusBtn.dataset.variant);
                    e.dispatchEvent(new Event('disable'));
                    e.classList.remove('buy-block_active');
                }
            });
        });

    });
}

document.addEventListener('DOMContentLoaded', () => {
    initBuyButtons();
});