<?php
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $login = $_POST["login"];
    $senha = $_POST["senha"];

    // Armazenar dados na sessão
    $_SESSION["login"] = $login;
    $_SESSION["senha"] = $senha;
    $_SESSION["inicio_sessao"] = date('Y-m-d H:i:s');
    $_SESSION["ultima_requisicao"] = date('Y-m-d H:i:s');
    $_SESSION["tempo_sessao"] = time();

   $_COOKIE['login'] =  $_SESSION["login"]; 
   $_COOKIE['senha'] =  $_SESSION["senha"];
   $_COOKIE['inicio_sessao'] =  $_SESSION["inicio_sessao"];
   $_COOKIE['ultima_requisicao'] = $_SESSION["ultima_requisicao"]; 
   $_COOKIE['ultima_requisicao'] = $_SESSION["tempo_sessao"];

    // Redirecionar para outra página
    header("Location: exibe_dados.php");
    exit;
}
?>
