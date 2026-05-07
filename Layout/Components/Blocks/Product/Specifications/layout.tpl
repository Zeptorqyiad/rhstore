<?php
/** @var array $data */

/** @var \App\Extensions\Catalog\Model\Product $p */
$p = $data['prod'];
?>

<div class="<?= $data["class_name"] ?> specifications">
    <div class="specifications__table">
        <?php
        if ($p->sku): ?>
            <div class="specifications__table-line">
                <p class="specifications__table-title">
                    Артикул
                </p>
                <p class="specifications__table-text">
                    <?= $p->sku ?>
                </p>
            </div>
        <?php
        endif; ?>

        <div class="specifications__table-line">
            <p class="specifications__table-title">
                Категория
            </p>
            <p class="specifications__table-text">
                <?= $p->getFirstCategory()->name ?>
            </p>
        </div>
        <?php
        if ($p->brand_id): ?>
            <div class="specifications__table-line">
                <p class="specifications__table-title">
                    Подходит к устройствам
                </p>
                <p class="specifications__table-text">
                    <?= $p->brand->name ?>
                </p>
            </div>
        <?php
        endif; ?>

        <?php
        $var = $p->getVariantParams();
        ?>
        <?php
        foreach (\App\Extensions\Catalog\ProductAssist::getParamsForProduct($p, $data['vis_only'] ?? true) as $c): ?>
            <?php
            foreach ($c['data'] as $pp):
                if (!($var[$pp->param_id] ?? '')) {
                    continue;
                } ?>
                <div class="specifications__table-line">
                    <p class="specifications__table-title"><?= $pp->name ?></p>
                    <?php
                    if (!$pp->is_bool): ?>
                        <p class="specifications__table-text"><?= $var[$pp->param_id] ?? '' ?></p>
                    <?php
                    else: ?>
                        <p class="specifications__table-text"><?= !!($var[$pp->param_id] ?? '') ? 'Да' : 'Нет' ?></p>
                    <?php
                    endif; ?>
                </div>
            <?php
            endforeach; ?>
        <?php
        endforeach; ?>
    </div>
</div>