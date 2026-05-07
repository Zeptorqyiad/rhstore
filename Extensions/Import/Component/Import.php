<?php

namespace App\Extensions\Import\Component;

use App\Extensions\Import\Mapper;
use App\Extensions\Import\Parser\Bitrix;
use Simflex\Core\ComponentBase;
use Simflex\Core\Core;
use Simflex\Core\Log;
use Simflex\Core\Request;

class Import extends ComponentBase
{
    public function __construct(protected Request $request)
    {
        parent::__construct();
    }

    protected function runFile(string $filename): string
    {
        if (str_ends_with($filename, '.xml')) {
            $content = file_get_contents('php://input');
            file_put_contents($_SERVER['DOCUMENT_ROOT'] . '/uf/files/' . time() . '_' . $filename, $content);

            $parser = new Bitrix();
            $data = $parser->parse(file_get_contents('php://input'));
            $mp = new Mapper();
            $mapped = $mp->map($data);
            $imp = new \App\Extensions\Import\Import($parser);
            $imp->import($mapped);
        } else {
            $filename = '/uf/files/' . $filename;
            $check_path = [];
            $path = explode('/', $filename);
            for ($i = 0; $i < count($path) - 1; $i++) {
                $sub_path = $_SERVER['DOCUMENT_ROOT'] . (implode('/', $check_path) . '/' . $path[$i]);
                if (!file_exists($sub_path)) {
                    mkdir($sub_path);
                }
                $check_path[] = $path[$i];
            }

            file_put_contents($_SERVER['DOCUMENT_ROOT'] . $filename, file_get_contents('php://input'));
        }

        return 'success';
    }

    protected function content()
    {
        // TODO: make this support multiple parsers, currently only supports 1C

        $auth = $this->request->header('authorization');
        if (!$auth) {
            $pAuthUser = $_SERVER['PHP_AUTH_USER'] ?? '';
            $pAuthPw = $_SERVER['PHP_AUTH_PW'] ?? '';

            if (!$pAuthPw && !$pAuthUser) {
                Log::error('no auth');
                Log::info(
                    'request: {r}, headers: {h}',
                    ['r' => $this->request->request(), 'h' => $this->request->header()]
                );
                Log::info('pauth: {a} {b}', ['a' => $pAuthUser, 'b' => $pAuthPw]);
                exit('failure (no auth)');
            }

            $auth = [$pAuthUser, $pAuthPw];
        }

        if (!is_array($auth)) {
            $auth = str_replace('Basic ', '', $auth);
            $auth = explode(':', base64_decode($auth));
        }

        $sUsername = Core::siteParam('1c_username');
        $sPassword = Core::siteParam('1c_password');

        if ($sUsername != $auth[0] || $sPassword != $auth[1]) {
            Log::error('wrong pw (sent: {a}, {b})', ['a' => $auth[0], 'b' => $auth[1]]);
            exit('failure (wrong credentials)');
        }

        $data = $this->request->request();
        if (!isset($data['type']) || !isset($data['mode'])) {
            Log::error('unknown request');
            exit('failure (unsupported mode)');
        }

        if ($data['type'] != 'catalog') {
            Log::error('attempting to send unsupported type {type}', ['type' => $data['type']]);
            exit('failure (unsupported type)');
        }

        Log::info('incoming import ({f})', ['f' => $data['filename'] ?? '']);

        switch ($data['mode']) {
            case 'success':
            case 'complete':
            case 'checkauth':
                exit('success');
            case 'init':
                exit(
                implode("\n", [
                    'zip=no',
                    'file_limit=8000000',
                    'token=a',
                    '3.1'
                ])
                );
            case 'file':
            case 'import':
                exit($this->runFile($data['filename']));
            default:
                Log::error('unknown mode {mode}', ['mode' => $data['mode']]);
                break;
        }
    }
}