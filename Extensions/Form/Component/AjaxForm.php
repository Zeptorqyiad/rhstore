<?php

namespace App\Extensions\Form\Component;

use App\Extensions\Catalog\MailAssist;

//use App\Plugins\ReCaptcha\ReCaptcha;
use Simflex\Core\ComponentBase;
use Simflex\Core\Container;
use Simflex\Core\Core;
use Simflex\Core\DB;
use Exception;

use Simflex\Core\Time;

use function Sodium\compare;

class AjaxForm extends ComponentBase
{
    protected $errors = [];
    protected $data = [];

    private function getParam(string $name): string
    {
        if (isset($_GET[$name]) && $_GET[$name] !== '') return $_GET[$name];
        if (isset($_POST[$name]) && $_POST[$name] !== '') return $_POST[$name];
        if (isset($_REQUEST[$name]) && $_REQUEST[$name] !== '') return $_REQUEST[$name];
        if (isset($_COOKIE[$name]) && $_COOKIE[$name] !== '') return $_COOKIE[$name];
        return '';
    }

    protected function content()
    {
        $name = $_REQUEST['name'] ?? '';
        $email = $_REQUEST['email'] ?? '';

        $phoneRaw = $_REQUEST['phone_full'] ?? $_REQUEST['phone'] ?? '';
        if (is_array($phoneRaw)) {
            $phoneRaw = $phoneRaw[0] ?? '';
        }
        $phone = $phoneRaw;

        $clearance = implode(', ', $_REQUEST['clearance'] ?? []);
        $coverage = implode(', ', $_REQUEST['coverage'] ?? []);
        $conversion = implode(', ', $_REQUEST['conversion'] ?? []);
        $loyalty = implode(', ', $_REQUEST['loyalty'] ?? []);
        $bonuses = implode(', ', $_REQUEST['bonuses'] ?? []);

        $from = $_REQUEST['from'] ?? '';
        $fromTitle = $_REQUEST['from_title'] ?? '';
        $formType = $_REQUEST['form_type'] ?? '';
        $date = Time::create()->asMySQL();

        $this->data = compact(
            'name',
            'clearance',
            'coverage',
            'conversion',
            'loyalty',
            'bonuses',
            'date',
            'from',
            'fromTitle',
            'email',
            'formType'
        );
        $this->data['phone'] = $phone;

        $message = <<<MSG
Оформление товаров: {$this->data['clearance']}
Повышение охвата: {$this->data['coverage']}
Повышение конверсии: {$this->data['conversion']}
Лояльность аудитории: {$this->data['loyalty']}
Бонусы: {$this->data['bonuses']}
MSG;

        DB::query(
            'INSERT INTO callback (name, phone, message, date) VALUES (?, ?, ?, ?)',
            [$name, $phone, $message, $date]
        );

        DB::query(
            'insert into callback_email (email, is_subscribed) select ?, 1 where not exists(select 1 from callback_email where email = ?)',
            [$email, $email]
        );

        if (!empty($phone)) {
            try {
                $this->sendToCRM($phone, $fromTitle ?: 'Сайт');
            } catch (\Throwable $e) {
                error_log('amoCRM integration error: ' . $e->getMessage());
            }
        }

        exit(json_encode(['success' => $this->sendMail() || $this->sendTelegram(), 'errors' => $this->errors]));
    }


    protected function sendMail()
    {
        $m = new MailAssist(Core::siteParam('form_email'), 'Новая заявка с сайта');

        $fileData = $_FILES['file'] ?? '';
        if ($fileData && $fileData['error'] == UPLOAD_ERR_OK) {
            $m->file($fileData['tmp_name'], $fileData['name']);
            $fileData = <<<HTML
<br/><p><b>Файл прикреплен к этому сообщению</b></p>
HTML;
        } else {
            $fileData = '';
        }

        if ($this->data['formType'] == 'checklist') {
            $html = <<<HTML
<p><b>Страница: </b> <a href="{$this->data['from']}">{$this->data['fromTitle']}</a></p>
<p></p>
<p><b>Имя: </b> {$this->data['name']}, {$this->data['phone']}, {$this->data['email']}</p>
<p><b>Оформление товаров: </b>{$this->data['clearance']}</p>
<p><b>Повышение охвата: </b>{$this->data['coverage']}</p>
<p><b>Повышение конверсии: </b>{$this->data['conversion']}</p>
<p><b>Лояльность аудитории: </b>{$this->data['loyalty']}</p>
<p><b>Бонусы: </b>{$this->data['bonuses']}</p>
<p></p>

$fileData
HTML;
        } else {
            $html = <<<HTML
<p><b>Страница: </b> <a href="{$this->data['from']}">{$this->data['fromTitle']}</a></p>
<p></p>
<p><b>Имя: </b> {$this->data['name']}</p>
<p><b>Телефон: </b> {$this->data['phone']}</p>
<p><b>Email: </b> {$this->data['email']}</p>
<p></p>

$fileData
HTML;
        }

        $m->content($html);
        return $m->send();
    }

