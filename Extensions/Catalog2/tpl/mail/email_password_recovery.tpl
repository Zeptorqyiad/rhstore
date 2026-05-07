<?php

include 'header.tpl'; ?>

    <!-- Message Registration Complete  -->
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
                    color: #0D0D0D;
                    ">Здравствуйте, <?= $user->name ?></span>
                    </td>
                </tr>
                <tr style="height: 12px;"></tr>
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
                    ">
                            Вы оставили заявку на восстановление пароля. Если вы этого не делали, то
                            проигнорируйте это сообщение.</p>
                    </td>
                </tr>
                <tr style="height: 20px;"></tr>
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
                    display: inline-block;
                    " href="<?= url(
                            '/auth/',
                            [
                                'action' => 'resetComplete',
                                'i' => base64_encode(json_encode([
                                    'e' => $user->email,
                                    'c' => $user->mail_code
                                ]))
                            ]
                        ) ?>">Восстановить пароль</a>
                    </td>
                    <td>
                        <img width="130"
                             src="<?= url('/assets/images/mail/lock.png') ?>">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <!-- End Message Registration Complete -->
<?php
include 'footer.tpl'; ?>