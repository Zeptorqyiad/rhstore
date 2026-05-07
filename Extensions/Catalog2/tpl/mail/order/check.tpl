<table cellpadding="0"
       cellspacing="0"
       border="0"
       style="width: 339px; vertical-align: middle; margin: 0 auto; padding: 40px 40px; background: #f2f2f2; border-radius: 8px;">
    <tr>
        <td>
            <table cellpadding="0" cellspacing="0" border="0" style="width: 100%;">
                <tr>
                    <td>
                                            <span style="font-family: 'Raleway', Arial, sans-serif;
                                            display: inline-block;
                                            margin-bottom: 12px;
                                                        font-size: 20px;
                                                        font-style: normal;
                                                        font-weight: 600;
                                                        line-height: 150%;
                                                        color: #404040;">Итого:
                                                        </span>
                    <td align="right">
                                        <span style="font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 20px;
                                                        font-style: normal;
                                                        font-weight: 700;
                                                        line-height: 150%;
                                                        color: #0D0D0D;"><?= $order->getTotal() ?> ₽
                                                        </span>
                    </td>

                </tr>

                <tr>
                    <td>
                                            <span style="font-family: 'Raleway', Arial, sans-serif;
                                            display: inline-block;
                                            margin-bottom: 8px;
                                                        font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 400;
                                                        line-height: 150%;
                                                        color: #666;">Товары, <?= $order->getTotalProductCount() ?> шт.:
                                                        </span>
                    <td align="right">
                                        <span style="font-family: 'Raleway', Arial, sans-serif;
                                                         font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 700;
                                                        line-height: 150%;
                                                        text-align: right;
                                                        color: #404040;"><?= $order->getTotal3() ?> ₽
                                                        </span>
                    </td>

                </tr>

                <?php
                if ($order->getDiscountNum() > 0): ?>
                    <tr>
                        <td>
                                            <span style="font-family: 'Raleway', Arial, sans-serif;
                                            display: inline-block;
                                            margin-bottom: 8px;
                                                        font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 400;
                                                        line-height: 150%;
                                                        color: #666;">Скидка:
                                                        </span>
                        <td align="right">
                                            <span style="font-family: 'Raleway', Arial, sans-serif;
                                                         font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 700;
                                                        line-height: 150%;
                                                        text-align: right;
                                                        color: #404040;"><?= $order->getDiscount() ?> ₽
                                                        </span>
                        </td>

                    </tr>
                <?php
                endif; ?>

                <tr>
                    <td>
                                            <span style="font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 400;
                                                        line-height: 150%;
                                                        color: #666;">Способ оплаты:
                                                        </span>
                    </td>
                    <td align="right">
                                                        <span style="font-family: 'Raleway', Arial, sans-serif;
                                                         font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 700;
                                                        line-height: 150%;
                                                        text-align: right;
                                                        color: #404040;">По счёту
                                                        </span>
                    </td>

                </tr>

            </table>
        </td>
    </tr>

    <tr>
        <td style="padding-top: 20px">
            <hr style="border: none; border-top: 2px solid #ccc; margin-bottom: 20px;">
            <a style="
                                                        padding: 8px 16px;
                                                        justify-content: center;
                                                        align-items: center;
                                                        border-radius: 8px;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 16px;
                                                        background: #FF3838;
                                                        font-style: normal;
                                                        font-weight: 600;
                                                        line-height: 150%;
                                                        text-decoration: none;
                                                        color: #ffffff;
                                                        width: 227px;
                                                        text-align: center;
                                                        display: inline-block;" href="<?= url(
                '/user/orders/' . $order->order_id . '/',
            ) ?>">Подробнее о заказе</a>
        </td>
    </tr>

</table>