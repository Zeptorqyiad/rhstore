<?php

namespace App\Extensions\Promotion\Component;

use Simflex\Core\Container;
use Simflex\Core\Page;
use Simflex\Extensions\Breadcrumbs\Breadcrumbs;
use Simflex\Extensions\Content\Content;
use Simflex\Extensions\Content\Model\ModelContent;

class Promotion extends Content
{
    protected ?\App\Extensions\Promotion\Model\Promotion $promotion;
    protected string $path = '/promotions/';
    protected int $c = 0;

     public function get($path = ''): ?ModelContent
    {
        $ret = parent::get($this->path);
        if ($this->promotion) {
            $ret['title'] = $this->promotion->name;
        }

        return $ret;
    }
    protected function content()
    {
        $this->c = $_REQUEST['c'] ?? 0;

        Breadcrumbs::remove('/promotions/promo/');

        $this->promotion = \App\Extensions\Promotion\Model\Promotion::findOne(['alias' => Container::getRequest()->getUrlLastPart()]);
        if ($this->promotion) {
            Breadcrumbs::add($this->promotion->banner_title.' '.$this->promotion->banner_title_accent.' '.$this->promotion->banner_title_third, '/promotions/' . $this->promotion->alias . '/');
            $this->path = '/promotions/promo/';
            $this->promotion->save();
        }
        
        Breadcrumbs::add('Акции', '/promotions/');

        parent::content();
    }
}