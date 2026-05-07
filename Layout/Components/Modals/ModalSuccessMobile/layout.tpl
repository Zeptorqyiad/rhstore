<?php
/** @var array $data */

?>

<div class="<?= $data["class_name"] ?> modal-response-success-mobile modal-response-mobile" data-modal="success">
    <div class="modal-response-mobile__content" data-modal-content="success">

            <button class="modal-response-mobile__close" type="button" data-close="success">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                    <path fill-rule="evenodd"
                          clip-rule="evenodd"
                          d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z"
                          fill="#404040" />
                </svg>
            </button>
            <span class="modal-response-mobile__title"><?= $data["success_title_mobile"] ?></span>
        <span class="modal-response-mobile__info"><?= $data["success_text_mobile"] ?></span>

    </div>
</div>