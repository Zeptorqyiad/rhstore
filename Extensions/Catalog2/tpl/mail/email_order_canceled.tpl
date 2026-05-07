<?php

include 'header.tpl'; ?>
    <tr>
    <td style="padding: 40px; background: #FFFFFF; border-radius: 8px">
    <table cellpadding="0"
           cellspacing="0"
           border="0"
           style=" border-radius: 8px; background-color: #ffffff; width: 100%;">
        <tr>
            <td>
                                        <span style="font-variant-numeric: lining-nums proportional-nums;
                                        font-family: 'Raleway', Arial, sans-serif;
                                        font-size: 20px;
                                        font-style: normal;
                                        font-weight: 700;
                                        line-height: 150%;
                                        color: #0D0D0D;">Заказ №<?= $order->order_id ?> отменён</span>
            </td>
        </tr>
        <tr style="height: 16px;"></tr>
        <tr>
            <td>
                                            <span style="font-family: 'Raleway', Arial, sans-serif;
                                            display: ;
                                            font-size: 14px;
                                            font-style: normal;
                                            font-weight: 600;
                                            line-height: 150%;
                                            color: #404040;
                                            width: 198px;
                                            margin: 0;
                                            margin-right: 8px;">
                                                Статус заказа:</span>
                <span style="font-family: 'Raleway', Arial, sans-serif;
                                            padding: 5px 12px;
                                            background: #D93030;
                                            border-radius: 8px;
                                            font-size: 14px;
                                            font-style: normal;
                                            font-weight: 600;
                                            line-height: 150%;
                                            color: #fff;
                                            width: 140px;
                                            text-align: center;
                                            margin: 0;">
                                             Отменен</span>
            </td>

        </tr>
        <tr style="height: 20px;"></tr>
        <tr>
            <td>
                <p style="font-family: 'Raleway', Arial, sans-serif;
                                            font-size: 14px;
                                            font-style: normal;
                                            font-weight: 600;
                                            line-height: 150%;
                                            color: #404040;
                                            margin: 0;">
                    Здравствуйте, <?= $user->name ?></p>
            </td>
        </tr>
        <tr>
            <td>
                <p style="font-family: 'Raleway', Arial, sans-serif;
                                            font-size: 14px;
                                            font-style: normal;
                                            font-weight: 600;
                                            line-height: 150%;
                                            color: #404040;
                                            width: 400px;
                                            margin: 0;
                                            margin-bottom: 24px;">
                    Сожалеем, что вам пришлось отменить заказ. Надеемся, что мы с вами ещё
                    поработаем.
            </td>

        </tr>
        <tr>
            <td>
                <a style="
                    padding: 8px 16px;
                    justify-content: center;
                    align-items: center;
                    gap: 8px;
                    border-radius: 8px;
                    font-family: 'Raleway', Arial, sans-serif;
                    font-size: 16px;
                    background: #FF3838;
                    font-style: normal;
                    font-weight: 600;
                    line-height: 150%;
                    text-decoration: none;
                    color: #ffffff;
                    margin-bottom: 24px;
                    display: inline-block;
                    " href="<?= url(
                    '/catalog/',
                ) ?>">В каталог</a>
            </td>
        </tr>

    </table>
    <hr style="border: none; border-top: 2px solid #F2F2F2; margin-bottom: 16px;">
<?php
include 'order/user.tpl'; ?>
    <hr style="border: none; border-top: 2px solid #F2F2F2; margin-bottom: 12px;">
<?php
include 'order/delivery.tpl'; ?>
<?php
include 'order/check.tpl'; ?>
<?php
include 'footer.tpl'; ?>