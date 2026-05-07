<?php

namespace App\Extensions\Catalog2\Component;

use App\Extensions\Catalog\MailAssist;
use App\Extensions\Catalog\Model\OrderProduct;
use App\Extensions\Catalog\Model\Product;
use App\Extensions\Catalog\Model\ProductVariant;
use App\Extensions\Catalog\Model\Transcomp;
use App\Extensions\Catalog\SaleAssist;
use App\Extensions\Catalog\SessionAssist;
use App\Extensions\Catalog2\PriceAssist;
use Simflex\Core\Container;
use Simflex\Core\DB;
use Simflex\Core\Events\Event;
use Simflex\Core\Log;
use Simflex\Core\Request;
use Simflex\Core\Session;
use Simflex\Core\Time;
use Simflex\Extensions\Breadcrumbs\Breadcrumbs;
use Simflex\Extensions\Content\Model\ModelContent;

class Order extends \App\Extensions\Catalog\Component\Order
{
    protected function updateDelivery(): array
    {
        $u = Container::getUser();
        $u->other_last_name = $this->request->request('last_name');
        $u->other_name = $this->request->request('name');
        $u->other_phone = $this->request->request('phone');
        $u->other_email = $this->request->request('email');
        $u->org_name = $this->request->request('org_name');
        $u->org_inn = $this->request->request('org_inn');
        $u->transcomp_id = $this->request->request('transcomp_id');
        if ($u->transcomp_id == 6) {
            $u->transcomp_id = $this->request->request('transcomp_id2');
        }

        $u->city = $this->request->request('city');
        $u->address = $this->request->request('address');

        return ['success' => $u->save()];
    }

    public function get($path = ''): ?ModelContent
    {
        $ret = parent::get($path);
        if ($ret) {
            if ($this->request->getPath() == '/user/orders/') {
                $ret['title'] = $this->request->request('active') ? 'Активные заказы' : 'Архивные заказы';
            }
        }

        return $ret;
    }

    protected function all()
    {
        parent::all();

        Breadcrumbs::remove('/user/order/');
        if ($this->request->request('active')) {
            Breadcrumbs::add('Активные заказы', '/user/orders/?active=1');
            $this->template = 'orders2.tpl';
        } else {
            Breadcrumbs::add('Архивные заказы', '/user/orders/');
        }
    }

    protected function item()
    {
        parent::item();
        if ($this->order->status == 'finished' || $this->order->status == 'canceled') {
            $this->template = 'order_archived.tpl';
        } else {
            $this->template = 'order_active.tpl';
        }
    }

    protected function content()
    {
        $req = Container::getRequest();
        $user = Container::getUser();
        if (!$user) {
            $this->path = '/sign-in/';
            parent::content();
            return;
        }

        return parent::content();
    }

