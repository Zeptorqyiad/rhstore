<?php

/** @var array $data */
$selY = $_REQUEST['year'] ?? $data['y'][0];
?>

<ul class="<?= $data["class_name"] ?> archived-badges">
    <?php
    foreach ($data['y'] as $y): ?>
        <li class="archived-badges__badge <?= $selY == $y ? 'archived-badges__badge_active' : '' ?>">
            <?= $y ?>
        </li>
    <?php
    endforeach; ?>
</ul>