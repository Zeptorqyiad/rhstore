<tr style="height: 20px;">

</tr>

<!-- Layout Cards -->

<tr style="margin-top: 40px">
    <td>
        <table cellpadding="0"
               cellspacing="0"
               border="0"
               width="100%"
               style="margin-bottom: 20px">
            <!--                                    <tr>-->
            <!--                                        <th style="width: 184px"></th>-->
            <!--                                        <th style="width: 184px"></th>-->
            <!--                                        <th style="width: 184px"></th>-->
            <!--                                    </tr>-->
            <tr>
                <td>
                    <table cellpadding="0" cellspacing="0" border="0" style="
                                            background-color: #ffffff;
                                            width: 184px;
                                            border-radius: 8px;
                                            margin-right: 24px;">
                        <tr style="display: table-cell" align="center">
                            <td style="padding: 16px 8px;">
                                <a href="<?= url('/user/') ?>" style="
                                                        font-size: 15px;
                                                        text-decoration: none;
                                                        font-weight: 600;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        color: #666;
                                                        display: table-cell;">
                                    <img width="24"
                                         src="<?= url('/assets/images/mail/user.png') ?>"
                                         alt="Личный кабинет"
                                         style="margin-right: 8px; vertical-align: middle;"/>
                                    <span style="vertical-align: middle;">Личный кабинет</span>
                                </a>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table cellpadding="0" cellspacing="0" border="0" style="
                                            background-color: #ffffff;
                                            width: 184px;
                                            border-radius: 8px;
                                            margin-right: 24px;">
                        <tr style="display: table-cell" align="center">
                            <td style="padding: 16px 8px;">
                                <a href="<?= url('/active-orders/') ?>" style="
                                                        font-size: 15px;
                                                        text-decoration: none;
                                                        font-weight: 600;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        color: #666;
                                                        display: table-cell;">
                                    <img width="24"
                                         src="<?= url('/assets/images/mail/history.png') ?>"
                                         alt="Мои заказы"
                                         style="margin-right: 8px; vertical-align: middle;"/>
                                    <span style="vertical-align: middle;">Мои заказы</span>
                                </a>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table cellpadding="0" cellspacing="0" border="0" style="
                                            background-color: #ffffff;
                                            width: 184px;
                                            border-radius: 8px;">
                        <tr style="display: table-cell" align="center">
                            <td style="padding: 16px 8px;">
                                <a href="<?= url('/favorite/') ?>" style="
                                                        font-size: 15px;
                                                        text-decoration: none;
                                                        font-weight: 600;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        color: #666;
                                                        display: table-cell;">
                                    <img width="24"
                                         src="<?= url('/assets/images/mail/heart.png') ?>"
                                         alt="Личный кабинет"
                                         style="margin-right: 8px; vertical-align: middle;"/>
                                    <span style="vertical-align: middle;">Избранное</span>
                                </a>
                            </td>
                        </tr>
                    </table>
                </td>

            </tr>
            <tr style="background-color: #ffffff"></tr>
            <tr style="background-color: #ffffff"></tr>
        </table>
    </td>
</tr>

