<?php

namespace App\Extensions\Catalog2;

use App\Extensions\Catalog\SaleAssist;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use PhpOffice\PhpSpreadsheet\Style\Border;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use PhpOffice\PhpSpreadsheet\Style\Font;
use Simflex\Core\Time;

class ExcelGenerator
{
    /**
     * Генерирует XLSX-файл с содержимым заказа и возвращает путь к временному файлу
     *
     * @param object $order Объект заказа
     * @param array $cartItems Массив элементов корзины ($cart->getProducts()['items'])
     * @param string $callbackText Способ связи из формы
     * @return string Путь к временному файлу .xlsx
     */
    public static function generateOrderExcel($order, array $cartItems, string $callbackText = ''): string
    {
        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();
        $sheet->setTitle('Заказ №' . $order->order_id);

        $order->sum_actual = (float) str_replace([' ', ','], ['', '.'], (string)$order->sum_actual);

        // Стили
        $headerStyle = [
            'font' => [
                'bold' => true,
                'size' => 12,
                'color' => ['rgb' => 'FFFFFF'],
            ],
            'fill' => [
                'fillType' => Fill::FILL_SOLID,
                'startColor' => ['rgb' => '4A90E2'],
            ],
            'alignment' => [
                'horizontal' => Alignment::HORIZONTAL_CENTER,
                'vertical' => Alignment::VERTICAL_CENTER,
            ],
            'borders' => [
                'allBorders' => ['borderStyle' => Border::BORDER_THIN],
            ],
        ];

        $totalStyle = [
            'font' => ['bold' => true, 'size' => 12],
            'alignment' => ['horizontal' => Alignment::HORIZONTAL_RIGHT],
        ];

        // Заголовок документа
        $sheet->setCellValue('A1', 'Заказ №' . $order->order_id);
        $sheet->mergeCells('A1:G1');
        $sheet->getStyle('A1')->getFont()->setSize(16)->setBold(true);
        $sheet->getRowDimension(1)->setRowHeight(30);

        // Информация о заказе
        $sheet->setCellValue('A3', 'Дата создания:');
        $sheet->setCellValue('B3', Time::create()->asMySQL());

        $sheet->setCellValue('A4', 'Клиент:');
        $sheet->setCellValue('B4', trim($order->last_name . ' ' . $order->name));

        $sheet->setCellValue('A5', 'Телефон:');
        $sheet->setCellValue('B5', $order->phone);

        $sheet->setCellValue('A6', 'Email:');
        $sheet->setCellValue('B6', $order->email);

        $sheet->setCellValue('A7', 'Способ связи:');
        $sheet->setCellValue('B7', $callbackText !== '' ? $callbackText : ($order->callback ?? ''));

        $sheet->setCellValue('A8', 'Организация:');
        $sheet->setCellValue('B8', $order->org_name ?? '');

        // Таблица товаров
        $sheet->setCellValue('A10', '№');
        $sheet->setCellValue('B10', 'Наименование товара');
        $sheet->setCellValue('C10', 'Артикул');
        $sheet->setCellValue('D10', 'Кол-во');
        $sheet->setCellValue('E10', 'Цена, ₽');
        $sheet->setCellValue('F10', 'Сумма, ₽');

        $sheet->getStyle('A10:F10')->applyFromArray($headerStyle);

        $row = 11;
        $num = 1;

        foreach ($cartItems as $item) {
            $product = $item['product'];

            $cleanSum = (float) str_replace([' ', ','], ['', '.'], (string)$item['sum_actual']);

            $priceOld = PriceAssist::getPrice($product->product_id, $item['variant_id'] ?? null);
            $discountMod = SaleAssist::getModFor($product->product_id);
            $unitPrice = $priceOld - $priceOld * $discountMod;

            $unitPrice = ceil($unitPrice);

            $sheet->setCellValue('A' . $row, $num);
            $sheet->setCellValue('B' . $row, $product->name);
            $sheet->setCellValue('C' . $row, $product->sku ?? '-');
            $sheet->setCellValue('D' . $row, $item['qty']);
            $sheet->setCellValue('E' . $row, number_format($unitPrice, 2, '.', ' ') . ' ₽');
            $sheet->setCellValue('F' . $row, number_format($cleanSum, 2, '.', ' ') . ' ₽');

            $sheet->getStyle('E' . $row)->getAlignment()->setHorizontal(Alignment::HORIZONTAL_RIGHT);
            $sheet->getStyle('F' . $row)->getAlignment()->setHorizontal(Alignment::HORIZONTAL_RIGHT);

            $sheet->getStyle('A' . $row . ':F' . $row)->applyFromArray([
                'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN]],
            ]);

            $row++;
            $num++;
        }

        // Итог
        $cleanTotal = (float) str_replace([' ', ','], ['', '.'], (string)$order->sum_actual);

        $sheet->setCellValue('E' . $row, 'Итого:');
        $sheet->setCellValue('F' . $row, number_format($cleanTotal, 2, '.', ' ') . ' ₽');
        $sheet->getStyle('E' . $row . ':F' . $row)->applyFromArray($totalStyle);
        $sheet->getStyle('F' . $row)->getFont()->setBold(true);

        // Автоширина колонок
        foreach (range('A', 'F') as $col) {
            $sheet->getColumnDimension($col)->setAutoSize(true);
        }

        // Сохранение во временный файл
        $filePath = sys_get_temp_dir() . '/order' . $order->order_id . '_' . time() . '.xlsx';
        $writer = new Xlsx($spreadsheet);
        $writer->save($filePath);

        return $filePath;
    }
}
