<?php
namespace App\Extensions\Onec;

use App\Extensions\Onec\Import\CatalogStock;
use App\Extensions\Onec\Import\PriceLevels;
use App\Extensions\Onec\Import\ProductPrices;
use Simflex\Core\ConsoleBase;
use App\Extensions\Onec\Import\CategoryImporter;
use App\Extensions\Onec\Import\ProductImporter;
use App\Extensions\Onec\Import as OnecImport;

class ConsoleOnec extends ConsoleBase
{
    protected function logLine(string $msg, bool $isError = false): void
    {
        $timestamp = date('Y-m-d H:i:s');
        $level = $isError ? 'ERROR' : 'INFO';
        $line = "[$timestamp] [$level] $msg" . PHP_EOL;

        $logFile = __DIR__ . '/storage/categories_import.log';
        @file_put_contents($logFile, $line, FILE_APPEND | LOCK_EX);
        echo $line;
    }

    protected function resolveFile(?string $file, string $defaultName): string
    {
        if ($file) {
            return $file;
        }
        return __DIR__ . '/storage/' . $defaultName;
    }

    protected function readJson(string $filePath): array
    {
        if (!file_exists($filePath)) {
            throw new \RuntimeException('Файл не найден: ' . $filePath);
        }

        $json = file_get_contents($filePath);
        $data = json_decode($json, true);
        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new \RuntimeException('Некорректный JSON: ' . json_last_error_msg());
        }

