<?php
/** @var array $data */

?>

<div class="<?= $data["class_name"] ?> dropdown" <?= $data['ns'] ? 'data-ns="true"' : '' ?>>
    <label class="dropdown__label">
        <input class="dropdown__input" type="text" value="<?= $data['items'][$data['value'] ?? ''] ?? '' ?>"
               placeholder="<?= $data["placeholder"] ?>" readonly>
        <input type="hidden" name="<?= $data['name'] ?>" value="<?= $data['value'] ?>">

        <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" clip-rule="evenodd"
                  d="M15.7071 9.29289C15.3166 8.90237 14.6834 8.90237 14.2929 9.29289L12 11.5858L9.70711 9.29289C9.31658 8.90237 8.68342 8.90237 8.29289 9.29289C7.90237 9.68342 7.90237 10.3166 8.29289 10.7071L11.2929 13.7071C11.6834 14.0976 12.3166 14.0976 12.7071 13.7071L15.7071 10.7071C16.0976 10.3166 16.0976 9.68342 15.7071 9.29289Z"
                  fill="#404040"/>
        </svg>
    </label>

    <div class="dropdown__content">
        <ul class="dropdown__options">
            <?php
            foreach ($data['items'] as $k => $i): ?>
                <li data-value="<?= $k ?>" class="dropdown__option" <?= is_array(
                    $i
                ) ? ('data-price="' . $i[1] . '"') : '' ?>><?= is_array($i) ? $i[0] : $i ?></li>
            <?php
            endforeach; ?>
        </ul>
    </div>

</div>