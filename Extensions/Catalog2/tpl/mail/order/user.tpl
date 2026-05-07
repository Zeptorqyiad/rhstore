<table cellpadding="0"
       cellspacing="0"
       border="0"
       style=" border-radius: 8px; background-color: #ffffff; width: 100%; margin-bottom: 12px">
    <tr>
        <td>
            <table cellpadding="0"
                   cellspacing="0"
                   border="0"
                   style="width: 254px; height: 116px;">
                <tr>
                    <td style="width: 52px">
                        <img width="40" src="<?= url('/assets/images/mail/face.png') ?>"></td>
                    <td style="vertical-align: top">
                                                        <span style="font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 16px;
                                                        font-style: normal;
                                                        font-weight: 700;
                                                        line-height: 150%;
                                                        color: #0D0D0D;">Получатель
                                                        </span>
                    </td>

                </tr>

                <tr>
                    <td></td>

                    <td>
                                                     <span style="font-family: 'Raleway', Arial, sans-serif;
                                                    font-size: 14px;
                                                    font-style: normal;
                                                    font-weight: 600;
                                                    line-height: 150%;
                                                    color: #404040;">
                                                            <?= $order->name ?> <?= $order->last_name ?></span>
                    </td>

                </tr>

                <tr>
                    <td></td>

                    <td>
                                                     <span style="font-family: 'Raleway', Arial, sans-serif;
                                                    font-size: 14px;
                                                    font-style: normal;
                                                    font-weight: 600;
                                                    line-height: 150%;
                                                    color: #404040;">
                                                            <?= $order->phone ?></span>
                    </td>

                </tr>

                <tr>
                    <td></td>

                    <td>
                                                     <span style="font-family: 'Raleway', Arial, sans-serif;
                                                    font-size: 14px;
                                                    font-style: normal;
                                                    font-weight: 600;
                                                    line-height: 150%;
                                                    color: #404040;">
                                                            <?= $order->email ?></span>
                    </td>

                </tr>
                <tr>
                    <td></td>

                    <td style="height: 24px">

                    </td>

                </tr>

            </table>
        </td>
        <?php
        if ($user->org_active): ?>
            <td>
                <table cellpadding="0"
                       cellspacing="0"
                       border="0"
                       style="width: 254px;  height: 116px;">
                    <tr>
                        <td>
                            <img width="40"
                                 src="<?= url('/assets/images/mail/house.png') ?>"
                                 style=" vertical-align: middle;"/>
                        </td>
                        <td style="vertical-align: top">
                                                        <span style="font-family: 'Raleway', Arial, sans-serif;
                                                    font-size: 16px;
                                                    font-style: normal;
                                                    font-weight: 700;
                                                    line-height: 150%;
                                                    color: #0D0D0D;">
                                                            Организация:</span>
                        </td>

                    </tr>

                    <tr>
                        <td></td>

                        <td>
                                                     <span style="font-family: 'Raleway', Arial, sans-serif;
                                                    font-size: 14px;
                                                    font-style: normal;
                                                    font-weight: 600;
                                                    line-height: 150%;
                                                    color: #404040;">
                                                            <?= $user->org_name ?></span>
                        </td>

                    </tr>

                    <tr>
                        <td></td>

                        <td>
                                                     <span style="font-family: 'Raleway', Arial, sans-serif;
                                                    font-size: 14px;
                                                    font-style: normal;
                                                    font-weight: 600;
                                                    line-height: 150%;
                                                    color: #404040;">
                                                            ИНН: <?= $user->org_inn ?></span>
                        </td>

                    </tr>

                    <tr>
                        <td></td>

                        <td>
                                                     <span style="font-family: 'Raleway', Arial, sans-serif;
                                                    font-size: 14px;
                                                    font-style: normal;
                                                    font-weight: 600;
                                                    line-height: 150%;
                                                    color: #404040;">
                                                            Р/С: <?= $user->org_account ?></span>
                        </td>

                    </tr>
                    <tr>
                        <td></td>

                        <td>
                                                     <span style="font-family: 'Raleway', Arial, sans-serif;
                                                    font-size: 14px;
                                                    font-style: normal;
                                                    font-weight: 600;
                                                    line-height: 150%;
                                                    color: #404040;">
                                                            БИК Банка: <?= $user->org_bic ?></span>
                        </td>

                    </tr>
                </table>
            </td>
        <?php
        endif; ?>
    </tr>
</table>