        return $data ?? [];
    }

    public function importPriceLevels(?string $file = null) {
        $this->logLine('=== СТАРТ ИМПОРТА УРОВНЕЙ ЦЕН ===');

        $filePath = $this->resolveFile($file, 'priceLevels.json');
        $data = $this->readJson($filePath);

        if (empty($data['result']) || !is_array($data['result'])) {
            throw new \RuntimeException('Отсутствует поле result или оно пустое');
        }

        $levels = $data['result'];
        $this->logLine('Уровней цен: ' . count($levels));

        (new PriceLevels())->import(
            $levels,
            fn(string $msg, bool $isError = false) => $this->logLine($msg, $isError)
        );
    }

    public function importProductPrices(?string $file = null)
    {
        $this->logLine('=== СТАРТ ИМПОРТА ЦЕН ===');

        $filePath = $this->resolveFile($file, 'productPrices.json');
        $data = $this->readJson($filePath);

        if (empty($data['result']) || !is_array($data['result'])) {
            throw new \RuntimeException('Отсутствует поле result или оно пустое');
        }

        $price = $data['result'];
        $this->logLine('Продуктов с ценами: ' . count($price));

        (new ProductPrices())->import(
            $price,
            fn(string $msg, bool $isError = false) => $this->logLine($msg, $isError)
        );
    }

    public function importCatalogStock(?string $file = null)
    {
        $this->logLine('=== СТАРТ ИМПОРТА ОСТАТКОВ ===');

        $filePath = $this->resolveFile($file, 'remainder.json');
        $data = $this->readJson($filePath);

        if (empty($data['result']) || !is_array($data['result'])) {
            throw new \RuntimeException('Отсутствует поле result или оно пустое');
        }

        $stocks = $data['result'];
        $this->logLine('Продуктов с отстатками: ' . count($stocks));

        (new CatalogStock())->import(
            $stocks,
            fn(string $msg, bool $isError = false) => $this->logLine($msg, $isError)
        );
    }

    public function importCategories(?string $file = null, bool $rebuildCache = false)
    {
        $this->logLine('=== СТАРТ ИМПОРТА КАТЕГОРИЙ ===');

        $filePath = $this->resolveFile($file, 'categories.json');
        $data = $this->readJson($filePath);

        if (empty($data['result']) || !is_array($data['result'])) {
            throw new \RuntimeException('Отсутствует поле result или оно пустое');
        }

        $categories = $data['result'];
        $this->logLine('Категорий в файле: ' . count($categories));

        (new CategoryImporter())->import(
            $categories,
            $rebuildCache,
            fn(string $msg, bool $isError = false) => $this->logLine($msg, $isError)
        );
    }

    public function rebuildCategoryCaches()
    {
        (new CategoryImporter())->rebuildCaches(
            fn(string $msg, bool $isError = false) => $this->logLine($msg, $isError)
        );
    }

    public function importProducts(?string $file = null, ?array $allowedProductIds = null)
    {
        $this->logLine('=== СТАРТ ИМПОРТА ПРОДУКТОВ ===');

        $filePath = $this->resolveFile($file, 'products.json');
        $data = $this->readJson($filePath);

        if (empty($data['result']) || !is_array($data['result'])) {
            throw new \RuntimeException('Отсутствует поле result или оно пустое');
        }

        $products = $data['result'];
        $this->logLine('Продуктов в файле: ' . count($products));

        if (is_array($allowedProductIds)) {
            $before = count($products);
            $products = array_values(array_filter(
                $products,
                fn($p) => isset($p['ID']) && isset($allowedProductIds[$p['ID']])
            ));
            $this->logLine('Продуктов после фильтра по ценам: ' . count($products) . ' (отсеяно: ' . ($before - count($products)) . ')');
        }

        (new ProductImporter())->import(
            $products,
            fn(string $msg, bool $isError = false) => $this->logLine($msg, $isError)
        );
    }

    public function importAll(
        ?string $categoriesFile = null,
        ?string $productsFile = null,
        ?string $priceLevelsFile = null,
        ?string $productPricesFile = null,
        ?string $remainderFile = null,
        bool $rebuildCategoryCache = false,
        bool $filterProductsByPrices = false
    ) {
        $this->logLine('=== СТАРТ ПОЛНОГО ИМПОРТА 1С ===');

        $this->importPriceLevels($priceLevelsFile);
        $this->importCategories($categoriesFile, $rebuildCategoryCache);
        $allowedProductIds = null;
        if ($filterProductsByPrices) {
            $priceFilePath = $this->resolveFile($productPricesFile, 'productPrices.json');
            $priceData = $this->readJson($priceFilePath);
            $allowedProductIds = [];
            foreach (($priceData['result'] ?? []) as $row) {
                if (!empty($row['ProductID'])) {
                    $allowedProductIds[$row['ProductID']] = true;
                }
            }
        }
        $this->importProducts($productsFile, $allowedProductIds);
        $this->importProductPrices($productPricesFile);
        $this->importCatalogStock($remainderFile);

        $this->logLine('=== ПОЛНЫЙ ИМПОРТ 1С ЗАВЕРШЕН ===');
    }

    public function pullAndImportAll(bool $rebuildCategoryCache = false, bool $filterProductsByPrices = false)
    {
        $runner = new OnecImport(fn(string $msg, bool $isError = false) => $this->logLine($msg, $isError));

        $steps = [
            [
                'method' => 'PriceLevels',
                'file' => 'priceLevels.json',
                'import' => fn(string $file) => $this->importPriceLevels($file),
            ],
            [
                'method' => 'Categories',
                'file' => 'categories.json',
                'import' => fn(string $file) => $this->importCategories($file, $rebuildCategoryCache),
            ],
            [
                'method' => 'Products',
                'file' => 'products.json',
                'import' => function (string $file) use ($filterProductsByPrices) {
                    if (!$filterProductsByPrices) {
                        $this->importProducts($file);
                        return;
                    }

                    $priceFilePath = $this->resolveFile(null, 'productPrices.json');
                    $priceData = $this->readJson($priceFilePath);
                    $allowedProductIds = [];
                    foreach (($priceData['result'] ?? []) as $row) {
                        if (!empty($row['ProductID'])) {
                            $allowedProductIds[$row['ProductID']] = true;
                        }
                    }
                    $this->importProducts($file, $allowedProductIds);
                    $this->importProductPrices($priceFilePath);
                },
            ],
            [
                'method' => 'Остатки',
                'file' => 'remainder.json',
                'import' => fn(string $file) => $this->importCatalogStock($file),
            ],
            [
                'method' => 'ProductPrices',
                'file' => 'productPrices.json',
                'import' => function (string $file) use ($filterProductsByPrices) {
                    if ($filterProductsByPrices) {
                        $this->logLine('--- ProductPrices pulled (import delayed until after Products) ---');
                        return;
                    }

                    $this->importProductPrices($file);
                },
            ],
        ];

        $runner->pullAndImportAll($steps);
    }
}
