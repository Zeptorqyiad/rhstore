<?php

namespace App\Extensions\FAQ\Model;

use Simflex\Core\ModelBase;

/**
 * @property int qna_id
 * @property int npp
 * @property int qc_id
 * @property string question
 * @property string answer
 *
 * @property FaqCategory category
 */

class Faq extends ModelBase
{
    protected static $table = 'info_qna';
    protected static $primaryKeyName = 'qna_id';

    public function offsetGetCategory(): FaqCategory
    {
        return FaqCategory::findOne(['qc_id' => $this->qc_id]);
    }
}