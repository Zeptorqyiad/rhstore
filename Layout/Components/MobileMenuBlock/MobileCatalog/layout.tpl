<?php
/** @var array $data */

?>

<div class="<?= $data["class_name"] ?> mobile-catalog mobile-modal">
    <div>
        <div class="mobile-catalog__wrap">
            <div class="mobile-catalog__top wrapper">
                <p class="mobile-catalog__title">
                    Категории </p>
                <div class="mobile-catalog__close mobile-modal__close">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                        <path fill-rule="evenodd"
                              clip-rule="evenodd"
                              d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z"
                              fill="#404040"/>
                    </svg>
                </div>
            </div>

            <ul class="mobile-catalog__items">
                <li class="mobile-catalog__radio-wrapper">
                    <label class="mobile-catalog__radio-button">
                <span class="mobile-catalog__radio-label">
                    Каталог
                </span>
                        <input id="option1"
                               name="radio-group"
                               type="radio"
                               value="/catalog/"
                               class="mobile-catalog__radio-input">
                        <span class="mobile-catalog__radio-checkmark"></span>
                    </label>
                </li>

                <?php foreach (\App\Extensions\Catalog\Model\Category::find('coalesce(pid, 0) = 0') as $cat):
                    $children = $cat->getChildren(); ?>
                    <li class="mobile-catalog__radio-wrapper">
                        <label class="mobile-catalog__radio-button">
                        <span class="mobile-catalog__radio-label">
                            <?= $cat->name ?> <?= $cat->subtitle ?>
                        </span>
                            <input id="option2"
                                   name="radio-group"
                                   type="radio"
                                   value="/<?= $cat->path ?>/"
                                   class="mobile-catalog__radio-input">
                            <span class="mobile-catalog__radio-checkmark"></span>
                        </label>
                        <?php if ($children): ?>
                            <ul class="mobile-catalog__items-children">
                                <?php foreach ($children as $cc1):
                                    $children2 = $cc1->getChildren(); ?>
                                    <li class="mobile-catalog__radio-wrapper-child">
                                        <label class="mobile-catalog__radio-button">
                                        <span class="mobile-catalog__radio-label">
                                            <?= $cc1->name ?> <?= $cc1->subtitle ?>
                                        </span>
                                            <input id="option2"
                                                   name="radio-group"
                                                   type="radio"
                                                   value="/<?= $cc1->path ?>/"
                                                   class="mobile-catalog__radio-input">
                                            <span class="mobile-catalog__radio-checkmark"></span>
                                        </label>
                                        <?php if ($children2): ?>
                                            <ul class="mobile-catalog__items-children">
                                                <?php foreach ($children2 as $cc2):
                                                    $children3 = $cc2->getChildren(); ?>
                                                    <li class="mobile-catalog__radio-wrapper-child">
                                                        <label class="mobile-catalog__radio-button">
                                                        <span class="mobile-catalog__radio-label">
                                                            <?= $cc2->name ?> <?= $cc2->subtitle ?>
                                                        </span>
                                                            <input id="option2"
                                                                   name="radio-group"
                                                                   type="radio"
                                                                   value="/<?= $cc2->path ?>/"
                                                                   class="mobile-catalog__radio-input">
                                                            <span class="mobile-catalog__radio-checkmark"></span>
                                                        </label>
                                                        <?php if ($children3): ?>
                                                            <ul class="mobile-catalog__items-children">
                                                                <?php foreach ($children3 as $cc3): ?>
                                                                    <li class="mobile-catalog__radio-wrapper-child">
                                                                        <label class="mobile-catalog__radio-button">
                                                                        <span class="mobile-catalog__radio-label">
                                                                            <?= $cc3->name ?> <?= $cc3->subtitle ?>
                                                                        </span>
                                                                            <input id="option2"
                                                                                   name="radio-group"
                                                                                   type="radio"
                                                                                   value="/<?= $cc3->path ?>/"
                                                                                   class="mobile-catalog__radio-input">
                                                                            <span class="mobile-catalog__radio-checkmark"></span>
                                                                        </label>
                                                                    </li>
                                                                <?php endforeach; ?>
                                                            </ul>
                                                        <?php endif; ?>
                                                    </li>
                                                <?php endforeach; ?>
                                            </ul>
                                        <?php endif; ?>
                                    </li>
                                <?php endforeach; ?>
                            </ul>
                        <?php endif; ?>
                    </li>
                <?php endforeach; ?>
            </ul>

            <?php App\Layout\UIKit\ButtonOrdered\Layout::draw([
                'href' => '/past/',
                'text' => 'Заказывали ранее',
                'class_name' => \Simflex\Core\Container::getUser()?->hasOldProducts() ? 'button-ordered_menu' : 'button-ordered_disabled button-ordered_menu'
            ]); ?>
        </div>
    </div>
    <div class="mobile-catalog__bottom">
        <?php
        App\Layout\Components\Common\Button\Layout::draw([
            'text' => 'Выбрать',
            'style' => 'primary',
            'class_name' => 'mobile-catalog__button'
        ]); ?>
    </div>
</div>