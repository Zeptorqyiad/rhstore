<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/vendor/autoload.php';

use AmoCRM\Client\AmoCRMApiClient;
use League\OAuth2\Client\Token\AccessToken;
use AmoCRM\Helpers\EntityTypesInterface;

$clientId = 'cb47840e-34f1-49be-ab69-91421b4130ab';
$clientSecret = '0DNP2Ycaw6VsmPIWZjO02o8Or9fBVXFdnNKjiYFLu7hhH4TibDFI3EKOVDXpZlhj';
$redirectUri = 'https://rhstore.net/amocrm/oauth.php';

$apiClient = new AmoCRMApiClient($clientId, $clientSecret, $redirectUri);
$apiClient->setAccountBaseDomain('grhino.amocrm.ru');

$tokenFile = __DIR__ . '/token.json';
if (file_exists($tokenFile)) {
    $tokenData = json_decode(file_get_contents($tokenFile), true);
    $accessToken = new AccessToken($tokenData);
    $apiClient->setAccessToken($accessToken)
        ->onAccessTokenRefresh(function (AccessToken $accessToken, $baseDomain) use ($tokenFile) {
            file_put_contents($tokenFile, json_encode($accessToken->jsonSerialize()));
        });
}

try {
    echo "<h2>Кастомные поля в Сделках (Leads)</h2>";
    $customFields = $apiClient->customFields(EntityTypesInterface::LEADS)->get();

    echo "<table border='1' cellpadding='5'><tr><th>ID поля</th><th>Название</th><th>Тип</th><th>Варианты</th></tr>";
    foreach ($customFields as $field) {
        $name = $field->getName();
        $id = $field->getId();
        $type = substr(strrchr(get_class($field), '\\'), 1);

        $enums = '';
        if (method_exists($field, 'getEnums') && $field->getEnums()) {
            foreach ($field->getEnums() as $enum) {
                $enums .= $enum->getValue() . " (ID: " . $enum->getId() . ")<br>";
            }
        }

        // Подсвечиваем поле "Источник"
        $style = (mb_stripos($name, 'источник') !== false) ? 'style="background: yellow; font-weight: bold;"' : '';

        echo "<tr $style><td>$id</td><td>$name</td><td>$type</td><td>$enums</td></tr>";
    }
    echo "</table>";

} catch (Exception $e) {
    echo "<pre>Ошибка: " . $e->getMessage() . "\n" . $e->getTraceAsString() . "</pre>";
}
?>