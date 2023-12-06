<?php
session_start();

if (isset($_SESSION['username']) && isset($_SESSION['password']) && isset($_SESSION['inicioSessao']) && isset($_SESSION['requisicaoFinal']) && isset($_SESSION['tempoSessao'])) {
    echo "Usuário logado: " . $_SESSION['username'] . "<br>";
    echo "Sessão iniciada em: " . $_SESSION['inicioSessao'] . "<br>";
    echo "Ultima Sessão foi iniciada em: " . $_SESSION['requisicaoFinal'] . "<br>";
    echo "Tempo da Sessão atual: " . (time() - $_SESSION['tempoSessao']) . " segundos<br>";
} else {
    echo "Sessão não iniciada";
}

if (isset($_SESSION['username']) && isset($_SESSION['tempoSessao'])) {
    $tempoTotal = 5; 
    $tempoDecorrido = time() - $_SESSION['tempoSessao'];
    
    if ($tempoDecorrido > $tempoTotal) {
        echo "<script language='javascript' type='text/javascript'>alert('Sessão expirada. Por favor, faça o login novamente.'); window.location.href='index.html';</script>";
    } else {
        $tempoRestante = $tempoTotal - $tempoDecorrido;
        echo 'Sessão ativa. Tempo restante: ' . gmdate('H:i:s', $tempoRestante);
    }
} else {
    echo "Sessão não iniciada";
}
?>
