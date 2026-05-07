<?php
/** @var array $data */

$cn = "button-" . $data["style"];
$cn .= $data["class_name"] ? ' ' . $data["class_name"] : '';
?>

<a class="<?= $cn ?>" href="<?=$data['href']?>" draggable="false">
    <span><?= $data["text"] ?></span>

    <?php
    if ($data["icon"]): ?>
        <svg xmlns="http://www.w3.org/2000/svg"
             viewBox="0 0 24 24"
             fill="none"
             stroke="#ffffff">
            <path d="M9 18L15 12L9 6"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"/>
        </svg>
    <?php
    endif; ?>
</a>