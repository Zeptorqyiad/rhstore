<?php

namespace App\Extensions\Catalog2\Model;

use App\Extensions\Catalog\Model\Order;

class User extends \Simflex\Core\Models\User
{
    public function updateLevel()
    {
        $level = UserLevel::findAdv()->where('min <= ?')->bind([$this->spent])->orderBy('level_ord desc')->fetchOne();
        $this->level = $level->level_id;
        $this->save();
    }

    public function getLevel()
    {
        $p1 = $this->level ? UserLevel::findOne(['level_id' => $this->level]) : null;
        return $p1 ?: UserLevel::findOne(['min' => 0]);
    }

    public function hasOldProducts(): bool
    {
        return !!Order::find([
            'user_id' => $this->user_id
        ]);
    }
}