<?php
/** @var array $data */

?>

<section class="<?= $data["class_name"] ?> main-category">
    <div class="wrapper">
        <h2 class="main-category__title">Категории</h2>

        <ul class="main-category__cards">
            <?php
            foreach (\App\Extensions\Catalog\Model\Category::find('coalesce(pid, 0) = 0') as $cat):
                if (!$cat->is_active) {
                    continue;
                }
                ?>

                <li class="main-category__card">

                    <?php
                    if ($cat->photo_large): ?>
                        <img class="main-category__card-feature-image"
                             src="/uf/images/source/<?= $cat->photo_large ?>" alt="">
                    <?php
                    endif; ?>

                    <div class="main-category__card-top">
                        <h3 class="main-category__card-title">
                            <?= $cat->name ?>
                        </h3>
                        <?php
                        if ($cc = $cat->getChildren()): ?>
                            <ul class="main-category__card-features">
                                <?php
                                foreach ($cc as $c): ?>
                                    <li class="main-category__card-feature">
                                        <a class="main-category__card-link" href="/<?= $c->path ?>/">
                                            <p class="main-category__card-features-name">
                                                <?= $c->name ?>
                                            </p>
                                            <?php
                                            if ($c->subtitle): ?>
                                                <p class="main-category__card-features-description">
                                                    <?= $c->subtitle ?>
                                                </p>
                                            <?php
                                            endif; ?>
                                        </a>
                                    </li>
                                <?php
                                endforeach; ?>
                            </ul>
                        <?php
                        endif; ?>
                    </div>
                    <div class="main-category__card-bottom">
                        <?php
                        \App\Layout\Components\Common\Button\Layout::draw([
                            'text' => 'Открыть',
                            'style' => 'secondary',
                            'class_name' => 'main-category__card-button',
                            'link' => '/' . $cat->path . '/',
                            'icon' => true,
                        ]); ?>
                    </div>
                </li>
            <?php
            endforeach; ?>
        </ul>

    </div>
</section>