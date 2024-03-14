<?php
require_once __DIR__ . '/vendor/autoload.php';

// Cria uma instância do mPDF
$mpdf = new \Mpdf\Mpdf();

// Gera algum conteúdo HTML
$html = '<h1>Meu Primeiro PDF com mPDF</h1>';

// Adiciona o conteúdo HTML ao mPDF
$mpdf->WriteHTML($html);

// Salva o PDF no servidor
$mpdf->Output('meu_pdf.pdf', 'F');

?>