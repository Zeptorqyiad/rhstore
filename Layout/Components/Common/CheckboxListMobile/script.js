document.addEventListener('DOMContentLoaded', function(e) {
    e.preventDefault();
    // Select all checkbox-list-mobile elements
    let checkboxListMobileElements = document.querySelectorAll('.checkbox-list-mobile');

    // Add click event listeners to each element
    checkboxListMobileElements.forEach(function(element) {
        element.addEventListener('click', function(event) {
            // Prevent the click event from propagating to avoid double toggling
            event.stopPropagation();

            // Find the checkbox within the current checkbox-list-mobile element
            let checkbox = this.querySelector('.checkbox-mobile-list__check input[type="checkbox"]');

            // Toggle the checkbox state
            if (checkbox) {
                checkbox.checked = !checkbox.checked;
                // Trigger change event if necessary
                let changeEvent = new Event('change', { bubbles: true });
                checkbox.dispatchEvent(changeEvent);
            }
        });
    });
});