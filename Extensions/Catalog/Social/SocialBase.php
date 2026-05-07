<?php
namespace App\Extensions\Catalog\Social;

use App\Extensions\Catalog\SessionAssist;
use Simflex\Core\Core;
use Simflex\Core\Helpers\Str;
use Simflex\Core\Session;

abstract class SocialBase
{
    protected static $apiUrl;
    protected static $oauthUrl;
    protected static $oauthCompleteUrl;
    protected static $returnId;

    protected string $token = '';

    public function beginOAuth(array $data = [], array $scopes = [])
    {
        Session::set('oauth_state', Str::random(32));
        $url = static::$oauthUrl . '?' . http_build_query(array_merge([
            'redirect_uri' => url('/auth/return/' . static::$returnId . '/'),
            'response_type' => 'code',
            'state' =>  Session::get('oauth_state'),
        ], $data));

        header('Location: ' . $url);
        exit;
    }

    protected function completeOAuth(array $data = []): array
    {
        $ch = curl_init();
        $q = http_build_query(array_merge($data, [
            'redirect_uri' => url('/auth/return/' . static::$returnId . '/'),
        ]));

        curl_setopt($ch,CURLOPT_URL, static::$oauthCompleteUrl);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $q);
        curl_setopt($ch,CURLOPT_RETURNTRANSFER, true);
        $ret = curl_exec($ch);
        var_dump(curl_error($ch), curl_errno($ch));
        curl_close($ch);

        var_dump($ret, static::$oauthCompleteUrl);
        return json_decode($ret, true) ?: ['error' => 'rip'];
    }

    public abstract function handleResponse(): array;

    protected function apiRequest(string $url, array $data, bool $isPost = false, $setupFn = null): array
    {
        $ch = curl_init();
        $q = http_build_query($data);

        if (!$isPost) {
            $url .= '?' . $q;
        }

        curl_setopt($ch,CURLOPT_URL, static::$apiUrl . $url);

        if ($isPost) {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $q);
        }

        if ($setupFn) {
            $setupFn($ch);
        }

        curl_setopt($ch,CURLOPT_RETURNTRANSFER, true);
        $ret = curl_exec($ch);
        curl_close($ch);

        return json_decode($ret, true) ?: [];
    }
}