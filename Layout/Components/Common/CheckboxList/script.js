document.addEventListener("DOMContentLoaded", () => {
   const checkboxLists = document.querySelectorAll('.catalog-filters__check-list-item.checkbox-list');

   checkboxLists.forEach(list => {
      const checkboxBtn = list.querySelector('.checkbox-list__button');
      const checkboxItems = list.querySelectorAll('.checkbox-list__item');
      const searchInput = list.querySelector('.text-field__input');
      const checkboxesContainer = list.querySelector('.checkbox-list__checkboxes');
      const isInsideModalChecklist = list.closest('.modal-checklist') !== null;

      let allItemsVisible = false;

      const notFoundElement = document.createElement('li');
      notFoundElement.className = 'checkbox-list__item checkbox-list__not-found';
      notFoundElement.textContent = 'Не найдено';
      notFoundElement.style.display = 'none';
      checkboxesContainer.appendChild(notFoundElement);

      function updateVisibility() {
         const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';
         let visibleCount = 0;
         let totalMatchCount = 0;

         checkboxItems.forEach((item, index) => {
            if (item.classList.contains('checkbox-list__not-found')) return;

            const text = item.querySelector('.checkbox__text').textContent.toLowerCase();
            const matchesSearch = text.includes(searchTerm);

            if (matchesSearch) {
               totalMatchCount++;
               if (allItemsVisible || visibleCount < 5 || isInsideModalChecklist) {
                  item.style.display = '';
                  visibleCount++;
               } else {
                  item.style.display = 'none';
               }
            } else {
               item.style.display = 'none';
            }
         });

         notFoundElement.style.display = totalMatchCount === 0 ? '' : 'none';

         if (checkboxBtn) {
            if (totalMatchCount > 5 && !isInsideModalChecklist && searchTerm === '') {
               checkboxBtn.style.display = 'flex';
               checkboxBtn.textContent = allItemsVisible ? 'Скрыть' : 'Показать все';
            } else {
               checkboxBtn.style.display = 'none';
            }
         }
      }

      if (checkboxBtn && !isInsideModalChecklist) {
         checkboxBtn.addEventListener('click', () => {
            allItemsVisible = !allItemsVisible;
            updateVisibility();
         });
      }

      if (searchInput) {
         searchInput.addEventListener('input', updateVisibility);

         searchInput.addEventListener('keydown', (event) => {
            if (event.key === 'Enter') {
               event.preventDefault();
            }
         });
      }

      updateVisibility();
   });
});