<?php
namespace App\Extensions\Catalog2\Component;

use App\Extensions\Catalog\TelegramAssist;
use Simflex\Core\Container;
use Simflex\Core\DB;
use Simflex\Core\Time;

class Question extends \App\Extensions\Catalog\Component\Question
{
    protected function make()
    {
        $r = $this->request;

        $u = Container::getUser();
        $q = new \App\Extensions\Catalog\Model\Question();
        $q->product_id = null;
        $q->name = $u->name;
        $q->txt = $r->request('question');
        $q->is_anonymous = $r->request('anonymous') == 'true' ? 1 : 0;
        $q->date = Time::mysql(time());
        $q->user_id = $u->user_id;
        $q->likes = 0;
        $q->dislikes = 0;
        $q->reply = '';
        $q->is_active = 0;
        $q->is_read_by_user = 0;
        $q->save();
        if (DB::error()) {
            return ['success' => false, 'err' => DB::error()];
        }

        $ud = TelegramAssist::fixMessage(
            $u ? ($u->name . ' ' . $u->last_name . ' (' . $u->login . ')') : $r->request('name')
        );
        $qd = TelegramAssist::fixMessage($r->request('question'));
        $qu = url('/admin/shop/question/?action=form&question_id=' . $q->getId());

        //todo: uncommit if tg is work again
//        (new TelegramAssist())->content(
//            <<<MD
//**НОВЫЙ ВОПРОС**
//**Пользователь**: $ud
//**Вопрос**: $qd
//
//[Посмотреть вопрос в админке]($qu)
//MD
//        )->send();

        return ['success' => true];
    }
}