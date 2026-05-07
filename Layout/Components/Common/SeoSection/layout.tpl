<?php
/** @var array $data */
?>

<?php if ($data['seo_title_1'] || $data['seo_text_1'] || $data['seo_title_2'] || $data['seo_text_2']): ?>
    <section class="seo-section">
        <ul class="seo-section__container  wrapper">
            <li class="seo-section__column">
                <h2 class="seo-section__column-title"><?= $data["seo_title_1"] ?></h2>
                <div class="seo-section__column-text"><?= $data["seo_text_1"] ?></div>
            </li>
            <li class="seo-section__column">
                <h2 class="seo-section__column-title"><?= $data["seo_title_2"] ?></h2>
                <div class="seo-section__column-text"><?= $data["seo_text_2"] ?></div>
            </li>
        </ul>
    </section>
<?php endif; ?>
