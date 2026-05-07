<?php /** @var array $data */ ?>

<?php

extract($data);
$tag = $asLink ? 'a' : 'span';
$href = $asLink ? "href='$href'" : '';
$content = "<$tag $href class='tab-dropdown__text'>$text</$tag>";

?>


<li
    <?php
    foreach ($attrs as $key => $val): ?>
        <?= "$key='$val'" ?><?php
    endforeach; ?>
        class="tab-dropdown <?= $className ?>">
    <?= $content ?>
</li>