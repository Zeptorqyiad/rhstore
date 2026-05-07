<table cellpadding="0"
       cellspacing="0"
       border="0"
       style=" border-radius: 8px; background-color: #ffffff; width: 100%;">
    <tr>
        <td>
            <table cellpadding="0"
                   cellspacing="0"
                   border="0"
                   style="width: 100%; margin-bottom: 20px;">
                <tr>
                    <td>
                        <img width="40"
                             src="<?= url('/assets/images/mail/point.png') ?>"
                             style="margin-right: 12px;"/></td>
                    <td style="vertical-align: top">
                                                        <span style="font-family: 'Raleway', Arial, sans-serif;
                                                        font-size: 16px;
                                                        font-style: normal;
                                                        font-weight: 700;
                                                        line-height: 150%;
                                                        color: #0D0D0D;">Получение
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
                                                            <?php
                                                            $tk = \Simflex\Core\Container::getFactory()->create(
                                                                \App\Extensions\Catalog\Model\Transcomp::class,
                                                                $order->transcomp_id
                                                            );
                                                            echo $tk->name
                                                            ?></span>
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
                                                         <?php
                                                         if ($tk->transcomp_id == 3): ?>
                                                             <?= $tk->delivery_time ?>
                                                         <?php
                                                         else: ?>
                                                             г. <?= $order->city ?>, <?= $order->address ?>
                                                         <?php
                                                         endif; ?></span>
                    </td>

                </tr>

            </table>
        </td>
    </tr>

</table>