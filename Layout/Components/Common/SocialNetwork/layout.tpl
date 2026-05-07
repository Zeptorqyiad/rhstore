<?php
/** @var array $data */

$tg = Simflex\Core\Core::siteParam('tg');
$inst = Simflex\Core\Core::siteParam('inst');
$viber = Simflex\Core\Core::siteParam('viber');
$vk = Simflex\Core\Core::siteParam('vk');
$wt = Simflex\Core\Core::siteParam('wt');
$yt = Simflex\Core\Core::siteParam('yt');
$whats_app = Simflex\Core\Core::siteParam('whats_app');
$max_social = Simflex\Core\Core::siteParam('max_social');
?>

<div class="social-network <?= $data["class_name"] ?>">
    <?php if ($tg): ?>
<!--        <a onclick="window.open(this.dataset.href, '_blank'); return false;"-->
<!--           data-href="{tg}"-->
        <a
           href="{tg}"
           target="_blank"
           class="social-network__item social-network__telegram"
           draggable="false">
            <svg viewBox="0 0 32 32" fill="none"
                 xmlns="http://www.w3.org/2000/svg">
                <rect width="32" height="32"/>
                <path d="M22.4031 10.0818L19.9988 22.6338C19.9988 22.6338 19.6624 23.5041 18.7382 23.0867L13.1908 18.682L13.1651 18.6691C13.9144 17.9723 19.725 12.5621 19.979 12.3169C20.3721 11.9371 20.1281 11.711 19.6716 11.9979L11.0886 17.6424L7.77724 16.4886C7.77724 16.4886 7.25613 16.2966 7.206 15.8793C7.15521 15.4612 7.79439 15.2351 7.79439 15.2351L21.2936 9.75113C21.2936 9.75113 22.4031 9.24632 22.4031 10.0818Z"
                      fill="white"/>
            </svg>
        </a>
    <?php endif; ?>

    <?php if ($whats_app): ?>
        <a href="{whats_app}" target="_blank" class="social-network__item social-network__whatsapp" draggable="false">
            <svg viewBox="0 0 32 32" fill="none"
                 xmlns="http://www.w3.org/2000/svg">
                <rect width="32" height="32"/>
                <path d="M22.3415 9.64995C20.761 8.07495 18.6537 7.19995 16.4293 7.19995C11.8049 7.19995 8.05854 10.9333 8.05854 15.5416C8.05854 17 8.46829 18.4583 9.17073 19.6833L8 24L12.4488 22.8333C13.6781 23.475 15.0244 23.825 16.4293 23.825C21.0537 23.825 24.8 20.0916 24.8 15.4833C24.7415 13.325 23.922 11.225 22.3415 9.64995ZM20.4683 18.5166C20.2927 18.9833 19.4732 19.45 19.0634 19.5083C18.7122 19.5666 18.2439 19.5666 17.7756 19.45C17.4829 19.3333 17.0732 19.2166 16.6049 18.9833C14.4976 18.1083 13.1512 16.0083 13.0341 15.8333C12.9171 15.7166 12.1561 14.725 12.1561 13.675C12.1561 12.625 12.6829 12.1583 12.8585 11.925C13.0341 11.6916 13.2683 11.6916 13.4439 11.6916C13.561 11.6916 13.7366 11.6916 13.8537 11.6916C13.9707 11.6916 14.1463 11.6333 14.322 12.0416C14.4976 12.45 14.9073 13.5 14.9659 13.5583C15.0244 13.675 15.0244 13.7916 14.9659 13.9083C14.9073 14.025 14.8488 14.1416 14.7317 14.2583C14.6146 14.375 14.4976 14.55 14.439 14.6083C14.3219 14.725 14.2049 14.8416 14.322 15.0166C14.439 15.25 14.8488 15.8916 15.4927 16.475C16.3122 17.175 16.9561 17.4083 17.1902 17.525C17.4244 17.6416 17.5415 17.5833 17.6585 17.4666C17.7756 17.35 18.1854 16.8833 18.3024 16.65C18.4195 16.4166 18.5951 16.475 18.7707 16.5333C18.9463 16.5916 20 17.1166 20.1756 17.2333C20.4098 17.35 20.5268 17.4083 20.5854 17.4666C20.6439 17.6416 20.6439 18.05 20.4683 18.5166Z"
                      fill="white"/>
            </svg>
        </a>
    <?php endif; ?>

    <?php if ($max_social): ?>
        <a href="{max_social}" target="_blank" class="social-network__item social-network__max" draggable="false">
            <?= renderIcon('social-max') ?>
        </a>
    <?php endif; ?>
</div>