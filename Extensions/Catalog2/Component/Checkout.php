<?php

namespace App\Extensions\Catalog2\Component;

use App\Extensions\Catalog\MailAssist;
use App\Extensions\Catalog\Model\OrderProduct;
use App\Extensions\Catalog\Model\Product;
use App\Extensions\Catalog\Model\ProductVariant;
use App\Extensions\Catalog\SaleAssist;
use App\Extensions\Catalog\SessionAssist;
use App\Extensions\Catalog2\ExcelGenerator;
use App\Extensions\Catalog2\PriceAssist;
use Simflex\Core\ComponentBase;
use Simflex\Core\Container;
use Simflex\Core\Core;
use Simflex\Core\DB;
use Simflex\Core\Events\Event;
use Simflex\Core\Time;
use Simflex\Core\Log;

class Checkout extends ComponentBase
{
    protected function content()
    {
        $req = Container::getRequest();
        if (!$req || !$req->isPost()) {
            header('HTTP/1.1 405 Method Not Allowed');
            exit;
        }

        $this->make();
    }

    protected function make(): void
    {
        $req = Container::getRequest();
        $cart = SessionAssist::$cart;
        $items = $cart ? (($cart->getProducts()['items'] ?? [])) : [];

        $this->logInfo('checkout.make.start', [
            'path' => '/checkout/make',
            'is_post' => $req ? (int)$req->isPost() : 0,
            'cart_exists' => (int)(bool)$cart,
            'cart_id' => $cart->cart_id ?? null,
            'items_raw' => is_array($items) ? count($items) : 0,
            'request_name' => trim((string)$req->request('name', '')),
            'request_phone' => trim((string)$req->request('phone', '')),
            'request_email' => trim((string)$req->request('email', '')),
        ]);

        if (!$cart) {
            $this->logInfo('checkout.make.fail', ['reason' => 'cart_not_found']);
            header('Location: /cart/');
            exit;
        }

        $cart->rebuildData();
        if (!$cart->getProductCount()) {
            $this->logInfo('checkout.make.fail', [
                'reason' => 'cart_empty_after_rebuild',
                'cart_id' => $cart->cart_id ?? null,
            ]);
            header('Location: /cart/');
            exit;
        }

        $guestUserId = $this->resolveGuestUserId();
        if (!$guestUserId) {
            $this->logInfo('checkout.make.fail', [
                'reason' => 'guest_user_id_not_found',
                'cart_id' => $cart->cart_id ?? null,
            ]);
            header('Location: /cart/');
            exit;
        }

        // ── Создание заказа ───────────────────────────────
        $order = Container::getFactory()->create(\App\Extensions\Catalog\Model\Order::class);
        $order->user_id = $guestUserId;
        $order->date = Time::create()->asMySQL();
        $order->status = \App\Extensions\Catalog\Model\Order::STATUS_PAY;
        $order->status_num = 0;

        $order->name = trim((string)$req->request('name', ''));
        $order->last_name = '';
        $order->phone = trim((string)$req->request('phone', ''));
        $order->email = trim((string)$req->request('email', ''));
        $order->org_name = trim((string)$req->request('org_name', ''));

        $order->transcomp_id = 1;
        $order->city = trim((string)$req->request('city', ''));
        $order->address = trim((string)$req->request('address', ''));
        $order->tracking = '';
        $order->sum_total = 0;
        $order->sum_actual = 0;
        $order->qty = 0;
        $order->discount = 0;
        $order->payment_id = 0;
        $order->delivery_sum = 0;

        // ── Предпочтительный способ связи ───────────────────────────────
        $callbackKey = trim($req->request('callback') ?? '');
        $callbackMap = [
            'tg' => 'Telegram',
            'wt' => 'WhatsApp',
            'mail' => 'Почта',
            'phone' => 'Позвоните',
        ];
        $callbackRawText = trim((string)$req->request('callback_text', ''));
        $callbackText = $callbackMap[$callbackKey] ?? ($callbackRawText !== '' ? $callbackRawText : 'Не указан');

        Container::getEvents()->dispatch(new Event('order_pre_save', self::class, $order, null));
        $this->logInfo('checkout.make.before_order_save', [
            'cart_id' => $cart->cart_id ?? null,
            'name' => $order->name,
            'phone' => $order->phone,
            'email' => $order->email,
            'city' => $order->city,
            'address' => $order->address,
            'transcomp_id' => (int)$order->transcomp_id,
            'resolved_user_id' => (int)$order->user_id,
        ]);
        if (!$order->save()) {
            $this->logInfo('checkout.make.fail_debug', [
                'reason' => 'order_save_failed_diagnostics',
                'order_model_errors' => $this->extractModelErrors($order),
                'db_error' => $this->extractDbError(),
            ]);
            $this->logInfo('checkout.make.fail', [
                'reason' => 'order_save_failed',
                'cart_id' => $cart->cart_id ?? null,
                'name' => $order->name,
                'phone' => $order->phone,
                'email' => $order->email,
            ]);
            header('Location: /cart/');
            exit;
        }
        $order->reload();
        Container::getEvents()->dispatch(new Event('order_post_save', self::class, $order, null));

        $added = 0;
        $cartItems = $cart->getProducts()['items'] ?? [];
        foreach ($cartItems as $pi) {
            /** @var Product $p */
            $p = $pi['product'];
            if (!$pi['qty'] || !$p->is_active) {
                $this->logInfo('checkout.item.skip', [
                    'reason' => !$pi['qty'] ? 'qty_empty' : 'product_inactive',
                    'product_id' => (int)$p->product_id,
                    'variant_id' => (int)($pi['variant_id'] ?? 0),
                    'qty' => (int)($pi['qty'] ?? 0),
                ]);
                $cart->removeProduct($p->product_id, $pi['variant_id'] ?? 0, false);
                continue;
            }

            $stock = null;
            if (!empty($pi['variant_id'])) {
                $var = new ProductVariant((int)$pi['variant_id']);
                $stock = $var->stock;
            } else {
                $stock = $p->stockData;
            }

            if (!$stock) {
                $this->logInfo('checkout.item.warn', [
                    'reason' => 'stock_not_found_continue_without_lock',
                    'product_id' => (int)$p->product_id,
                    'variant_id' => (int)($pi['variant_id'] ?? 0),
                    'qty' => (int)($pi['qty'] ?? 0),
                ]);
            }

            $priceOld = PriceAssist::getPrice((int)$p->product_id, null);
            $price = $priceOld - $priceOld * SaleAssist::getModFor((int)$p->product_id);

            $op = new OrderProduct();
            $op->order_id = $order->order_id;
            $op->product_id = $p->product_id;
            $op->variant_id = (int)($pi['variant_id'] ?? 0);
            $op->qty = (int)$pi['qty'];
            $op->sum = $pi['sum_actual'];
            $op->price = $price;
            $op->price_old = $priceOld;

            if (!$op->save()) {
                $this->logInfo('checkout.item.skip', [
                    'reason' => 'order_product_save_failed',
                    'order_id' => (int)$order->order_id,
                    'product_id' => (int)$p->product_id,
                    'variant_id' => (int)($pi['variant_id'] ?? 0),
                    'qty' => (int)($pi['qty'] ?? 0),
                ]);
                continue;
            }

            if ($stock) {
                $stock->lock($op->qty);
            } else {
                $this->logInfo('checkout.item.warn', [
                    'reason' => 'stock_lock_skipped',
                    'order_id' => (int)$order->order_id,
                    'product_id' => (int)$p->product_id,
                    'variant_id' => (int)($pi['variant_id'] ?? 0),
                    'qty' => (int)($pi['qty'] ?? 0),
                ]);
            }
            $added++;
        }

        $cart->rebuildData();
        if (!$cart->getProductCount() || !$added) {
            $this->logInfo('checkout.make.fail', [
                'reason' => 'cart_empty_or_no_items_added',
                'order_id' => (int)$order->order_id,
                'cart_id' => $cart->cart_id ?? null,
                'cart_product_count' => (int)$cart->getProductCount(),
                'added' => (int)$added,
                'items_before_loop' => is_array($cartItems) ? count($cartItems) : 0,
            ]);

            DB::query('delete from catalog_order_product where order_id = ?', [$order->order_id]);
            $order->delete();
            header('Location: /cart/');
            exit;
        }

        $this->logInfo('checkout.make.success', [
            'order_id' => (int)$order->order_id,
            'cart_id' => $cart->cart_id ?? null,
            'added' => (int)$added,
            'cart_product_count' => (int)$cart->getProductCount(),
        ]);

        $order->sum_total = $cart->__sum_total;
        $order->sum_actual = $cart->__sum_actual;
        $order->qty = $cart->getTotalOrderCount();
        $order->delivery_dates = $cart->delivery_dates;
        $order->delivery_sum = 0;
        $order->rebuildData();

        // ── Excel генерация заявки ───────────────────────────────
        $excelFile = ExcelGenerator::generateOrderExcel($order, $cart->getProducts()['items'] ?? [], $callbackText);

        // ── Отправка заявки на почту ─────────────────────────────
        (new MailAssist('form_email', 'Заказ №' . $order->order_id . ' создан'))
            ->tpl('email_order_pay.tpl', ['order' => $order, 'user' => null])
            ->send();

        // ── Отправка заявки в телеграм ───────────────────────────
        //todo: uncommit if tg is work again
//        $this->sendTelegram(
//            'Клиент: ' . $order->name . "\n"
//            . 'Номер телефона: ' . $this->formatPhoneForTelegram((string)$order->phone) . "\n"
//            . 'Почта: ' . $order->email . "\n"
//            . 'Способ связи: ' . $callbackText . "\n"
//            . 'Организация: ' . $order->org_name,
//            $order->order_id,
//            $order->sum_actual,
//            'НОВЫЙ ЗАКАЗ',
//            $excelFile
//        );

        DB::query('delete from catalog_cart_product where cart_id = ?', [$cart->cart_id]);

        header('Location: /user/order/success/');
        exit;
    }

