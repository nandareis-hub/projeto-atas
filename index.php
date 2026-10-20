<?php

$conn = new mysqli(
    "localhost",
    "root",
    "",
    "gesgov_atas"
);

if ($conn->connect_error) {
    die("Erro: " . $conn->connect_error);
}

echo "✅ Ligação à base de dados efetuada com sucesso!";