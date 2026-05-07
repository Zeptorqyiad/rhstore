<?php

/** @var array $data */
extract($data);

?>
<div class="tab-questions">
    <span class="tab-questions__text"><?= $text ?></span>
    <div class="tab-questions__icons">
        <?php
        if ($badge) {
            App\Layout\UIKit\Badge\Layout::draw([
                'text' => $badge,
                'style' => 'red',
                'className' => 'tab-questions__badge'
            ]);
        }
        ?>
        <i class="tab-questions__icon">
            <svg viewBox="0 0 16 16">
                <use xlink:href="/assets/icons/svg-defs.svg#arrow-mini"></use>
            </svg>
        </i>
    </div>
</div>