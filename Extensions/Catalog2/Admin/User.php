<?php

namespace App\Extensions\Catalog2\Admin;

use Simflex\Core\Container;

class User extends \App\Extensions\Catalog\Admin\User
{
    public function save()
    {
        $ret = parent::save();
        if ($ret) {
            $u = Container::getFactory()->create(\Simflex\Core\Models\User::class, $ret);
            $u->updateLevel();
        }

        return $ret;
    }
}