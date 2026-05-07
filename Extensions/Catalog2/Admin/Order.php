<?php

namespace App\Extensions\Catalog2\Admin;

class Order extends \App\Extensions\Catalog\Admin\Order
{
    protected function getQuerySelect()
    {
        return str_replace(
            [
                'JOIN catalog_payment catalog_paymentpayment_id ON catalog_paymentpayment_id.payment_id=catalog_order.payment_id',
                'catalog_order.payment_id, catalog_paymentpayment_id.name payment_id_label,'
            ],
            '',
            parent::getQuerySelect()
        );
    }
}