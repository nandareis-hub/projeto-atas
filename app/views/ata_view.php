<?php
require_once __DIR__ . '/../config/database.php';

// Buscar a ata número 19/2026
$stmt = $pdo->query("SELECT * FROM atas WHERE numero_ata LIKE '%DEZANOVE%' LIMIT 1");
$ata = $stmt->fetch(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title><?php echo htmlspecialchars($ata['numero_ata']); ?> - União das Freguesias de Almada, Cova da Piedade, Pragal e Cacilhas</title>
    <link rel="stylesheet" href="../../assets/css/style.css">
    <style>
        body { font-family: "Times New Roman", Times, serif; line-height: 1.6; color: #000; margin: 40px; }
        .header-institucional { text-align: center; margin-bottom: 30px; }
        .header-institucional h2 { font-size: 16px; margin: 5px 0; text-transform: uppercase; }
        .codigos { text-align: right; font-size: 14px; font-weight: bold; margin-bottom: 20px; }
        .corpo-ata { text-align: justify; text-justify: inter-word; font-size: 15px; }
        .assinaturas { margin-top: 50px; display: flex; justify-content: space-between; page-break-inside: avoid; }
        .bloco-assinatura { text-align: center; width: 45%; }
        .linha-assinatura { border-top: 1px solid #000; margin-top: 60px; padding-top: 5px; }
    </style>
</head>
<body>

    <div class="codigos">
        <span><?php echo htmlspecialchars($ata['codigo_arquivo']); ?></span>
    </div>

    <div class="header-institucional">
        <h2>UNIÃO DAS FREGUESIAS DE ALMADA, COVA DA PIEDADE, PRAGAL E CACILHAS</h2>
        <h3>MANDATO <?php echo htmlspecialchars($ata['mandato']); ?></h3>
        <h2><?php echo htmlspecialchars($ata['numero_ata']); ?></h2>
    </div>

    <div class="corpo-ata">
        <p>
            Aos nove dias do mês de setembro do ano de dois mil e vinte e seis, realizou-se a terceira 
            reunião extraordinária da União das Freguesias de Almada, Cova da Piedade, Pragal e 
            Cacilhas de dois mil e vinte e seis, conforme artigo vigésimo quarto do Decreto-Lei 
            número quatro barra dois mil e quinze, de sete de janeiro, na Sede da União, sita na Rua Dona 
            Leonor de Mascarenhas, número quarenta e quatro, Letra A, em Almada, sob a presidência da 
            Presidente, **<?php echo htmlspecialchars($ata['presidente']); ?>**, achando-se também presentes:
        </p>
        <p>
            ------- Vogal - Raquel Palhotas Pacheco.<br>
            ------- Vogal - Paulo Ricardo Correia Póvoa Figueiredo.<br>
            ------- Vogal - Martim de Freitas Gordinho.
        </p>
        <p>
            A Secretária, **<?php echo htmlspecialchars($ata['secretaria']); ?>**, e o Tesoureiro, **<?php echo htmlspecialchars($ata['tesoureiro']); ?>**, participaram na reunião por videoconferência.
        </p>
        <p>
            Estando ausente o Vogal, Manuel Domingos Rodrigues Batista, por motivos de férias, nos 
            termos do disposto na alínea c) do art.º 19.º da Lei n.º 75/2013, de 12 de setembro, é considerada justificada a respetiva falta.
        </p>
        <hr>
        <h3>Ordem de Trabalhos</h3>
        <p><?php echo nl2br(htmlspecialchars($ata['conteudo_ata'])); ?></p>
    </div>

    <div class="assinaturas">
        <div class="bloco-assinatura">
            <div class="linha-assinatura">A Presidente,<br><?php echo htmlspecialchars($ata['presidente']); ?></div>
        </div>
        <div class="bloco-assinatura">
            <div class="linha-assinatura">A Secretária,<br><?php echo htmlspecialchars($ata['secretaria']); ?></div>
        </div>
    </div>

</body>
</html>