<?php

/** @var array $data */
extract($data);
$cn = " $className " . ($style ? "tag-product_style-$style" : '');

?>

<span class="tag-product <?= $cn ?>">
    <?= $text ?>
</span>