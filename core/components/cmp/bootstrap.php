<?php

/**
 * Bootstrap module
 *
 * @package cmp
 *
 * @var \MODX\Revolution\modX $modx
 * @var array $namespace
 */

use CMP\Database;

require_once $namespace["path"] . 'vendor/autoload.php';

$modx->addPackage(Database::class . '\Model', $namespace['path'] . 'src/', null, Database::class);

$modx->services->add(Database::class, function ($c) use ($modx) {
    return new Database($modx);
});
