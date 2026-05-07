<?php
/** @var array $data */

$items = json_decode($data['items'], true)['v'] ?? [];
?>

<?php if ($data['title'] || $data['text'] || $data['items']): ?>
    <section class="promo-faq wrapper">
        <div class="promo-faq__content">
            <div class="promo-faq__content-ls">
                <?php if ($data['title']): ?>
                    <h2 class="promo-faq__title">
                        <?= $data['title'] ?>
                    </h2>
                <?php endif; ?>
                <?php if ($data['text']): ?>
                    <div class="promo-faq__text">
                        <?= $data['text'] ?>
                    </div>
                <?php endif; ?>
            </div>
            <div class="promo-faq__content-rs">
                <?php foreach ($items as $i):
                    App\Layout\Components\Common\Accordion\Layout::draw([
                        'title' => $i['title'],
                        'text' => $i['text'],
                    ]);
                endforeach; ?>
            </div>
        </div>
    </section>
<?php endif; ?>