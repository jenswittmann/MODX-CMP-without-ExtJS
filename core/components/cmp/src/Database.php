<?php

/**
 * CMP Database
 *
 * Copyright 2026 by Jens Wittmann <kontakt@jens-wittmann.de>
 *
 * @package cmp
 */

namespace CMP;

use modX;
use xPDO;
use xPDO\Om\mysql\xPDOQuery;

/**
 * Class Database
 */
class Database
{
    /**
     * MODX instance
     * @var modX $modx
     */
    public $modx;

    /**
     * pdoTools instance
     * @var pdoTools $pdo
     */
    public $pdo;

    /**
     * Namespace
     * @var string $namespace
     */
    public $namespace = 'cmp';

    /**
     * Script Properties
     * @var array $scriptProperties
     */
    public $scriptProperties = [];

    /**
     * Constructor
     *
     * Initializes the Shop class with MODX instance and pdoTools service.
     *
     * @param modX $modx A reference to the modX instance.
     * @param array $options An array of options. Optional.
     */
    public function __construct($modx, $options = [])
    {
        $this->modx = &$modx;
        $this->pdo = $this->modx->getService('pdoTools');
    }

    /**
     * Database backend
     *
     * Handles backend operations for the database manager interface.
     * Routes to different views: orders, orderdetails, or stock management.
     *
     * @param array $scriptProperties Script properties including 'view' parameter
     * @return void
     */
    public function backend(array $scriptProperties)
    {
        $this->scriptProperties = $scriptProperties;

        // Set component URL placeholder for backend navigation
        $this->modx->setPlaceholder('cmp_url', '?a=index&namespace=' . $this->namespace . '&');

        // Route to appropriate view handler
        switch ($this->scriptProperties['view']) {
            default:
                $this->set();
                $this->get();
                break;
        }
    }

    /**
     * Update
     *
     * @return void
     */
    public function set()
    {
        $id = $this->scriptProperties['id'];
        $title = $this->scriptProperties['title'];
        $content = $this->scriptProperties['content'];

        // Validate
        if (empty($title) || empty($content)) {
            return;
        }

        $item = $this->modx->getObject('CMP\Database\Model\Sample', $id);

        if (!$item) {
            $item = $this->modx->newObject('CMP\Database\Model\Sample');
        }


        $item->set('title', $title);
        $item->set('content', $content);

        $item->save();
    }

    /**
     * Get
     *
     * @return void
     */
    public function get()
    {
        $output = [];

        $query = $this->modx->newQuery('CMP\Database\Model\Sample');
        $query->sortby('createdon', 'DESC');
        $query->limit(1000);

        // Filter
        if (is_numeric($this->scriptProperties['id'])) {
            $query->where([
                'id' => $this->scriptProperties['id']
            ]);
        }
        if (!empty($this->scriptProperties['search'])) {
            $query->where([
                'title:LIKE' => '%' . $this->scriptProperties['search'] . '%'
            ]);
        }

        $items = $this->modx->getCollection('CMP\Database\Model\Sample', $query);

        foreach ($items as $item) {
            $output[] = $item->toArray();
        }

        $this->modx->setPlaceholder('items', $output);
    }

    /**
     * Error handling and logging
     *
     * Logs error to MODX error log and displays user-friendly error message.
     * Uses null-safe operator for exception message extraction.
     *
     * @param mixed $e Exception object or null
     * @param string $message Custom error message to display and log
     * @return void
     */
    public function error(mixed $e, string $message = '')
    {
        // Log error with exception details if available
        $this->modx->log(xPDO::LOG_LEVEL_ERROR, $message . ', ' . $e?->getMessage());

        // Display user-friendly error message with styling
        echo '<div class="white p2 bg-red-5 br3">' . $message . '</div>';
    }
}
