<?php
/** @var array $data */

use App\Extensions\FAQ\Model\FaqCategory;

$cats = FaqCategory::findAdv()->orderBy('npp')->all();
?>

<div class="<?= $data["class_name"] ?> questions-content">
    <div class="wrapper">
        <?php if ($data['title']): ?>
            <h1 class="questions-content__title">
                <?= $data["title"] ?>
            </h1>
        <?php endif; ?>

        <ul class="questions-content__list">
            <?php foreach ($cats as $c):
                $children = $c->getChildren();
                ?>
                <li>
                    <h3 class="questions-content__sub-title">
                        <?= htmlspecialchars($c->name) ?>
                    </h3>

                    <div class="questions-content__accordions">
                        <?php foreach ($children as $item): ?>
                            <?php App\Layout\Components\Common\Accordion\Layout::draw([
                                'title' => $item->question,
                                'text'  => $item->answer,
                            ]); ?>
                        <?php endforeach; ?>
                    </div>
                </li>
            <?php endforeach; ?>
        </ul>
    </div>
</div>