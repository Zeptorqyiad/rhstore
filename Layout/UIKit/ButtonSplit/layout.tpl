<?php
/** @var array $data */ ?>

<?php
extract($data);

$isSplit = $type === 'split';
$class = $isSplit ? 'button-split' : 'button-credit';
?>


<div class="<?= $class ?>" data-price="<?= $price ?>">
    <div class="<?= $class ?>__column">
        <?php
        if ($isSplit): ?>
            <img class="<?= $class ?>__sber-logo"
                 src="/assets/sber-split.webp" alt="sber logo">
            <span class="<?= $class ?>__text">Плати частями</span>
        <?php
        else: ?>
            <img class="<?= $class ?>__sber-logo"
                 src="/assets/sber-credit.webp" alt="sber logo">
            <span class="<?= $class ?>__text"><i>Кредит</i>  от 3500 ₽ в месяц</span>
        <?php
        endif; ?>
    </div>
    <svg class="<?= $class ?>__info-logo"
         width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M7.99998 14.6667C11.6666 14.6667 14.6666 11.6667 14.6666 8C14.6666 4.33334 11.6666 1.33334 7.99998 1.33334C4.33331 1.33334 1.33331 4.33334 1.33331 8C1.33331 11.6667 4.33331 14.6667 7.99998 14.6667Z"
              stroke="#74767A" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
        <path fill-rule="evenodd" clip-rule="evenodd"
              d="M7.9964 4.28333C7.58219 4.28333 7.2464 4.61912 7.2464 5.03333C7.2464 5.44755 7.58219 5.78333 7.9964 5.78333H8.00239C8.4166 5.78333 8.75239 5.44755 8.75239 5.03333C8.75239 4.61912 8.4166 4.28333 8.00239 4.28333H7.9964ZM8.74998 7.7C8.74998 7.28579 8.41419 6.95 7.99998 6.95C7.58577 6.95 7.24998 7.28579 7.24998 7.7V11.0333C7.24998 11.4475 7.58577 11.7833 7.99998 11.7833C8.41419 11.7833 8.74998 11.4475 8.74998 11.0333V7.7Z"
              fill="#74767A"/>
    </svg>
</div>