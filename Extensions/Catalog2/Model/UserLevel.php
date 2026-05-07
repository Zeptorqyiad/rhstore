<?php
namespace App\Extensions\Catalog2\Model;

use Simflex\Core\ModelBase;

class UserLevel extends ModelBase
{
    protected static $table = 'user_level';
    protected static $primaryKeyName = 'level_id';

    public function getNextLevel()
    {
        return self::findAdv()->where('level_ord > ?')->bind([$this->level_ord])->orderBy('level_ord')->fetchOne();
    }
}