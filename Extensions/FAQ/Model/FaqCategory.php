<?php

namespace App\Extensions\FAQ\Model;

use Simflex\Core\ModelBase;

/**
 * @property int qc_id
 * @property int npp
 * @property string name
 */

class FaqCategory extends ModelBase
{
    protected static $table = 'info_qna_category';
    protected static $primaryKeyName = 'qc_id';

    public function getChildren()
    {
        return Faq::findAdv()->where(['qc_id' => $this->qc_id])
            ->orderBy('npp')
            ->all();
    }
}