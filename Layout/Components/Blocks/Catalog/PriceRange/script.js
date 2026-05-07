(() => {
    const prices = document.querySelectorAll('.price-range');

    prices.forEach(price => {
        const range = price.querySelector(".price-range__selected");
        const rangeInput = price.querySelectorAll(".price-range__input input");
        const rangePrice = price.querySelectorAll(".price-range__price input");
        const maxRangeValue = parseInt(rangeInput[0].max);
        const minRangeValue = parseInt(rangeInput[0].min);
        let rangeMin = (maxRangeValue - minRangeValue) / 10; // Minimum range difference set to 10% of the max value

        const updateRange = (min, max) => {
            rangePrice[0].value = min;
            rangePrice[1].value = max;
            range.style.left = ((min - minRangeValue) / (maxRangeValue - minRangeValue)) * 100 + "%";
            range.style.right = 100 - ((max - minRangeValue) / (maxRangeValue - minRangeValue)) * 100 + "%";
        };

        const handleInputChange = (e) => {
            let minRange = parseInt(rangeInput[0].value);
            let maxRange = parseInt(rangeInput[1].value);

            if (maxRange - minRange < rangeMin) {
                if (e.target.classList.contains("min")) {
                    rangeInput[0].value = maxRange - rangeMin;
                } else {
                    rangeInput[1].value = minRange + rangeMin;
                }
            } else {
                updateRange(minRange, maxRange);
            }
        };

        const handlePriceChange = (e) => {
            let minPrice = parseInt(rangePrice[0].value) || minRangeValue;
            let maxPrice = parseInt(rangePrice[1].value) || maxRangeValue;

            if (minPrice < minRangeValue) minPrice = minRangeValue;
            if (maxPrice > maxRangeValue) maxPrice = maxRangeValue;
            if (maxPrice - minPrice < rangeMin) {
                if (e.target.classList.contains("min")) {
                    minPrice = maxPrice - rangeMin;
                } else {
                    maxPrice = minPrice + rangeMin;
                }
            }

            rangeInput[0].value = minPrice;
            rangeInput[1].value = maxPrice;
            updateRange(minPrice, maxPrice);
        };

        window.addEventListener("load", () => {
            const initialMin = parseInt(rangeInput[0].value);
            const initialMax = parseInt(rangeInput[1].value);
            //updateRange(initialMin, initialMax);
        });

        rangeInput.forEach(input => {
            input.addEventListener("input", handleInputChange);
        });

        rangePrice.forEach(input => {
            input.addEventListener("input", handlePriceChange);
        });
    });
})();
