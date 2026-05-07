<?php
/** @var array $data */

?>
<?php
$secondary = $data["secondary"] ? ' sale-info_secondary' : '';
$data["class_name"] .= $secondary;
?>

<div class="sale-info <?= $data["class_name"] ?>" <?= $data['dt'] ?>>
    <button type="button" class="sale-info__button">
    <span class="sale-info__text">
        <?= $data["text"] ?>
    </span>

        <?php
        if ($data['hint_text']): ?>
            <svg viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" clip-rule="evenodd"
                      d="M13 7C13 10.3137 10.3137 13 7 13C3.68629 13 1 10.3137 1 7C1 3.68629 3.68629 1 7 1C10.3137 1 13 3.68629 13 7ZM8 4C8 4.55228 7.55228 5 7 5C6.44772 5 6 4.55228 6 4C6 3.44772 6.44772 3 7 3C7.55228 3 8 3.44772 8 4ZM7 6C6.44772 6 6 6.44772 6 7V10C6 10.5523 6.44772 11 7 11C7.55228 11 8 10.5523 8 10V7C8 6.44772 7.55228 6 7 6Z"
                      fill="#404040"/>
            </svg>
        <?php
        endif; ?>
    </button>

    <?php
    if ($data['hint_text']): ?>
        <div class="sale-info__hint">
            <p class="sale-info__hint-text">
                <?= $data["hint_text"] ?>
            </p>
        </div>
    <?php
    endif; ?>
</div>
