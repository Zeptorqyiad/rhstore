<?php

/** @var array $data */
extract($data);
$cn = ($active ? 'tab-underline_active ' : ' ') . $className;


?>
<div

    <?php
    foreach ($attrs as $key => $val): ?>
        <?= "$key='$val'" ?><?php
    endforeach; ?>
    class="tab-underline <?= $cn ?>">
    <span class="tab-underline__text"><?= $text ?></span>
    <?php
    if ($badge): ?>
        <span class="tab-underline__badge"><?= $badge ?></span>
    <?php
    endif; ?>
</div>