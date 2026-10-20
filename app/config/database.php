<?php

$host = "localhost";
$user = "root";
$password = "";
$database = "gesgov_atas";

$conn = new mysqli(
    $host,
    $user,
    $password,
    $database
);

if ($conn->connect_error) {
    die("Erro na ligação: " . $conn->connect_error);
}
