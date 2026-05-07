<?php
/** @var array $data */ ?>

<?php
extract($data);
$cn = "badge_style-$style $className";

?>
<span
            <?php
            foreach ($attrs as $key => $val): ?>
                <?= "$key='$val'" ?><?php
            endforeach; ?>
    class="badge <?= $cn ?>" data-badge>
    <?= $text ?>
</span>