<?php
/** @var array $data */
?>

<?php if (!empty($data['badges'])): ?>
<section class="<?= $data["class_name"] ?> main-brands">
    <div class="main-brands__container wrapper">
        <div class="main-brands__text">
            <h2 class="main-brands__title">
                <?= $data["title"] ?>
            </h2>
            <p class="main-brands__description">
                <?= $data["text"] ?>
            </p>
        </div>
        <ul class="main-brands__tabs">
            <?php
            foreach ($data['badges'] as $badge): ?>
                <li class="main-brands__tab">
                    <a href="<?= $badge['link'] ?>" class="main-brands__tab-link" draggable="false">
                        <?= $badge['text'] ?>
                    </a>
                </li>
            <?php endforeach; ?>
        </ul>
    </div>
</section>
<?php endif; ?>