<!-- End Layout Cards -->
<tr>
    <!-- Footer -->
    <td align="center" valign="top" style="background: #0D0D0D; border-radius: 8px">
        <table cellpadding="0"
               cellspacing="0"
               border="0"
               width="100%"
               class="footer"
               style="width: 100% !important; min-width: 100%; max-width: 100%; padding: 40px 40px; display: block;">
            <tbody style="vertical-align: top">
            <tr>
                <td>
                    <table style="width: 232px; border-spacing: 0;">

                        <tr>
                            <td style="padding: 0;">
                                <a style="
                                                        display: inline-block;
                                                        color: #ffffff;
                                                        text-decoration: none;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 16px;
                                                        font-style: normal;
                                                        font-weight: 600;
                                                        line-height: 150%;
                                                        " href="tel:<?= \Simflex\Core\Core::siteParam(
                                    'phone'
                                ) ?>"><?= \Simflex\Core\Core::siteParam('phone') ?></a>
                            </td>
                        </tr>

                        <tr>
                            <td style="height: 24px; padding: 0;">
                                <a style="
                                                            margin-bottom: 20px;
                                                            display: inline-block;
                                                            color: #ffffff;
                                                            text-decoration: none;
                                                            font-family: 'Raleway', Arial, sans-serif;
                                                            font-size: 16px;
                                                            font-style: normal;
                                                            font-weight: 600;
                                                            line-height: 150%;"
                                   href="mailto:<?= \Simflex\Core\Core::siteParam(
                                       'email'
                                   ) ?>"><?= \Simflex\Core\Core::siteParam('email') ?></a>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0;">
                                <table cellpadding="0"
                                       cellspacing="0"
                                       border="0"
                                       style="margin-top: 8px">
                                    <tr>
                                        <?php
                                        if (\Simflex\Core\Core::siteParam('tg')): ?>
                                            <td style="padding-right: 8px">
                                                <a href="<?= \Simflex\Core\Core::siteParam(
                                                    'tg'
                                                ) ?>" style="cursor: point;">
                                                    <img src="<?= url(
                                                        '/assets/images/mail/telegram.png'
                                                    ) ?>"
                                                         width="32px"
                                                         alt="Telegram"/>
                                                </a>
                                            </td>
                                        <?php
                                        endif; ?>
                                        <?php
                                        if (\Simflex\Core\Core::siteParam('whats_app')): ?>
                                            <td style="padding-right: 8px">
                                                <a href="<?= \Simflex\Core\Core::siteParam(
                                                    'whats_app'
                                                ) ?>" style="cursor: point;">
                                                    <img src="<?= url(
                                                        '/assets/images/mail/whatsapp.png'
                                                    ) ?>"
                                                         width="32px"
                                                         alt="WhatsApp"/>
                                                </a>
                                            </td>
                                        <?php
                                        endif; ?>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table style="width: 136px; border-spacing: 0;">

                        <tr>
                            <td style="padding: 0;">
                                <a style="
                                                             margin-bottom: 8px;
                                                        display: inline-block;
                                                        color: #999;
                                                        text-decoration: none;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 600;
                                                        line-height: 150%;
                                                        " href="<?= url('/') ?>">Главная</a>
                            </td>
                        </tr>

                        <tr>
                            <td style="padding: 0;">
                                <a style="
                                                             margin-bottom: 8px;
                                                        display: inline-block;
                                                        color: #999;
                                                        text-decoration: none;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 600;
                                                        line-height: 150%;
                                                        " href="<?= url('/about/') ?>">О нас</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0;">
                                <a style="
                                                            margin-bottom: 8px;
                                                        display: inline-block;
                                                        color: #999;
                                                        text-decoration: none;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 600;
                                                        line-height: 150%;
                                                        " href="<?= url('/for-sellers/') ?>">Маркетплейсы</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0;">
                                <a style="
                                                            margin-bottom: 8px;
                                                        display: inline-block;
                                                        color: #999;
                                                        text-decoration: none;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 600;
                                                        line-height: 150%;
                                                        " href="<?= url('/brands/') ?>">Бренды</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0;">
                                <a style="
                                                            margin-bottom: 8px;
                                                        display: inline-block;
                                                        color: #999;
                                                        text-decoration: none;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 600;
                                                        line-height: 150%;
                                                        " href="<?= url('/contacts/') ?>">Контакты</a>
                            </td>
                        </tr>
                    </table>
                </td>

                <td>
                    <table style="width: 136x; border-spacing: 0;">

                        <tr>
                            <td style="padding: 0;">
                                <a style="
                                                             margin-bottom: 8px;
                                                        display: inline-block;
                                                        color: #999;
                                                        text-decoration: none;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 600;
                                                        line-height: 150%;
                                                        " href="<?= url('/payment/') ?>">Оплата</a>
                            </td>
                        </tr>

                        <tr>
                            <td style="padding: 0;">
                                <a style="
                                                             margin-bottom: 8px;
                                                        display: inline-block;
                                                        color: #999;
                                                        text-decoration: none;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 600;
                                                        line-height: 150%;
                                                        " href="<?= url('/delivery/') ?>">Доставка</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0;">
                                <a style="
                                                            margin-bottom: 8px;
                                                        display: inline-block;
                                                        color: #999;
                                                        text-decoration: none;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 600;
                                                        line-height: 150%;
                                                        " href="<?= url('/guarantees/') ?>">Гарантии</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0;">
                                <a style="
                                                            margin-bottom: 8px;
                                                        display: inline-block;
                                                        color: #999;
                                                        text-decoration: none;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 600;
                                                        line-height: 150%;
                                                        " href="<?= url('/refund/') ?>">Возврат</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0;">
                                <a style="
                                                            margin-bottom: 8px;
                                                        display: inline-block;
                                                        color: #999;
                                                        text-decoration: none;
                                                        font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 14px;
                                                        font-style: normal;
                                                        font-weight: 600;
                                                        line-height: 150%;
                                                        " href="<?= url('/questions/') ?>">Частые вопросы</a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            </tbody>
        </table>
    </td>
    <!-- End Footer -->

    <!-- Copyrights -->
</tr>
<tr>
    <td style="height: 20px; background-color: transparent"></td>
</tr>
<tr>
    <td>
        <table>
            <tr>
                <td valign="center" style="background-color: transparent">
                                        <span style="
                                        font-family: 'Raleway', Arial, sans-serif;
                                        font-style: normal;
                                        color: #999;
                                        font-size: 14px;
                                        line-height: 150%;
                                        font-weight: 600;
                                        font-feature-settings: 'pnum' on, 'lnum' on, 'ss09' on, 'liga' off;">
                                            ©<?= date('Y') ?> Rhstore, Все права защищены. ИП Ширванян Нарек Акопович
                                        </span>
                </td>

            </tr>
            <tr>
                <td valign="center" style="background-color: transparent">
                                        <span style="
                                       font-family: 'Raleway', Arial, sans-serif;
                                            font-style: normal;
                                            color: #999;
                                            font-size: 14px;
                                            line-height: 150%;
                                            font-weight: 600;
                                            font-feature-settings: 'pnum' on, 'lnum' on, 'ss09' on, 'liga' off;">
                                            ИНН 774331605093 ОГРНИП 320774600167030
                                        </span>
                </td>

            </tr>
        </table>
    </td>
</tr>
<!-- End Copyrights -->
<tr>
    <td style="height: 20px; background-color: transparent"></td>
</tr>
</table>
</td>
</tr>
</table>
</body>

</html>