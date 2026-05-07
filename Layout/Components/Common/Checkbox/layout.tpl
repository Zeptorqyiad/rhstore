<?php
/** @var array $data */
extract($data);
$checkedAttr = $checked ? 'checked' : '';
$nameAttr = $name ? "name='$name'" : '';
$requiredAttr = $required ? 'required' : '';
?>

<label class="<?= $data["class_name"] ?> checkbox">
    <input class="checkbox__custom-checkbox"
           value="<?= $value ?>"
           type="checkbox"
        <?= $requiredAttr ?>
        <?= $checkedAttr ?>
        <?= $nameAttr ?>
    >
    <span class="checkbox__checkmark">
        <svg viewBox="0 0 12 8" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M1 3.5L4.5 7L10.5 1"
                  stroke="black"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
            />
        </svg>
    </span>
    <?php if ($text): ?>
        <span class="checkbox__text"><?= $text ?>
            <?php if ($link): ?>
                <a class="checkbox__link" href="<?= $path ?>" target="_blank"><?= $link ?></a>
            <?php endif; ?>
        </span>

    <?php endif; ?>


</label>