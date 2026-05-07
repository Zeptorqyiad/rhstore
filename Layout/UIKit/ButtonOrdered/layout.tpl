<?php
/** @var array $data */ ?>

<?php
extract($data);
$user = \Simflex\Core\Container::getUser();
$hasOrdered = \Simflex\Core\Container::getUser()?->hasOldProducts();
?>

<div class="button-ordered <?= $class_name ?>">
    <a href="/past/" class="button-ordered__link" draggable="false">
        <svg class="button-ordered__icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 25 24">
            <g clip-path="url(#a)">
                <path fill="#fff" fill-rule="evenodd" d="M12.5 4a8 8 0 1 0 7.791 9.823l-.384.384a1 1 0 0 1-1.414-1.414l2-2a1 1 0 0 1 1.415 0l2 2a1 1 0 0 1-1.415 1.414l-.195-.195C21.367 18.57 17.334 22 12.5 22c-5.523 0-10-4.477-10-10s4.477-10 10-10a9.996 9.996 0 0 1 8.616 4.92 1 1 0 0 1-1.723 1.018A7.996 7.996 0 0 0 12.5 4Zm0 2a1 1 0 0 1 1 1v4.465l2.555 1.703a1 1 0 0 1-1.11 1.664l-3-2A1 1 0 0 1 11.5 12V7a1 1 0 0 1 1-1Z" clip-rule="evenodd"/>
            </g>
            <defs>
                <clipPath id="a">
                    <path fill="#fff" d="M.5 0h24v24H.5z"/>
                </clipPath>
            </defs>
        </svg>

        <span><?= $text ?></span>
    </a>

    <?php if (!$hasOrdered): ?>
        <div class="button-ordered__hint">
            <p class="button-ordered__hint-text"><?= !$user ? 'Войдите, чтобы воспользоваться' : 'Создайте заказ, чтобы воспользоваться' ?></p>
        </div>
    <?php endif; ?>
</div>




