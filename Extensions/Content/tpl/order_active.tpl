<?php
App\Layout\Pages\OrderActive\Layout::draw([
    'number' => $this->order->order_id,
    'date' => \Simflex\Core\Time::user($this->order->date),
    'status' => $this->order->statusToText(),
    'badge_color' => $this->order->statusToFrontend(),
    'sum' => $this->order->getTotal(),
    'count' => $this->order->getProductCount(),
    'track_link' => $this->order->tracking,
    'order' => $this->order,
]);