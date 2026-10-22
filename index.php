<?php
// index.php (Ponto de entrada do projeto)
require_once __DIR__ . '/app/config/database.php';

// Busca a ata na base de dados
$stmt = $pdo->query("SELECT * FROM atas WHERE numero_ata LIKE '%DEZANOVE%' LIMIT 1");
$ata = $stmt->fetch(PDO::FETCH_ASSOC);

// Carrega a view passando os dados
require_once __DIR__ . '/app/views/ata_view.php';
?>