<?php
/** @var array $data */

?>

<?php if (!empty($data['advantages_title'])): ?>
<section class="<?= $data["class_name"] ?> advantages">
    <div class="wrapper">
        <h2 class="advantages__title">
            <?= $data["advantages_title"] ?>
        </h2>

        <ul class="advantages__container">
            <?php foreach ($data['advantages'] as $i)
            App\Layout\Components\Common\AdvantageCard\Layout::draw([
                'class_name' => 'advantages__card',
                'title' => $i['title'],
                'text' => $i['text'],
                'image' => $i['img'],
            ]); ?>
        </ul>
    </div>
</section>
<?php endif; ?>