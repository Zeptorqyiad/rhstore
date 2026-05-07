<?php
/** @var array $data */


?>

<div class="catalog-badge">

    <svg class="catalog-badge__red"
         xmlns="http://www.w3.org/2000/svg"
         width="20"
         height="20"
         viewBox="0 0 20 20"
         fill="none">
        <path d="M10.0003 18.3333C14.5837 18.3333 18.3337 14.5833 18.3337 9.99999C18.3337 5.41666 14.5837 1.66666 10.0003 1.66666C5.41699 1.66666 1.66699 5.41666 1.66699 9.99999C1.66699 14.5833 5.41699 18.3333 10.0003 18.3333Z"
              stroke="#FF3838"
              stroke-width="1.5"
              stroke-linecap="round"
              stroke-linejoin="round" />
        <path d="M10 6.66666V10.8333"
              stroke="#FF3838"
              stroke-width="1.5"
              stroke-linecap="round"
              stroke-linejoin="round" />
        <path d="M9.99609 13.3333H10.0036"
              stroke="#FF3838"
              stroke-width="1.5"
              stroke-linecap="round"
              stroke-linejoin="round" />
    </svg>

    <svg class="catalog-badge__green"
         xmlns="http://www.w3.org/2000/svg"
         width="20"
         height="20"
         viewBox="0 0 20 20"
         fill="none">
        <path fill-rule="evenodd"
              clip-rule="evenodd"
              d="M10 20C15.5228 20 20 15.5228 20 10C20 4.47715 15.5228 0 10 0C4.47715 0 0 4.47715 0 10C0 15.5228 4.47715 20 10 20ZM8.05937 13.8089C8.02203 13.7798 7.98596 13.7482 7.95139 13.7143L5.37281 11.1832C4.87645 10.696 4.87563 9.90415 5.37097 9.41593C5.86559 8.92842 6.66753 8.92842 7.16215 9.41593L8.86456 11.0939L13.2929 6.72918C13.7874 6.24179 14.5892 6.24179 15.0837 6.72918C15.5791 7.21745 15.578 8.0094 15.0814 8.49643L9.74415 13.7303C9.28213 14.1834 8.55213 14.2094 8.05937 13.8089Z"
              fill="#379948" />
    </svg>
    <span class="catalog-bagde__text"><?= $data["badge_text"] ?></span>
</div>