<?php
/** @var array $data */ ?>

<?php
extract($data);
$cn = "link-main_style-$style $className";
?>

<a class="link-main <?= $cn ?>" href="<?= $href ?>"><?= $text ?></a>