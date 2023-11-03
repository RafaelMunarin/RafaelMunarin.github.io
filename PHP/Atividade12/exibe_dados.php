<?php
session_start();

if(isset($_SESSION['login']) && isset($_SESSION['senha']) && isset($_SESSION['inicio_sessao']) && isset($_SESSION['ultima_requisicao']) && isset($_SESSION['tempo_sessao'])){
    echo "Login: ".$_SESSION['login']."<br>";
    echo "Senha: ".$_SESSION['senha']."<br>";
    echo "Data/hora de início da sessão: ".$_SESSION['inicio_sessao']."<br>";
    echo "Data/hora da última requisição: ".$_SESSION['ultima_requisicao']."<br>";
    echo "Tempo de sessão: ".(time() - $_SESSION['tempo_sessao'])." segundos<br>";
} else {
    echo "Sessão não iniciada";
}

if (!isset($_COOKIE['usuario']) && isset($_COOKIE['sessao_iniciada'])) {
    setcookie('sessao_iniciada', time(), time() + 500);
    $_COOKIE['usuario'] = $_SESSION['login'];
} else {
    $tempoExpiracao = 500; 
    $tempoDecorrido = time() - $_COOKIE['sessao_iniciada'];
    echo "<h1>Usuário: ".$_COOKIE['usuario']."</h1>";
    if ($tempoDecorrido > $tempoExpiracao) {
        echo '<script>alert("Sessão expirada. Por favor, faça o login novamente.");</script>';
    } 
    
    else {
        $tempoRestante = $tempoExpiracao - $tempoDecorrido;
        echo 'Sessão ativa. Tempo restante: ' . gmdate('H:i:s', $tempoRestante);
    }
}

?>
