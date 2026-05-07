<?php
namespace App\Extensions\Catalog\Social;

use Simflex\Core\Session;

class Vk extends SocialBase
{
    protected static $apiUrl = 'https://api.vk.com/method';
    protected static $oauthUrl = 'https://oauth.vk.com/authorize';
    protected static $oauthCompleteUrl = 'https://oauth.vk.com/access_token';
    protected static $returnId = 'vk';

    public function beginOAuth(array $data = [], array $scopes = [])
    {
        parent::beginOAuth([
            'client_id' => env('VK_CLIENT_ID'),
            'display' => 'page',
            'scope' => implode(',', $scopes ?: ['email']),
        ]);
    }

    protected function completeOAuth(array $data = []): array
    {
        return parent::completeOAuth([
            'client_id' => env('VK_CLIENT_ID'),
            'client_secret' => env('VK_CLIENT_SECRET'),
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
        if (isset($ret['error']) || !isset($ret['email'])) {
            var_dump('complete error or no email', $ret);
            return ['id' => 0];
        }

        $this->token = $ret['access_token'];
        $out = [
            'id' => 0,
            'email' => $ret['email'],
            'name' => '',
            'first_name' => '',
            'last_name' => '',
        ];

        $data = $this->apiRequest('/account.getProfileInfo', ['v' => '5.150'], false, function ($ch) {
            curl_setopt($ch, CURLOPT_HTTPHEADER, ['Authorization: Bearer ' . $this->token]);
        });

        if (!isset($data['response'])) {
            var_dump('no response', $data);
            return ['id' => 0];
        }

        $out['token'] = $this->token;
        $out['id'] = $data['response']['id'];
        $out['name'] = $data['response']['screen_name'] ?? $data['response']['first_name'];
        $out['first_name'] = $data['response']['first_name'];
        $out['last_name'] = $data['response']['last_name'];
        return $out;
    }
}