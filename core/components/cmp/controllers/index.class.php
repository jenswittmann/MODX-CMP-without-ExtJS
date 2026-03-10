<?php

/**
 * CMP
 *
 * Copyright 2026 by Jens Wittmann <kontakt@jens-wittmann.de>
 */

use modX;
use ModxPro\PdoTools\CoreTools;
use CMP\Database;

class CmpIndexManagerController extends modExtraManagerController
{
    /**
     * CMP names
     */
    public $title = 'CMP Sample';
    public $namespace = 'cmp';

    /**
     * pdoTools instance
     * @var pdoTools $pdo
     */
    public $pdo;

    /**
     * Database instance
     * @var Database $database
     */
    public $database;

    /**
     * Can be used to provide custom methods prior to processing
     *
     * @return void
     */
    public function initialize()
    {
        $elementsPath = $this->modx->getOption('core_path') . 'components/' . $this->namespace . '/elements/chunks/';
        $this->modx->setOption('pdotools_elements_path', $elementsPath);
        $this->pdo = $this->modx->services->get(CoreTools::class);
        $this->database = $this->modx->services->get(Database::class);
    }

    public function getPageTitle()
    {
        return $this->title;
    }

    public function process(array $scriptProperties = [])
    {
        $view = $this->scriptProperties['view'] ?: 'index';

        $this->database->backend($this->scriptProperties);

        return $this->pdo->getChunk('@FILE ' . $view . '.chunk.tpl', [
            'title' => $this->title,
            'namespace' => $this->namespace
        ]);
    }
}
