<?php
    session_start();

    if (!isset($_SESSION['user'])) {
        header("Location: ../index.php");
    } else {
        $user = $_SESSION['user'];
        $password = $_SESSION['password'];
        $login_time = $_SESSION['login_time'];
        $last_req_time = $_SESSION['last_req_time'];
        $session_time = time() - $login_time;

        echo "Bem vindo $user" . "<br>";
        echo "Sua senha é $password" . "<br>";
        echo "Você está logado há $session_time segundos" . "<br>";
        echo "Última requisição: " . date('d/m/Y H:i:s', $last_req_time) . "<br>";
        echo "Hora atual: " . date('d/m/Y H:i:s', time()) . "<br>";

        echo "<a href='/logout.php'>Logout</a>";
    }
?>