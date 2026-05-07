<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/vendor/autoload.php';

use AmoCRM\Client\AmoCRMApiClient;

$clientId = 'cb47840e-34f1-49be-ab69-91421b4130ab';
$clientSecret = '0DNP2Ycaw6VsmPIWZjO02o8Or9fBVXFdnNKjiYFLu7hhH4TibDFI3EKOVDXpZlhj';
$redirectUri = 'https://rhstore.net/amocrm/oauth.php';

$apiClient = new AmoCRMApiClient($clientId, $clientSecret, $redirectUri);

if (isset($_GET['referer'])) {
    $apiClient->setAccountBaseDomain($_GET['referer']);
}

if (isset($_GET['code'])) {
    try {
        $accessToken = $apiClient->getOAuthClient()->getAccessTokenByCode($_GET['code']);

        file_put_contents(__DIR__ . '/token.json', json_encode($accessToken->jsonSerialize(), JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));

        echo "<h2>✅ Авторизация успешна!</h2>";
        echo "<p>Токены сохранены в <b>amocrm/token.json</b></p>";
        echo "<p>Субдомен: <b>" . $apiClient->getAccountBaseDomain() . "</b></p>";
        echo "<pre>" . print_r($accessToken->jsonSerialize(), true) . "</pre>";
    } catch (Exception $e) {
        echo "<h2>Ошибка при обмене кода:</h2><pre>" . $e->getMessage() . "</pre>";
    }
} else {
    $authorizationUrl = $apiClient->getOAuthClient()->getAuthorizeUrl([
        'state' => 'test_state_123',
        'mode' => 'post_message',
    ]);

    echo "<h2>Интеграция amoCRM</h2>";
    echo '<p><a href="' . htmlspecialchars($authorizationUrl) . '" target="_blank" style="display:inline-block; padding:15px 30px; background:#FF3838; color:white; font-size:18px; text-decoration:none; border-radius:8px;">Нажми сюда — войти в amoCRM и разрешить доступ</a></p>';
    echo "<p>Если после подтверждения увидишь 'космос' — просто закрой вкладку и вернись сюда вручную.</p>";
}