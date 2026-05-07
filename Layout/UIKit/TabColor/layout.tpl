<?php /** @var array $data */?>

<?php
extract($data);
$cn = ($active ? 'tab-color_active ' : ' ') . $className;

?>


<a href="<?= $path ?>" class="tab-color <?= $cn ?>">
    <img data-lazy="<?= $img ?>" alt="" class="tab-color__img">
</a>