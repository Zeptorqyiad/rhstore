<?php

namespace App\Extensions\Callback\Admin;

use Simflex\Admin\Base;
use Simflex\Core\DB;

class CallbackEmail extends Base
{
    public function showActions()
    {
        include 'tpl/callback_actions.tpl';
        parent::showActions();
    }

    public function export()
    {
        $out = [];
        foreach (DB::assoc('select * from callback_email where is_subscribed = 1') as $v) {
            if (!$out) {
                $out[] = implode(';', array_keys($v));
            }
            $out[] = implode(';', array_values($v));
        }

        header('Content-Disposition: attachment; filename=out.csv');
        echo implode("\n", $out);
        exit;
    }
}