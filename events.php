<?php

/*
Fill in the events you want to listen to
Namespace => [Listener, Listener, ...]

Example:

return [
    Init::class => [
        \App\Extensions\Catalog2\Events\InitListener::class,
    ]
];
 */

return [
    \App\Extensions\Catalog2\Component\Auth::class => [
        \App\Extensions\Catalog2\Event\RegisterListener::class,
    ],
    \App\Extensions\Catalog\Component\Order::class => [
        \App\Extensions\Catalog2\Event\OrderListener::class,
    ]
];