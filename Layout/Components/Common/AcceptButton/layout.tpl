<?php
/** @var array $data */
?>

<button class="<?= $data['class_name'] ?> accept-button"  data-cart="<?=$data['add']?>">
    <span><?= $data["text"] ?></span>


    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
        <path fill-rule="evenodd" clip-rule="evenodd" d="M19.7071 7.29289C20.0976 7.68342 20.0976 8.31658 19.7071 8.70711L10.7071 17.7071C10.3166 18.0976 9.68342 18.0976 9.29289 17.7071L5.29289 13.7071C4.90237 13.3166 4.90237 12.6834 5.29289 12.2929C5.68342 11.9024 6.31658 11.9024 6.70711 12.2929L10 15.5858L18.2929 7.29289C18.6834 6.90237 19.3166 6.90237 19.7071 7.29289Z" fill="white"/>
    </svg>

</button>