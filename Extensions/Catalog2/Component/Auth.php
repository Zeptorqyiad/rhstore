<?php

namespace App\Extensions\Catalog2\Component;

use App\Extensions\Catalog\MailAssist;
use App\Extensions\Catalog\Model\Fav;
use App\Extensions\Catalog\SessionAssist;
use App\Plugins\GeoIp\GeoIp;
use Simflex\Core\Buffer;
use Simflex\Core\Container;
use Simflex\Core\Core;
use Simflex\Core\DB;
use Simflex\Core\Events\Event;
use Simflex\Core\Factory;
use Simflex\Core\Helpers\Str;
use Simflex\Core\Log;
use Simflex\Core\Models\User;
use Simflex\Core\Request;
use Simflex\Core\Session;

class Auth extends \App\Extensions\Catalog\Component\Auth
{
    public function __construct(protected Request $request, protected Factory $factory)
    {
        parent::__construct();
    }

    protected function login()
    {
        // check if user already exists
        if (Container::getUser()) {
            return ['success' => false, 'error' => 'logged_in'];
        }

        $login = DB::escape($this->request->request('phone'));

        // locate user
        $user = User::findAdv()->where("login like ? or email like ?")->bind([$login, $login])->fetchOne();
        if (!$user || !$user->active || !password_verify($_REQUEST['pwd'], $user->password)) {
            return ['success' => false, 'error' => 'invalid_user'];
        }

        // finalize
        $this->auth($user);
        return ['success' => true];
    }

    protected function logout()
    {
        Log::info('logging out!');

        SessionAssist::$forceReset = true;
        Buffer::delete('cart');
        Buffer::delete('fav');

        // clone cart
        $cart = \App\Extensions\Catalog2\Model\Cart::getOrInsert();
        $q = DB::query('select * from catalog_cart_product where cart_id = ?', [SessionAssist::$cart->cart_id]);
        while ($r = DB::fetch($q)) {
            DB::query(
                'insert into catalog_cart_product (cart_id, product_id, sum_total, sum_actual, qty, variant_id) values (?, ?, ?, ?, ?, ?)',
                [
                    $cart->cart_id,
                    $r['product_id'],
                    $r['sum_total'],
                    $r['sum_actual'],
                    $r['qty'],
                    $r['variant_id']
                ]
            );
        }
        $cart->rebuildData();

        // clone fav
        $fav = Fav::getOrInsert();
        $q = DB::query('select * from catalog_fav_product where fav_id = ?', [$fav->fav_id]);
        while ($r = DB::fetch($q)) {
            DB::query(
                'insert into catalog_fav_product (fav_id, product_id, variant_id) values (?, ?, ?)',
                [$fav->fav_id, $r['product_id'], $r['variant_id']]
            );
        }

        parent::logout();
    }

    protected function register()
    {
        // check if user already exists
        if (Container::getUser()) {
            return ['success' => false, 'error' => 'logged_in'];
        }

        $login = DB::escape($this->request->request('phone'));
        $email = DB::escape($this->request->request('email'));

        // locate user
        $user = User::findOne("login like '$login' or login like '$email' or email like '$email'");
        if ($user) {
            return ['success' => false, 'error' => 'already_exists'];
        }

        $req = $this->request;

        // create user
        $user = new User();
        $user->role_id = 3;
        $user->active = 1;
        $user->login = $email;
        $user->password = password_hash($req->request('pwd'), PASSWORD_BCRYPT);
        $user->email = $req->request('email');
        $user->name = $req->request('name');
        $user->last_name = $req->request('last_name');
        $user->hash = '';
        $user->hash_admin = '';
        $user->code = 123456; // random_int(100000, 999999); // TODO: set real code
        $user->phone = $login;
        $user->city = class_exists(GeoIp::class) ? GeoIp::getCurrentCity() : '';

        Container::getEvents()->dispatch(new Event('register_pre', static::class, $user));

        if (!$user->save()) {
            return ['success' => false, 'error' => 'system_error', 'extra' => DB::error()];
        }

        Auth::auth($user);
        Container::getEvents()->dispatch(new Event('register_post', static::class, $user));

        return ['success' => true];
    }

    protected function reset()
    {
        // check if user already exists
        if (Container::getUser()) {
            return ['success' => false, 'error' => 'logged_in'];
        }

        $email = DB::escape($_REQUEST['email']);

        // locate user
        $user = User::findOne("login like '$email' or email like '$email'");
        if (!$user || !$user->active) {
            return ['success' => false, 'error' => 'user_not_found'];
        }

        $user->mail_code = random_int(100000, 999999);
        $user->save();

        // send reset email (only in live mode)
        (new MailAssist($email, 'Сброс пароля ' . Core::siteParam('sitename')))
            ->tpl('email_password_recovery.tpl', ['user' => $user])
            ->send();

        return ['success' => true];
    }

    protected function resetComplete()
    {
        $data = $this->request->request('i');
        $data = json_decode(base64_decode($data), true);

        $email = $data['e'];
        $user = User::findAdv()->where("login like ? or email like ?")->bind([$email, $email])->fetchOne();
        if (!$user || !$user->active || $user->mail_code != $data['c']) {
            header('Location: /');
            exit;
        }

        $user->mail_code = 0;
        $user->save();

        static::auth($user);

        Session::set('can_reset', true);
        header('Location: /user/reset/');
        exit;
    }
}