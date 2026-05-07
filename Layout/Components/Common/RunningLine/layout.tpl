<section class="running-line">
    <div class="running-line__marquee">
        <ul class="running-line__content">
            <?php
            $arr = \App\Extensions\Catalog2\Model\Banner::findAdv()->where('is_active = 1')->where('type = \'header\'')->orderBy('npp')->all();
            if (count($arr) < 10) {
                $oa = $arr;
                $arr = [];
                $oac = count($oa);
                $i = 0;
                while (count($arr) < 10) {
                    $arr[$i] = $oa[$i % $oac];
                    ++$i;
                }
            }
            ?>

            <?php foreach ($arr as $b): ?>
                <li class="running-line__item">
                    <?php if ($b->link): ?>
                        <a class="running-line__link"
                           href="<?= $b->link ?>"
                           target="_blank"
                           draggable="false"
                        >
                            <?= $b->title ?>
                        </a>
                    <?php else: ?>
                        <?= $b->title ?>
                    <?php endif; ?>
                </li>
            <?php
            endforeach; ?>
        </ul>

        <ul class="running-line__content" aria-hidden="true">
            <?php foreach ($arr as $b): ?>
                <li class="running-line__item">
                    <?php if ($b->link): ?>
                        <a class="running-line__link"
                           href="<?= $b->link ?>"
                           target="_blank"
                           draggable="false"
                        >
                            <?= $b->title ?>
                        </a>
                    <?php else: ?>
                        <?= $b->title ?>
                    <?php endif; ?>
                </li>
            <?php endforeach; ?>
        </ul>
    </div>
</section>