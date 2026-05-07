<?php include 'header.tpl'; ?>
<!-- Message Registration Complete  -->
<tr>
    <td style="padding: 40px 21px 0 40px; background: #FFFFFF; border-radius: 8px">
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
                    ">Благодарим вас за регистрацию в нашем интернет-магазине! Чтобы подтвердить почту, нажмите на
                        кнопку "Подтвердить почту" </p>
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
                    display: inline-block;
                    " href="<?= url(
                        '/auth/',
                        [
                            'action' => 'complete',
                            'u' => $user->user_id,
                            'c' => $user->mail_code
                        ]
                    ) ?>">Подтвердить почту</a>
                </td>
                <td>
                    <img width="130"
                         src="<?= url('/assets/images/mail/hand.png') ?>">
                </td>
            </tr>
        </table>

    </td>
</tr>
<!-- End Message Registration Complete -->
<?php include 'footer.tpl'; ?>
