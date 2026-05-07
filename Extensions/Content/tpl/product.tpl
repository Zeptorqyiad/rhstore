<?php
App\Layout\Pages\Product\Layout::draw([
    $index = $content->loadFrom('/'),
    'prod' => $this->prod,
    'delivery' => $content['params']['delivery_text'],
    'payment' => $content['params']['pay_text'],
    'delivery_block' => $content['params']['delivery_text2'],
    'why_us' => self::getTableFrom('why_us', $index)

]);

