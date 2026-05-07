<?php
/** @var array $top */
/** @var array $statNow */
/** @var array $statCompare */
?>
<div class="layout__content">
    <div class="content">
        <div class="analytics__wrapper" data-simplebar>
            <!-- Для сравнения ставить класс analytics_comparison-->
            <div class="analytics ">
                <div class="analytics__head">
                    <h2 class="analytics__title">Аналитика продаж</h2>
                </div>
                <form class="analytics__content">
                    <input type="hidden" name="comparison" value="<?= ($_REQUEST['comparison'] ?? '') ? '1' : '' ?>">
                    <div class="analytic-chart">
                        <div class="analytic-chart__head">
                            <span class="analytic-chart__title">Продажи за <?= $curPeriod ?></span>
                            <div class="analytic-chart__dropdown form-control form-control--sm">
                                <div class="form-control__dropdown">
                                    <input class="form-control__dropdown-input" type="hidden" name="period"
                                           value="<?= $_REQUEST['period'] ?? 'today' ?>">
                                    <div class="form-control__dropdown-top">
                                        <div class="form-control__dropdown-current"></div>
                                        <button class="form-control__dropdown-toggle" type="button">
                                            <svg viewBox="0 0 24 24">
                                                <use xlink:href="/vendor/glushkovds/simflex/src/Admin/theme/new/img/icons/svg-defs.svg#chevron-mini"></use>
                                            </svg>
                                        </button>
                                    </div>
                                    <div class="form-control__dropdown-list">
                                        <div data-value="today" class="form-control__dropdown-item">Сегодня</div>
                                        <div data-value="month" class="form-control__dropdown-item">Этот месяц</div>
                                        <div data-value="year" class="form-control__dropdown-item">Этот год</div>
                                        <div data-value="decade" class="form-control__dropdown-item">Это десятилетие
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <?php if (!($_REQUEST['comparison'] ?? 0)): ?>
                                <button type="button"
                                        class="analytic-chart__btn-compare BtnOutlineMonoSm js--analytic-compare">
                                    Сравнить
                                    с прошлым
                                </button>
                            <?php else: ?>
                                <button type="button"
                                        class="analytic-chart__btn-compare BtnSecondaryMonoSm js--analytic-remove-compare">
                                    Убрать
                                    сравнение
                                </button>
                            <?php endif; ?>

                        </div>
                        <div class="analytic-chart__canvas-wrapper">
                            <div class="analytic-chart__canvas" data-chart="<?= $chart ?>">
                                <canvas></canvas>
                            </div>
                        </div>
                        <div class="analytic-chart-legends" id="analytic-chart-legend">
                            <div class="analytic-chart-legends__filter">
                                <span class="analytic-chart-legends__filter-text">Статус заказа: </span>
                                <div class="analytic-chart-legends__dropdown form-control form-control--sm">
                                    <div class="form-control__dropdown">
                                        <input class="form-control__dropdown-input" type="hidden" name="status_compare"
                                               value="<?= $_REQUEST['status_compare'] ?? 'pay' ?>">
                                        <div class="form-control__dropdown-top">
                                            <div class="form-control__dropdown-current"><?= $curStatusCompare ?></div>
                                            <button class="form-control__dropdown-toggle" type="button">
                                                <svg viewBox="0 0 24 24">
                                                    <use xlink:href="/vendor/glushkovds/simflex/src/Admin/theme/new/img/icons/svg-defs.svg#chevron-mini"></use>
                                                </svg>
                                            </button>
                                        </div>
                                        <div class="form-control__dropdown-list">
                                            <div data-value="pay" class="form-control__dropdown-item">Ожидает оплаты
                                            </div>
                                            <div data-value="new" class="form-control__dropdown-item">Новый</div>
                                            <div data-value="accepted" class="form-control__dropdown-item">Принят</div>
                                            <!--                                            <div data-value="ready" class="form-control__dropdown-item">Собран</div>-->
                                            <div data-value="sent" class="form-control__dropdown-item">Доставляется
                                            </div>
                                            <div data-value="delivered" class="form-control__dropdown-item">Готов к
                                                выдаче
                                            </div>
                                            <div data-value="finished" class="form-control__dropdown-item">Завершен
                                            </div>
                                            <div data-value="canceled" class="form-control__dropdown-item">Отменен</div>
                                            <!--                                            <div data-value="validating" class="form-control__dropdown-item">На-->
                                            <!--                                                уточнении-->
                                            <!--                                            </div>-->
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="analytic-info">
                        <div class="analytic-info__head">
                            <span class="analytic-info__title"><?= $curAggr ?> заказов в статусе</span>

                            <div class="analytic-info__dropdown form-control form-control--sm">
                                <div class="form-control__dropdown">
                                    <input class="form-control__dropdown-input" type="hidden" name="status"
                                           value="<?= $_REQUEST['status'] ?? 'pay' ?>">
                                    <div class="form-control__dropdown-top">
                                        <div class="form-control__dropdown-current"><?= $curStatus ?></div>
                                        <button class="form-control__dropdown-toggle" type="button">
                                            <svg viewBox="0 0 24 24">
                                                <use xlink:href="/vendor/glushkovds/simflex/src/Admin/theme/new/img/icons/svg-defs.svg#chevron-mini"></use>
                                            </svg>
                                        </button>
                                    </div>
                                    <div class="form-control__dropdown-list">
                                        <div data-value="pay" class="form-control__dropdown-item">Ожидает оплаты</div>
                                        <div data-value="new" class="form-control__dropdown-item">Новый</div>
                                        <div data-value="accepted" class="form-control__dropdown-item">Принят</div>
                                        <!--                                        <div data-value="ready" class="form-control__dropdown-item">Собран</div>-->
                                        <div data-value="sent" class="form-control__dropdown-item">Доставляется</div>
                                        <div data-value="delivered" class="form-control__dropdown-item">Готов к выдаче
                                        </div>
                                        <div data-value="finished" class="form-control__dropdown-item">Завершен</div>
                                        <div data-value="canceled" class="form-control__dropdown-item">Отменен</div>
                                        <!--                                        <div data-value="validating" class="form-control__dropdown-item">На уточнении-->
                                        <!--                                        </div>-->
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="analytic-info__datasets">
                            <div class="analytic-info__data analytic-info__data_<?= $this->formatDir($statCompare['total']) ?>">
                                            <span
                                                    class="analytic-info__data-text analytic-info__data-text_label">Количество</span>
                                <span class="analytic-info__data-text analytic-info__data-text_percent"><?= $this->formatPercent($statCompare['total']) ?></span>
                                <span
                                        class="analytic-info__data-text analytic-info__data-text_value"><?= $statNow['total'] ?></span>
                            </div>
                            <div class="analytic-info__data analytic-info__data_<?= $this->formatDir($statCompare['prods']) ?>">
                                            <span
                                                    class="analytic-info__data-text analytic-info__data-text_label">Товаров</span>
                                <span
                                        class="analytic-info__data-text analytic-info__data-text_percent"><?= $this->formatPercent($statCompare['prods']) ?></span>
                                <span
                                        class="analytic-info__data-text analytic-info__data-text_value"><?= $statNow['prods'] ?? 0 ?></span>
                            </div>
                            <div class="analytic-info__data analytic-info__data_<?= $this->formatDir($statCompare['tot']) ?>">
                                            <span
                                                    class="analytic-info__data-text analytic-info__data-text_label">Себес-ть</span>
                                <span
                                        class="analytic-info__data-text analytic-info__data-text_percent"><?= $this->formatPercent($statCompare['tot']) ?></span>
                                <span class="analytic-info__data-text analytic-info__data-text_value"><?= number_format($statNow['tot'], 0, '.', ' ') ?> ₽</span>
                            </div>
                            <div class="analytic-info__data analytic-info__data_<?= $this->formatDir($statCompare['act']) ?>">
                                            <span
                                                    class="analytic-info__data-text analytic-info__data-text_label">Сумма</span>
                                <span
                                        class="analytic-info__data-text analytic-info__data-text_percent"><?= $this->formatPercent($statCompare['act']) ?></span>
                                <span class="analytic-info__data-text analytic-info__data-text_value"><?= number_format($statNow['act'], 0, '.', ' ') ?> ₽</span>
                            </div>
                            <div class="analytic-info__data analytic-info__data_<?= $this->formatDir($statCompare['marg']) ?>">
                                            <span
                                                    class="analytic-info__data-text analytic-info__data-text_label">Выручка</span>
                                <span
                                        class="analytic-info__data-text analytic-info__data-text_percent"><?= $this->formatPercent($statCompare['marg']) ?></span>
                                <span class="analytic-info__data-text analytic-info__data-text_value"><?= number_format($statNow['marg'], 0, '.', ' ') ?> ₽</span>
                            </div>
                        </div>

                        <a href="/admin/shop/order/" class="analytic-info__btn-to BtnSecondaryMonoSm">Перейти к заказам</a>
                    </div>
                </form>

                <div class="analytics__table">
                    <h4 class="analytics__table-title">Популярные товары</h4>
                    <div class="table__wrap">
                        <table class="table">
                            <thead class="table__head">
                            <tr class="table__head-row">
                                <th id="table-head-order" class="table__head-item">Порядок</th>
                                <th id="table-head-shop" class="table__head-item">Покупок</th>
                                <th id="table-head-summa" class="table__head-item">Сумма покупок</th>
                                <th id="table-head-product" class="table__head-item">Товар</th>
                                <th id="table-head-category" class="table__head-item">Категория</th>
                                <th id="table-head-photo" class="table__head-item">Фото</th>
                            </tr>
                            </thead>
                            <tbody>
                            <?php
                            $i = 1;
                            foreach ($top as $c):
                                if (!$c['product_id']) {
                                    continue;
                                }

                                $p = new \App\Extensions\Catalog\Model\Product($c['product_id']); ?>
                                <tr class="table__body-row">
                                    <td class="table-data-id table__body-item">
                                        <span class="table__body-item-id"><?= $i++ ?></span>
                                    </td>
                                    <td class="table-data-id table__body-item">
                                        <span class="table__body-item-id"><?= $c['total'] ?></span>
                                    </td>
                                    <td class="table-data-id table__body-item">
                                        <span class="table__body-item-id"><?= number_format($c['price'], 0, '', ' ') ?></span>
                                    </td>
                                    <td class="table-data-name table__body-item">
                                        <a style="text-decoration: none" target="_blank"
                                           href="/admin/shop/product/product/?action=form&product_id=<?= $c['product_id'] ?>"
                                           class="table__body-item-name"><?= $c['name'] ?></a>
                                    </td>
                                    <td class="table-data-id table__body-item">
                                        <span class="table__body-item-id"><?= ($cat = $p->getFirstCategory()) ? $cat->name : '' ?></span>
                                    </td>
                                    <td class="table-data-img table__body-item">
                                        <div class="table__body-item-img">
                                            <img src="<?= $p->getPrimaryImage() ?>" alt="<?= $c['name'] ?>">
                                        </div>
                                    </td>
                                </tr>
                            <?php
                            endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>