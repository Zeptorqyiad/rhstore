<?php

namespace App\Extensions\Catalog2\Event;

use App\Extensions\Catalog\Model\Order;
use App\Extensions\Catalog2\Model\User;
use Simflex\Core\Events\EventListener;
use Simflex\Core\Events\GroupEvents;

class OrderListener implements EventListener
{
    use GroupEvents;

    public function onOrderPreSave(Order $order, ?User $user = null): void
    {
        if (!$user) {
            return;
        }

        if (!empty($user->other_email)) {
            $order->email = $user->other_email;
        }
    }
}
