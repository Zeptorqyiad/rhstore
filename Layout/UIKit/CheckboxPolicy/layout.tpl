<?php
/** @var array $data */
extract($data);
$checkedAttr = $checked ? 'checked' : '';
$nameAttr = $name ? "name='$name'" : '';
$requiredAttr = $required ? 'required' : '';
$validate = $data['validate'] ?? '';
?>

<label class="<?= $data["class_name"] ?> checkbox-policy">
    <input class="checkbox-policy__custom-checkbox"
           value="<?= $value ?>"
           type="checkbox"
        <?= $requiredAttr ?>
        <?= $checkedAttr ?>
        <?= $nameAttr ?>
        <?= $validate ? 'data-validate="' . $validate . '"' : '' ?>
    >
    <span class="checkbox-policy__checkmark">
        <svg viewBox="0 0 12 8" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M1 3.5L4.5 7L10.5 1"
                  stroke="black"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
            />
        </svg>
    </span>
    <span class="checkbox-policy__text">Нажимая на кнопку, вы соглашаетесь c <a class="underline" href="/policy/" draggable="false">политикой обработки персональных данных</a></span>
</label>