<?php

namespace App\Extensions\Catalog2\Component;

use Dadata\DadataClient;
use http\Env\Request;
use Simflex\Core\Container;
use Simflex\Core\DB;
use Simflex\Core\Log;
use Simflex\Core\Session;
use Simflex\Extensions\Content\Model\ModelContent;

class User extends \App\Extensions\Catalog\Component\User
{
    public function __construct(protected \Simflex\Core\Request $request)
    {
        parent::__construct();
    }

    protected function content()
    {
        if (!Container::getUser()) {
            Session::set('ask_login', true);
            header('Location: /');
            exit;
        }

        if ($this->request->getPath() == '/user/reset/') {
            $this->reset();
            parent::content();
            return;
        }

        if ($this->request->isAjax()) {
            exit(json_encode($this->{$this->request->request('action')}()));
        }

        parent::content();
    }

    protected function reset()
    {
        if (!Session::get('can_reset')) {
            header('Location: /');
            exit;
        }

        if (!$this->request->isPost()) {
            return;
        }

        $user = Container::getUser();
        $user->password = password_hash($this->request->request('password'), PASSWORD_DEFAULT);
        $user->save();

        Session::set('can_reset', false);
        header('Location: /user/');
        exit;
    }

    protected function onFindCompany()
    {
        $dd = new DadataClient(env('DADATA_API'), env('DADATA_KEY'));
        return $dd->suggest('party', $this->request->request('q'));
    }

    protected function onSave()
    {
        $r = Container::getRequest();
        if (!$r->request('name')) {
            return;
        }

        $u = Container::getUser();

        $update = [];
        $updateVals = [];

        $upd = function (string $name, $val = null) use (&$update, &$updateVals, $r) {
            $update[] = $name;
            $updateVals[] = is_null($val) ? $r->request($name) : $val;
        };

        if ($r->request('email') != $u->email) {
            if (DB::result('select user_id from user where email like ?', 0, [$r->request('email')])) {
                Session::set('us_error', 'Введенная почта уже используется');
                return;
            }

            $upd('email');
            $upd('mail_code', random_int(100000, 999999));
            $upd('mail_verified', 0);
        }

        if ($r->request('password')) {
            $upd('password', password_hash($r->request('password'), PASSWORD_DEFAULT));
        }

        $upd('name');
        $upd('last_name');
        $upd('phone');
        $upd('in_mailing');
        $upd('other_name');
        $upd('other_last_name');
        $upd('other_phone');
        $upd('other_email');
        $upd('city');
        $upd('address');
        $upd('org_name');
        $upd('org_inn');
        $upd('org_active');
        $upd('org_account');
        $upd('org_bic');

        DB::query(
            'update user set ' . implode(',', array_map(fn($i) => $i . ' = ?', $update)) . ' where user_id = ?',
            array_merge($updateVals, [$u->user_id])
        );

        if (DB::error()) {
            Log::error('oha {e}', ['e' => DB::error()]);
        }

        Session::set('user_updated', true);
        $u->reload();
    }
}