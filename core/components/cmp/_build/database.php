<?php

/**
 * Database Builder
 *
 * Copyright 2026 by Jens Wittmann <kontakt@jens-wittmann.de>
 *
 * @package cmp
 */

use CMP\Database;

// init MODX CLI
define('MODX_API_MODE', true);
@include(dirname(__FILE__, 5) . '/index.php');

// define paths
$projectRootDir = MODX_BASE_PATH . '';
$corePath = $projectRootDir . 'core/components/cmp/';
$schemaFile = $corePath . 'schema/cmp.mysql.schema.xml';

// get manager and generator
$manager = $modx->getManager();
$generator = $manager->getGenerator();

// generate classes
$generator->parseSchema(
    $schemaFile,
    $corePath . 'src/',
    [
        "compile" => 0,
        "update" => 0,
        "regenerate" => 1,
        "namespacePrefix" => "CMP\\Database\\"
    ]
);

// drop and create tables
foreach (
    [
        'CMP\Database\Model\Sample',
    ] as $class
) {
    $manager->removeObjectContainer($class);
    $manager->createObjectContainer($class);
}
