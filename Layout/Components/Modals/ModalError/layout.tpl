<?php
/** @var array $data */

?>

<div class="<?= $data["class_name"] ?> modal-response-error modal-response" data-modal="error">
    <div class="modal-response__content" data-modal-content="error">
        <div class="modal-response__top">
            <span class="modal-response__title"><?= $data["error_title"] ?></span>
            <button class="modal-response__close" type="button" data-close="error">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                    <path fill-rule="evenodd"
                          clip-rule="evenodd"
                          d="M3.29289 3.29289C3.68342 2.90237 4.31658 2.90237 4.70711 3.29289L12 10.5858L19.2929 3.29289C19.6834 2.90237 20.3166 2.90237 20.7071 3.29289C21.0976 3.68342 21.0976 4.31658 20.7071 4.70711L13.4142 12L20.7071 19.2929C21.0976 19.6834 21.0976 20.3166 20.7071 20.7071C20.3166 21.0976 19.6834 21.0976 19.2929 20.7071L12 13.4142L4.70711 20.7071C4.31658 21.0976 3.68342 21.0976 3.29289 20.7071C2.90237 20.3166 2.90237 19.6834 3.29289 19.2929L10.5858 12L3.29289 4.70711C2.90237 4.31658 2.90237 3.68342 3.29289 3.29289Z"
                          fill="#404040" />
                </svg>
            </button>
        </div>
        <span class="modal-response__info"><?= $data["error_text"] ?></span>

    </div>
</div>