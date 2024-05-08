<?php
    session_start();

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $login = $_POST["login"];
        $senha = $_POST["senha"];
    }

    $_SESSION["login"] = $login . "<br>";
    $_SESSION["senha"] = $senha . "<br>"; 
    $_SESSION["inicioSessao"] = date('Y-m-d H:i:s') . "<br>"; 
    $_SESSION["requisicaoFinal"] = date('Y-m-d H:i:s') . "<br>"; 
    $_SESSION["tempoSessao"] =time(); 

    $_COOKIE['login'] =  $_SESSION["login"]; 
    $_COOKIE['senha'] =  $_SESSION["senha"];
    $_COOKIE['inicioSessao'] =  $_SESSION["inicioSessao"];
    $_COOKIE['requisicaoFinal'] = $_SESSION["requisicaoFinal"]; 
    $_COOKIE['tempoSessao'] = $_SESSION["tempoSessao"];

    header("Location: formularioDados.php"); 
?>