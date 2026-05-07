<?php
/** @var array $data */

$saleCards = [
    [
        'id' => 'online',
        'title' => 'Онлайн-продажи',
        'info' => 'Быстрое масштабирование бизнеса за счет большого ассортимента товаров. Для селлеров у нас есть дополнительные услуги',
        'src' => '/assets/images/calc/sale-card-on.webp',
        'checked' => true
    ],
    [
        'id' => 'offline',
        'title' => 'Оффлайн-продажи',
        'info' => 'Возможность лично презентовать товар, консультировать клиентов и создавать доверительные отношения',
        'src' => '/assets/images/calc/sale-card-off.webp',
    ],
];
?>

<?php
foreach ($saleCards as $card): ?>

<li class="sales-cards__item">
    <input class="sales-cards__input badge-small"
           type="radio"
           name="sale"
           id="<?= $card['id'] ?>"<?= isset($card['checked']) && $card['checked'] ? 'checked' : '' ?>>
    <label for="<?= $card['id'] ?>" class="sales-cards__label">
        <div class="sales-cards__content">
            <h4 class="sales-cards__title"><?= $card['title'] ?></h4>
            <p class="sales-cards__info"><?= $card['info'] ?></p>
        </div>
        <img src="<?= $card['src'] ?>" alt="title">
    </label>

</li>
<?php
endforeach; ?>