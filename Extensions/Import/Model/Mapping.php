<?php

namespace App\Extensions\Import\Model;

use Simflex\Core\Buffer;
use Simflex\Core\DB;
use Simflex\Core\ModelBase;

class Mapping extends ModelBase
{
    protected static $primaryKeyName = 'mapping_id';
    protected static $table = 'mp_mapping';

    public function getTable(): string
    {
        return Buffer::getOrSet(
            'tn.' . $this->table_id,
            fn() => DB::result('select name from struct_table where table_id = ?', 0, [$this->table_id])
        );
    }
}