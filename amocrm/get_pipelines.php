<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/vendor/autoload.php';

use AmoCRM\Client\AmoCRMApiClient;
use League\OAuth2\Client\Token\AccessToken;

$clientId = 'cb47840e-34f1-49be-ab69-91421b4130ab';
$clientSecret = '0DNP2Ycaw6VsmPIWZjO02o8Or9fBVXFdnNKjiYFLu7hhH4TibDFI3EKOVDXpZlhj';
$redirectUri = 'https://rhstore.ru/amocrm/oauth.php';

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
    $pipelinesService = $apiClient->pipelines();
    $pipelines = $pipelinesService->get();

    echo "<pre>";
    foreach ($pipelines as $pipeline) {
        echo "Воронка: " . $pipeline->getName() . " (pipeline_id: " . $pipeline->getId() . ")\n";

        $statuses = $pipeline->getStatuses();
        if ($statuses) {
            foreach ($statuses as $status) {
                echo "  - Этап: " . $status->getName() . " (status_id: " . $status->getId() . ")\n";
            }
        }
        echo "\n";
    }
    echo "</pre>";
} catch (Exception $e) {
    echo "<h2>Ошибка:</h2><pre>" . $e->getMessage() . "\n" . $e->getTraceAsString() . "</pre>";
}