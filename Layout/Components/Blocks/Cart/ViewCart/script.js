document.addEventListener('DOMContentLoaded', () => {
    // Get all cart items
    const cartItems = document.querySelectorAll('.view-cart__card');

    // Get all recommendation cards
    const recommendationCards = document.querySelectorAll('.product-card__mobile-cart');

    // Create a Set of cart item IDs for efficient lookup
    const cartItemIds = new Set(
        Array.from(cartItems).map(item => item.querySelector('[data-id]')?.dataset.id)
    );

    // Check each recommendation card
    recommendationCards.forEach(card => {
        const cardId = card.querySelector('[data-id]')?.dataset.id;

        // If the card's ID is in the cart, add a class to hide its swiper-slide parent
        if (cardId && cartItemIds.has(cardId)) {
            const swiperSlide = card.closest('.swiper-slide');
            if (swiperSlide) {
                swiperSlide.classList.add('hidden');
            }
        }
    });
});
