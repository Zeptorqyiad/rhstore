<?php
/** @var array $data */
?>
<?php
$secondary = $data["secondary"] ? ' slider-buttons_secondary' : '';
$data["class_name"] .= $secondary;
?>

<div class="slider-buttons <?= $data["class_name"] ?>">
    <button type="button" class="slider-buttons__button <?= $data["prev_class_name"] ?>">
        <svg xmlns="http://www.w3.org/2000/svg"
             viewBox="0 0 24 24" fill="none">
            <path d="M15 6L9 12L15 18"
                  stroke="#404040" stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"/>
        </svg>
    </button>
    <button type="button" class="slider-buttons__button <?= $data["next_class_name"] ?>">
        <svg xmlns="http://www.w3.org/2000/svg"
             viewBox="0 0 24 24" fill="none">
            <path d="M9 18L15 12L9 6"
                  stroke="#404040"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"/>
        </svg>
    </button>
</div>