    protected function make($s = '')
    {
        if (!Container::getUser()) {
            Session::set('ask_login', true);
            header('Location: /');
            exit;
        }

        $user = Container::getUser();
        $r = Container::getRequest();
        $cart = SessionAssist::$cart;

        // make sure cart is not empty
        $cart->rebuildData();
        if (!$cart->getProductCount()) {
            header('Location: /cart/');
            exit;
        }

        // check if we need to update user data
        if ($user->email != $r->request('email')) {
            $user->email = $r->request('email');
            $user->mail_verified = 0;
            $user->save();
        }

        $changed = false;
        if ($f = $r->request('org_account')) {
            $user->org_account = $f;
            $changed = true;
        }

        if ($f = $r->request('org_bic')) {
            $user->org_bic = $f;
            $changed = true;
        }

        if ($changed) {
            $user->save();
        }

        // create a new order
        $order = $this->factory->create(\App\Extensions\Catalog\Model\Order::class);
        $order->user_id = $user->user_id;
        $order->date = Time::create()->asMySQL();
        $order->status = $s ?: \App\Extensions\Catalog\Model\Order::STATUS_PAY;
        $order->status_num = $s ? 3 : 0;
        $order->name = $user->other_name;
        $order->last_name = $user->other_last_name;
        $order->phone = $user->other_phone;
        $order->email = $user->email;
        $order->transcomp_id = $user->transcomp_id;
        $order->city = $user->city;
        $order->address = $user->address;
        $order->tracking = '';
        $order->sum_total = 0;
        $order->sum_actual = 0;
        $order->qty = 0;
        $order->discount = $user->discount ?? 0;

        $this->eventManager->dispatch(new Event('order_pre_save', self::class, $order, $user));

        $order->save();
        $order->reload();

        $this->eventManager->dispatch(new Event('order_post_save', self::class, $order, $user));

        $tc = new Transcomp($order->transcomp_id);
        $added = 0;

        // copy products from cart
        foreach ($cart->getProducts()['items'] as $pi) {
            /** @var Product $p */
            $p = $pi['product'];
            if (!$pi['qty'] || !$p->is_active) {
                $cart->removeProduct($p->product_id, $pi['variant_id'], false);
                continue;
            }

            $stock = null;
            if ($pi['variant_id']) {
                $var = new ProductVariant($pi['variant_id']);
                $stock = $var->stock;
            } else {
                $stock = $p->stockData;
            }

            $priceOld = PriceAssist::getPrice($p->product_id, null);
            $price = $priceOld - $priceOld * SaleAssist::getModFor($p->product_id);

            // shouldnt be here but still
            if (!$stock) {
                $cart->removeProduct($p->product_id, $pi['variant_id'], false);
                continue;
            }

            $qty = $pi['qty'];

            $op = new OrderProduct();
            $op->order_id = $order->order_id;
            $op->product_id = $p->product_id;
            $op->variant_id = $pi['variant_id'];
            $op->qty = $qty;
            $op->sum = $pi['sum_actual'];
            $op->price = $price;
            $op->price_old = $priceOld;

            if (!$op->qty) {
                continue;
            }

            if (!$op->save()) {
                continue;
            }

            $stock->lock($op->qty);
            $added++;
        }

        // update order info
        $cart->rebuildData();
        if (!$cart->getProductCount() || !$added) {
            DB::query('delete from catalog_order_product where order_id = ?', [$order->order_id]);
            $order->delete();

            header('Location: /cart/');
            exit;
        }

        $order->sum_total = $cart->__sum_total;
        $order->sum_actual = $cart->__sum_actual;
        $order->qty = $cart->getTotalOrderCount();
        $order->payment_id = $r->request('payment_id', 0) ?: 0;
        $order->delivery_dates = $cart->delivery_dates;

        Log::info('hello!');

        $tk = Container::getFactory()->create(Transcomp::class, $order->transcomp_id);
        $order->delivery_sum = (float)(mb_strtolower($tk->price) == 'бесплатно' ? 0 : explode(' ', $tk->price)[1]);
        $order->rebuildData();

        $user->spent += $order->getTotalNum();
        $user->updateLevel();

        // send the mail
        if ($user->mail_verified) {
            (new MailAssist($user->email, ('Заказ') . ' №' . $order->order_id . ' создан'))
                ->alsoTo('form_email')
                ->tpl('email_order_pay.tpl', ['order' => $order, 'user' => $user])
                ->send();
        }

        //todo: uncommit if tg is work again
//        $this->sendTelegram(
//            $order->last_name . ' ' . $order->name . ' ' . $order->patronym
//            . ', ' . $order->phone . ', ' . $user->email,
//            $order->order_id,
//            $order->sum_actual,
//            $s ? 'ДОЗАКАЗ' : 'НОВЫЙ ЗАКАЗ'
//        );

        // flush cart
        DB::query('delete from catalog_cart_product where cart_id = ?', [$cart->cart_id]);

        header('Location: /user/order/success/');
        exit;
    }


}