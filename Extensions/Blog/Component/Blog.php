<?php

namespace App\Extensions\Blog\Component;

use Simflex\Extensions\Breadcrumbs\Breadcrumbs;
use Simflex\Core\Container;
use Simflex\Extensions\Content\Content;
use Simflex\Extensions\Content\Model\ModelContent;

class Blog extends Content
{
    protected ?\App\Extensions\Blog\Model\Blog $post;
    protected string $path = '/blog/';
    protected int $c = 0;

    public function get($path = ''): ?ModelContent
    {
        $ret = parent::get($this->path);
        if ($this->post) {
            $ret['title'] = $this->post->name;
        }

        return $ret;
    }

    protected function content()
    {
        $this->c = $_REQUEST['c'] ?? 0;

        Breadcrumbs::remove('/blog/post/');

        $this->post = \App\Extensions\Blog\Model\Blog::findOne(['alias' => Container::getRequest()->getUrlLastPart()]);
        if ($this->post) {
            Breadcrumbs::add($this->post->name, '/blog/'.$this->post->alias.'/');
            $this->path = '/blog/post/';
            $this->post->save();
        }

        Breadcrumbs::add('Новости компании', '/blog/');

        parent::content();
    }
}