    protected function sendTelegram($userInfo, $orderId, $sum, $type = 'НОВЫЙ ЗАКАЗ', $filePath = null): void
    {
        $message = "$type\n$userInfo\nID заявки: $orderId\nСумма заказа: "
            . number_format($this->normalizeMoney($sum), 2, '.', ' ')
            . " ₽";

        $botToken = Core::siteParam('form_tg_token');
        $chatId = Core::siteParam('form_tg_chat_id');
        if (!$botToken || !$chatId) {
            return;
        }

        $url = "https://api.telegram.org/bot{$botToken}/sendMessage";
        $postFields = [
            'chat_id' => $chatId,
            'text' => $message,
        ];

        if ($filePath && file_exists($filePath)) {
            $url = "https://api.telegram.org/bot{$botToken}/sendDocument";
            $postFields['caption'] = $message;
            $postFields['document'] = new \CURLFile(
                $filePath,
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                'zakaz_' . $orderId . '.xlsx'
            );
        }

        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postFields);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_exec($ch);
        curl_close($ch);

        if ($filePath && file_exists($filePath)) {
            @unlink($filePath);
        }
    }

    private function logInfo(string $event, array $context = []): void
    {
        $payload = $event;
        if ($context) {
            $json = json_encode($context, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            $payload .= ' ' . ($json !== false ? $json : '[context_encode_failed]');
        }

        Log::info($payload);
    }

    private function extractModelErrors(object $model): string
    {
        $variants = [];
        foreach (['getErrors', 'errors', 'getError', 'error'] as $method) {
            if (method_exists($model, $method)) {
                try {
                    $val = $model->{$method}();
                    $variants[$method] = $val;
                } catch (\Throwable $e) {
                    $variants[$method] = 'exception:' . $e->getMessage();
                }
            }
        }

        if (!$variants) {
            return 'no_model_error_api';
        }

        $json = json_encode($variants, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        return $json !== false ? $json : 'model_error_json_encode_failed';
    }

    private function extractDbError(): string
    {
        $variants = [];
        foreach (['lastError', 'error', 'getError'] as $method) {
            if (method_exists(DB::class, $method)) {
                try {
                    $val = DB::{$method}();
                    $variants[$method] = $val;
                } catch (\Throwable $e) {
                    $variants[$method] = 'exception:' . $e->getMessage();
                }
            }
        }

        if (!$variants) {
            return 'no_db_error_api';
        }

        $json = json_encode($variants, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        return $json !== false ? $json : 'db_error_json_encode_failed';
    }

    private function resolveGuestUserId(): ?int
    {
        $candidates = [
            'select user_id from user where active = 1 and role_id = 3 order by user_id asc limit 1',
            'select user_id from user where active = 1 order by user_id asc limit 1',
            'select user_id from user order by user_id asc limit 1',
        ];

        foreach ($candidates as $sql) {
            try {
                $q = DB::query($sql);
                $row = DB::fetch($q);
                if (!empty($row['user_id'])) {
                    return (int)$row['user_id'];
                }
            } catch (\Throwable $e) {
                $this->logInfo('checkout.make.guest_user_lookup_error', [
                    'sql' => $sql,
                    'message' => $e->getMessage(),
                ]);
            }
        }

        return null;
    }

    private function normalizeMoney($value): float
    {
        if (is_int($value) || is_float($value)) {
            return (float)$value;
        }

        $raw = (string)$value;
        $raw = str_replace(["\xc2\xa0", ' '], '', $raw);
        $raw = str_replace(',', '.', $raw);
        $raw = preg_replace('/[^0-9.\-]/', '', $raw) ?? '';
        if ($raw === '' || $raw === '-' || $raw === '.') {
            return 0.0;
        }

        return (float)$raw;
    }

    private function formatPhoneForTelegram(string $phone): string
    {
        $digits = preg_replace('/\D+/', '', $phone) ?? '';
        if ($digits === '') {
            return '8';
        }

        if ($digits[0] !== '8') {
            $digits = '8' . $digits;
        }

        return $digits;
    }
}
