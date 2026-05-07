<?php
namespace App\Extensions\Callback\Admin;

use Simflex\Admin\Base;
use Simflex\Core\DB;
use Simflex\Core\Time;

class Callback extends Base
{
    public function show()
    {
        $this->selectAdditional = ['callback.edited_on'];
        parent::show();
    }

    public function save()
    {
        if (!$_POST['edited_on']) {
            $_POST['edited_on'] = Time::mysql(time());
        }

        $ret = parent::save();
        if ($ret) {
            DB::query('update callback set edited_on = CURRENT_TIMESTAMP() where callback_id = ?', [$ret]);
        }

        return $ret;
    }

    protected function showCell($field, $row)
    {
        if ($field->name == 'edited_by') {
            if (!$row['edited_by']) {
                $row['edited_by_label'] = '-';
            }

            if ($row['edited_by_label']) {
                $row['edited_by_label'] = '<b>' . $row['edited_by_label'] . '</b><br/>' . Time::userfull($row['edited_on']);
            }
        }

        parent::showCell($field, $row);
    }
}