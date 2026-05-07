<?php

namespace App\Extensions\Onec\api;

use Simflex\Core\Request;
use Simflex\Core\Response;
use Simflex\Core\ComponentBase;

class SyncEndpoint extends ComponentBase
{
    protected function content()
    {
        if (Request::method() !== 'POST') {
            Response::json(['error' => 'Method not allowed'], 405);
            return;
        }

        $raw = file_get_contents('php://input');
        $data = json_decode($raw, true);

        if (!$data || !isset($data['jsonrpc']) || $data['jsonrpc'] !== '2.0' || empty($data['method'])) {
            Response::json(['error' => 'Invalid JSON-RPC request'], 400);
            return;
        }

        $method = $data['method'];
        $params = $data['params'] ?? null;
        $id = $data['id'] ?? null;

        $result = null;
        $error = null;

        try {
            switch ($method) {
                case 'Products':
                    // сохраняем в файл или сразу импортируем
                    file_put_contents(__DIR__ . '/products_' . date('YmdHis') . '.json', $raw);
                    // или сразу: (new ProductImporter())->import($params['items'] ?? []);
                    $result = ['status' => 'accepted', 'method' => $method];
                    break;

                case 'ProductPrices':
                    file_put_contents(__DIR__ . '/prices_' . date('YmdHis') . '.json', $raw);
                    $result = ['status' => 'accepted'];
                    break;

                case 'Categories':
                case 'Остатки':
                case 'PriceLevels':
                    $result = ['status' => 'accepted'];
                    break;

                default:
                    $error = ['code' => -32601, 'message' => 'Method not found'];
            }
        } catch (\Throwable $e) {
            $error = ['code' => -32000, 'message' => $e->getMessage()];
        }

        $response = [
            'jsonrpc' => '2.0',
            'id' => $id,
        ];

        if ($error) {
            $response['error'] = $error;
        } else {
            $response['result'] = $result;
        }

        Response::json($response);
    }
}
