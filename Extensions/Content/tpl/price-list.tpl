<?php
/** @var array $content */

?>

<div class="price-list__content">
    <div class="price-list__card">
        <h1 class="price-list__card--title">Прайс-лист</h1>
        <p class="price-list__card--text">Актуальные цены и товары в наличии</p>

        <div class="price-list__buttons">
            <a class="price-list__button price-list__download" href="/price-list/price.xlsx" download="Прайс rh store.xlsx">
                Скачать прайс
            </a>

            <a class="price-list__button price-list__secondary" href="/price-list/in-transit.xlsx" download="Товары в дороге rh store.xlsx">
                Товары в дороге
            </a>
        </div>
    </div>
</div>


<style>
    .price-list__content {
        min-height: 100vh;
        background: linear-gradient(135deg, #0f172a, #020617);
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
    }

    .price-list__card {
        background: rgba(255, 255, 255, 0.06);
        backdrop-filter: blur(12px);
        border-radius: 20px;
        padding: 48px 40px;
        max-width: 420px;
        width: 100%;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
        text-align: center;
    }

    .price-list__card--title {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 12px;
    }

    .price-list__card--text {
        color: #cbd5f5;
        font-size: 15px;
        margin-bottom: 36px;
    }

    .price-list__buttons {
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .price-list__button {
        text-decoration: none;
        padding: 16px;
        border-radius: 14px;
        font-size: 16px;
        font-weight: 600;
        transition: all 0.25s ease;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .price-list__download {
        background: linear-gradient(135deg, #38bdf8, #2563eb);
        color: #fff;
    }

    .price-list__download:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(56, 189, 248, 0.45);
    }

    .price-list__secondary {
        background: linear-gradient(135deg, #fb923c, #f97316);
        color: #fff;
    }

    .price-list__secondary:hover {
        transform: translateY(-2px);
        transform: translateY(-2px);
    }

    @media (max-width: 480px) {
        .price-list__card {
            padding: 36px 24px;
        }
    }
</style>