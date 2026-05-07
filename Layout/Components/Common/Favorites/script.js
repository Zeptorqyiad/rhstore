document.addEventListener("DOMContentLoaded", () => {
    // Select all elements with the class 'favorites'
    const favorites = document.querySelectorAll(".favorites");

    // Select the like button element
    const btnLike = document.querySelector('.header__button-like');

    // Function to get favorite states from local storage
    function getFavoriteStates() {
        const storedFavorites = localStorage.getItem('favorites');
        return storedFavorites ? JSON.parse(storedFavorites) : {};
    }

    // Function to save favorite states to local storage
    function saveFavoriteStates(favoriteStates) {
        localStorage.setItem('favorites', JSON.stringify(favoriteStates));
    }

    // Function to initialize button states
    function initializeButtonStates() {
        const favoriteStates = getFavoriteStates();
        favorites.forEach(item => {
            const productId = item.dataset.id;
            if (favoriteStates[productId]) {
                item.classList.add('favorites_active');
                if(item.querySelector('span')) {
                    item.querySelector('span').textContent = 'В избранном';
                }
            }
        });
        updateLikeButtonCount(Object.keys(favoriteStates).length);
    }

    // Function to update like button count
    function updateLikeButtonCount(count) {
        btnLike.dataset.count = count;
        if (count > 0) {
            btnLike.classList.add('active');
        } else {
            btnLike.classList.remove('active');
        }
    }

    // Initialize button states
    initializeButtonStates();

    // Iterate over each favorite item
    favorites.forEach(item => {
        item.addEventListener("click", () => {
            const productId = item.dataset.id;
            const favoriteStates = getFavoriteStates();

            // Toggle favorite state
            if (!favoriteStates[productId]) {
                // Add to favorites
                api.favorite.add(productId, item.dataset.variant, () => {
                    favoriteStates[productId] = true;
                    saveFavoriteStates(favoriteStates);

                    item.classList.add('favorites_active');
                    if(item.querySelector('span')) {
                        item.querySelector('span').textContent = 'В избранном';
                    }

                    updateLikeButtonCount(Object.keys(favoriteStates).length);
                });
            } else {
                // Remove from favorites
                api.favorite.remove(productId, item.dataset.variant, () => {
                    delete favoriteStates[productId];
                    saveFavoriteStates(favoriteStates);

                    item.classList.remove('favorites_active');
                    if(item.querySelector('span')) {
                        item.querySelector('span').textContent = 'В избранное';
                    }

                    updateLikeButtonCount(Object.keys(favoriteStates).length);
                });
            }
        });
    });
});