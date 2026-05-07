// function positionHint(button, hint) {
//     const buttonRect = button.getBoundingClientRect();
//     const viewportWidth = window.innerWidth;
//
//     // Make the hint visible but transparent for accurate measurements
//     hint.style.opacity = '0';
//     hint.style.display = 'block';
//
//     // Get updated hint dimensions after making it visible
//     const hintRect = hint.getBoundingClientRect();
//
//     // Calculate top position (above the button)
//     let top = buttonRect.top - hintRect.height - 10; // 10px gap
//
//     // If there's not enough space above, position it below the button
//     if (top < 10) {
//         top = buttonRect.bottom + 10;
//     }
//
//     // Calculate left position (centered on the button)
//     let left = buttonRect.left + (buttonRect.width / 2) - (hintRect.width / 2);
//
//     // Ensure the hint doesn't go off the left or right edges of the screen
//     left = Math.max(10, Math.min(viewportWidth - hintRect.width - 10, left));
//
//     // Apply the position
//     hint.style.top = `${top}px`;
//     hint.style.left = `${left}px`;
//
//     // Make the hint fully visible
//     hint.style.opacity = '1';
// }
//
// document.querySelectorAll('.sale-info__button').forEach(button => {
//     const hint = button.nextElementSibling;
//     if (hint && hint.classList.contains('sale-info__hint')) {
//         button.addEventListener('mouseenter', () => {
//             positionHint(button, hint);
//         });
//         button.addEventListener('mouseleave', () => {
//             hint.style.opacity = '0';
//             hint.style.display = 'none';
//         });
//     }
// });
//
// // Reposition hints on window resize
// window.addEventListener('resize', () => {
//     document.querySelectorAll('.sale-info__button').forEach(button => {
//         const hint = button.nextElementSibling;
//         if (hint && hint.classList.contains('sale-info__hint') && hint.style.opacity === '1') {
//             positionHint(button, hint);
//         }
//     });
// });