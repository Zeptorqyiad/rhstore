<?php
/** @var array $data */

?>

<div class="<?= $data["class_name"] ?> modal-price-info" data-modal="price-info">
    <div class="modal-price-info__content" data-modal-content="price-info">
        <button class="modal-price-info__close" type="button" data-close="price-info" data-close="price-info">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                <path fill-rule="evenodd" clip-rule="evenodd"
                      d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z"
                      fill="#404040"/>
            </svg>
        </button>
        <div class="modal-price-info__top">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="white" viewBox="0 0 32 32">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M10.668 18.666s2 2.667 5.333 2.667c3.334 0 5.334-2.666 5.334-2.666M20 12h.014M12 12h.014m17.32 4c0 7.364-5.97 13.333-13.334 13.333-7.363 0-13.333-5.97-13.333-13.333C2.667 8.636 8.637 2.666 16 2.666c7.364 0 13.334 5.97 13.334 13.334Zm-8.667-4a.667.667 0 1 1-1.333 0 .667.667 0 0 1 1.333 0Zm-8 0a.667.667 0 1 1-1.333 0 .667.667 0 0 1 1.333 0Z"/>
            </svg>
            <h3 class="modal-price-info__title">
                Откройте персональные цены
            </h3>
        </div>

        <p class="modal-price-info__text">
<!--            --><?php
//            $user = \Simflex\Core\Container::getUser();
//            if ($user):
//                $level = $user->getLevel()->getNextLevel();
//                if ($level): ?>
                    Совершите заказ на сумму более
                        <span class="modal-price-info__accent" data-price="0">
                            100 000 ₽
<!--                            --><?php //= \Simflex\Core\Helpers\Str::price($level->min) ?>
                        </span>, и у вас появится возможность покупать товары
                    <span class="modal-price-info__accent">по персональным ценам!</span>
<!--                --><?php
//                endif;
//            endif; ?>
        </p>
    </div>
</div>