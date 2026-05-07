<?php
/** @var array $data */

?>

<div class="<?= $data["class_name"] ?> bread-crumbs">
    <div class="bread-crumbs__container">
        <button class="bread-crumbs__back-button" onclick="history.back()" draggable="false">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m5.5 9.5-3 3 3 3"/>
            </svg>
            <span>Назад</span>
        </button>

        <ul class="bread-crumbs__list">
            <li class="bread-crumbs__item">
                <a href="/">Главная</a>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                    <path fill-rule="evenodd" clip-rule="evenodd"
                          d="M9.79289 16.2071C9.40237 15.8166 9.40237 15.1834 9.79289 14.7929L12.0858 12.5L9.79289 10.2071C9.40237 9.81658 9.40237 9.18342 9.79289 8.79289C10.1834 8.40237 10.8166 8.40237 11.2071 8.79289L14.2071 11.7929C14.5976 12.1834 14.5976 12.8166 14.2071 13.2071L11.2071 16.2071C10.8166 16.5976 10.1834 16.5976 9.79289 16.2071Z"
                          fill="#999999"/>
                </svg>
            </li>
            <?php
            $last = \Simflex\Extensions\Breadcrumbs\Breadcrumbs::getLast();
            foreach (\Simflex\Extensions\Breadcrumbs\Breadcrumbs::get() as $bc): ?>
                <li class="bread-crumbs__item">
                    <?php
                    if ($last['link'] == $bc['link']): ?>
                        <p>
                            <?= $bc['name'] ?>
                        </p>
                    <?php
                    else: ?>
                        <a href="<?= $bc['link'] ?>"><?= $bc['name'] ?></a>
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                  d="M9.79289 16.2071C9.40237 15.8166 9.40237 15.1834 9.79289 14.7929L12.0858 12.5L9.79289 10.2071C9.40237 9.81658 9.40237 9.18342 9.79289 8.79289C10.1834 8.40237 10.8166 8.40237 11.2071 8.79289L14.2071 11.7929C14.5976 12.1834 14.5976 12.8166 14.2071 13.2071L11.2071 16.2071C10.8166 16.5976 10.1834 16.5976 9.79289 16.2071Z"
                                  fill="#999999"/>
                        </svg>
                    <?php
                    endif; ?>
                </li>
            <?php
            endforeach; ?>
        </ul>
    </div>
</div>