<?php

require_once __DIR__ . '/vendor/glushkovds/simflex/src/constants.php';

define('SF_ROOT_PATH', __DIR__);

const SF_LOCATION = SF_LOCATION_ADMIN;

require_once __DIR__ . '/Core/Init.php';

$core = Init::_();

$uploadDir = SF_ROOT_PATH . '/uf';

$mgr = new \Simflex\FileManager\Manager($uploadDir, function () {
    return !!\Simflex\Core\Container::getUser();
});

$mgr->handleRequest();