    protected function sendTelegram()
    {
        //todo: rm "return true" if tg is work again
        return true;

        $patch = function ($i) {
            return str_replace(
                ['_', '*', '[', ']', '(', ')', '~', '`', '>', '#', '+', '-', '=', '|', '{', '}', '.', '!'],
                [
                    '\\_',
                    '\\*',
                    '\\[',
                    '\\]',
                    '\\(',
                    '\\)',
                    '\\~',
                    '\\`',
                    '\\>',
                    '\\#',
                    '\\+',
                    '\\-',
                    '\\=',
                    '\\|',
                    '\\{',
                    '\\}',
                    '\\.',
                    '\\!'
                ],
                $i
            );
        };

        if ($this->data['formType'] == 'checklist') {
            $md = <<<MD
**НОВАЯ ЗАЯВКА**

**Страница: ** [{$patch($this->data['fromTitle'])}]({$patch($this->data['from'])})

**Имя: ** {$patch($this->data['name'])}, {$patch($this->data['phone'])}, {$patch($this->data['email'])}
**Оформление товаров:** {$patch($this->data['clearance'])}
**Повышение охвата:** {$patch($this->data['coverage'])}
**Повышение конверсии:** {$patch($this->data['conversion'])}
**Лояльность аудитории:** {$patch($this->data['loyalty'])}
**Бонусы:** {$patch($this->data['bonuses'])}

MD;
        } else {
            $utm_source = $this->getParam('utm_source');
            $utm_medium = $this->getParam('utm_medium');
            $utm_campaign = $this->getParam('utm_campaign');
            $utm_term = $this->getParam('utm_term');
            $utm_content = $this->getParam('utm_content');
            $roistat = $this->getParam('roistat_visit') ?: ($this->getParam('roistat_marker') ?? '');

            $utm_lines = '';
            if ($utm_source)   $utm_lines .= "*UTM_SOURCE:* {$patch($utm_source)}\n";
            if ($utm_medium)   $utm_lines .= "*UTM_MEDIUM:* {$patch($utm_medium)}\n";
            if ($utm_campaign) $utm_lines .= "*UTM_CAMPAIGN:* {$patch($utm_campaign)}\n";
            if ($utm_term)     $utm_lines .= "*UTM_TERM:* {$patch($utm_term)}\n";
            if ($utm_content)  $utm_lines .= "*UTM_CONTENT:* {$patch($utm_content)}\n";
            if ($roistat)      $utm_lines .= "*ROISTAT:* {$patch($roistat)}\n";

            $md = <<<MD
**НОВАЯ ЗАЯВКА**

**Страница: ** [{$patch($this->data['fromTitle'])}]({$patch($this->data['from'])})

**Имя: ** {$patch($this->data['name'])}
**Телефон: ** {$patch($this->data['phone'])}
**Email: ** {$patch($this->data['email'])}

{$utm_lines}

MD;
        }

        $ch = curl_init();

        curl_setopt(
            $ch,
            CURLOPT_URL,
            'https://api.telegram.org/bot' . Core::siteParam('form_tg_token') . '/sendMessage'
        );
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query([
            'chat_id' => Core::siteParam('form_tg_chat_id'),
            'parse_mode' => 'MarkdownV2',
            'text' => $md
        ]));

        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $error = curl_error($ch);

        if ($httpCode !== 200 || $error) {
            error_log("Telegram send error: HTTP $httpCode | curl error: $error | Response: $response");
        }

        curl_close($ch);

        return true;
    }

    protected function sendToCRM(string $phone, string $pageTitle): void
    {
         $cleanPhone = preg_replace('/\D/', '', $phone);
         if (strlen($cleanPhone) < 10) return;

         try {
             $amo = new \App\Extensions\Form\Component\AmoCRMService();
             $amo->createLeadFromForm($phone, $pageTitle);
         } catch (\Throwable $e) {
             error_log('amoCRM error: ' . $e->getMessage());
         }

        error_log("CRM integration called for phone: $phone");
    }
}