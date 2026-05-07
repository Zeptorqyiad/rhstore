const toggleFaq = () => {
    const faqItems = document.querySelectorAll('.accordion');

    faqItems.forEach(function (item) {
        item.addEventListener('click', function () {
            this.classList.toggle('accordion_active');

        });
    });
}

document.addEventListener('DOMContentLoaded', toggleFaq);