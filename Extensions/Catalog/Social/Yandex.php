<?php
namespace App\Extensions\Catalog\Social;

use Simflex\Core\Session;

class Yandex extends SocialBase
{
    protected static $apiUrl = 'https://login.yandex.ru';
    protected static $oauthUrl = 'https://oauth.yandex.ru/authorize';
    protected static $oauthCompleteUrl = 'https://oauth.yandex.ru/token';
    protected static $returnId = 'yandex';

    public function beginOAuth(array $data = [], array $scopes = [])
    {
        parent::beginOAuth([
            'client_id' => env('YD_CLIENT_ID'),
        ]);
    }

    protected function completeOAuth(array $data = []): array
    {
        return parent::completeOAuth([
            'client_id' => env('YD_CLIENT_ID'),
            'client_secret' => env('YD_CLIENT_SECRET'),
            'grant_type' => 'authorization_code',
            'code' => $data['code'],
        ]);
    }

    public function handleResponse(): array
    {
        if (isset($_REQUEST['error'])) {
            var_dump('err ' . $_REQUEST['error']);
            return ['id' => 0];
        }

        // check state
        if ($_REQUEST['state'] != Session::get('oauth_state')) {
            var_dump('wrong state ' . $_REQUEST['state'] . ' != ' . Session::get('oauth_state'));
            return ['id' => 0];
        }

        // go!
        $ret = $this->completeOAuth(['code' => $_REQUEST['code']]);
        if (isset($ret['error'])) {
            var_dump('complete error or no email', $ret);
            return ['id' => 0];
        }

        $this->token = $ret['access_token'];
        $out = [
            'id' => 0,
            'email' => '',
            'name' => '',
            'first_name' => '',
            'last_name' => '',
        ];

        $data = $this->apiRequest('/info', ['format' => 'json'], false, function ($ch) {
            curl_setopt($ch, CURLOPT_HTTPHEADER, ['Authorization: OAuth ' . $this->token]);
        });

        if (!isset($data['id'])) {
            var_dump('no response', $data);
            return ['id' => 0];
        }

        $out['id'] = $data['id'];
        $out['email'] = $data['default_email'];
        $out['name'] = $data['login'];
        $out['first_name'] = $data['first_name'];
        $out['last_name'] = $data['last_name'];

        return $out;
    }
}