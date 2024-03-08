<?php

require_once 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST"){ 
$nome = $_POST['nome'];
$sobrenome = $_POST['sobrenome'];
$data_nascimento = $_POST['data_nascimento'];
$email = $_POST['email'];
$sql = "INSERT INTO cliente (nome, sobrenome, data_nascimento, email) 
        VALUES (:nome, :sobrenome, :data_nascimento, :email)";
$stmt = $pdo->prepare($sql);
$stmt->bindParam(':nome', $nome);
$stmt->bindParam(':sobrenome', $sobrenome);
$stmt->bindParam(':data_nascimento', $data_nascimento);
$stmt->bindParam(':email', $email);
$stmt->execute();
echo "Cliente cadastrado com sucesso.";
}
?>