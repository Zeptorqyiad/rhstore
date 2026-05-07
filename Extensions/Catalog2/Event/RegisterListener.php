<?php

namespace App\Extensions\Catalog2\Event;

use App\Extensions\Catalog2\Component\Auth;
use Simflex\Core\Events\EventListener;
use Simflex\Core\Events\GroupEvents;
use Simflex\Core\Models\User;
use Simflex\Core\Request;

class RegisterListener implements EventListener
{
    use GroupEvents;

    public function onRegisterPre(User $user, Request $req)
    {

    }

    public function onRegisterPost(User $user)
    {

    }
}