<?php
/** @var array $data */

/** @var \App\Extensions\Catalog2\Model\Product $p */
$p = $data['prod'];
?>

<div class="<?= $data["class_name"] ?> modal-property-info modal-property" data-modal="modal-property-info">
    <div class="modal-property__wrap">
        <div class="modal-property__top">
            <button class="modal-property__btn-back modal-property__btn mobile-modal__close" data-close="modal-property-info">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <path d="M15 6L9 12L15 18" stroke="#404040" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
            <button class="modal-property__btn-close modal-property__btn mobile-modal__close"  data-close="modal-property-info">
                <i class="btn__icon btn__icon_center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z" fill="#404040"/>
                    </svg>
                </i>
            </button>
        </div>

        <div class="modal-property__body">
            <h4 class="modal-property__title">Характеристики</h4>
            <div class="about-product__item-bottom">
                <?php \App\Layout\Components\Blocks\Product\Specifications\Layout::draw(['prod' => $p, 'vis_only' => false]); ?>
            </div>
        </div>
    </div>
</div>