<?php
session_start();

if (isset($_SESSION['login']) && isset($_SESSION['senha']) && isset($_SESSION['inicioSessao']) && isset($_SESSION['requisicaoFinal']) && isset($_SESSION['tempoSessao'])) {
    echo "Usuário logado: " . $_SESSION['login'] . "<br>";
    echo "Senha utilizada é: " . $_SESSION['senha'] . "<br>";
    echo "Sessão iniciada em: " . $_SESSION['inicioSessao'] . "<br>";
    echo "Ultima Sessão foi iniciada em: " . $_SESSION['requisicaoFinal'] . "<br>";
    echo "Tempo da Sessão atual: " . (time() - $_SESSION['tempoSessao']) . " segundos<br>";
} else {
    echo "Sessão não iniciada";
}

if (isset($_SESSION['login']) && isset($_SESSION['tempoSessao'])) {
    $tempoExpiracao = 10; 
    $tempoDecorrido = time() - $_SESSION['tempoSessao'];
    
    if ($tempoDecorrido > $tempoExpiracao) {
        echo "<script language='javascript' type='text/javascript'>alert('Sessão expirada. Por favor, faça o login novamente.'); window.location.href='formularioLogin.html';</script>";
    } else {
        $tempoRestante = $tempoExpiracao - $tempoDecorrido;
        echo 'Sessão ativa. Tempo restante: ' . gmdate('H:i:s', $tempoRestante);
    }
} else {
    echo "Sessão não iniciada";
}
?>
