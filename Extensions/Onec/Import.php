<?php
namespace App\Extensions\Onec;

class Import
{
    /** @var callable */
    protected $logger;

    public function __construct(?callable $logger = null)
    {
        $this->logger = $logger ?? static function (string $msg, bool $isError = false): void {};
    }

    protected function log(string $msg, bool $isError = false): void
    {
        ($this->logger)($msg, $isError);
    }

    protected function getOnecUrl(): string
    {
        $url = getenv('ONEC_URL') ?: '';
        if ($url === '') {
            $url = $this->readEnvValue('ONEC_URL') ?? '';
        }
        if ($url === '') {
            throw new \RuntimeException('ONEC_URL не задан в .env');
        }
        return $url;
    }

    protected function readEnvValue(string $key): ?string
    {
        $envPath = dirname(__DIR__, 2) . '/.env';
        if (!file_exists($envPath)) {
            return null;
        }

        $lines = file($envPath, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        if ($lines === false) {
            return null;
        }

        foreach ($lines as $line) {
            $line = trim($line);
            if ($line === '' || str_starts_with($line, '#')) {
                continue;
            }
            if (!str_contains($line, '=')) {
                continue;
            }
            [$k, $v] = explode('=', $line, 2);
            if (trim($k) === $key) {
                return trim($v);
            }
        }

        return null;
    }

    protected function fetchOnec(string $method): string
    {
        $payload = json_encode([
            'jsonrpc' => '2.0',
            'method' => $method,
            'params' => (object)[],
            'id' => '0',
        ], JSON_UNESCAPED_UNICODE);

        $ch = curl_init($this->getOnecUrl());
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
        curl_setopt($ch, CURLOPT_TIMEOUT, 300);

        $response = curl_exec($ch);
        if ($response === false) {
            $err = curl_error($ch);
            curl_close($ch);
            throw new \RuntimeException('Ошибка CURL: ' . $err);
        }
        $code = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($code < 200 || $code >= 300) {
            throw new \RuntimeException('HTTP ошибка: ' . $code);
        }

        return $response;
    }

    protected function saveOnecResponse(string $filename, string $raw): string
    {
        $path = __DIR__ . '/storage/' . $filename;
        if (@file_put_contents($path, $raw, LOCK_EX) === false) {
            throw new \RuntimeException('Не удалось записать файл: ' . $path);
        }
        return $path;
    }

    public function pullAndImportAll(array $steps): void
    {
        $this->log('=== СТАРТ PULL+IMPORT 1С ===');

        try {
            foreach ($steps as $step) {
                $method = $step['method'] ?? '';
                $file = $step['file'] ?? '';
                $import = $step['import'] ?? null;

                if ($method === '' || $file === '' || !is_callable($import)) {
                    throw new \RuntimeException('Некорректное описание шага импорта');
                }

                $this->log('--- PULL ' . $method . ' ---');
                $raw = $this->fetchOnec($method);
                $filePath = $this->saveOnecResponse($file, $raw);

                $this->log('--- IMPORT ' . $method . ' ---');
                $import($filePath);
            }

            $this->log('=== PULL+IMPORT 1С ЗАВЕРШЕН ===');
        } catch (\Throwable $e) {
            $this->log('ОШИБКА PULL+IMPORT: ' . $e->getMessage(), true);
            throw $e;
        }
    }
}
