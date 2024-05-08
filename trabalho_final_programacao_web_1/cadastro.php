<?php
session_start();
if (isset($_SESSION['username']) && isset($_SESSION['tempoSessao'])) {
    $tempoTotal = 300;
    $tempoDecorrido = time() - $_SESSION['tempoSessao'];
    if ($tempoDecorrido > $tempoTotal) {
        session_unset();
        session_destroy();
        echo "<script language='javascript' type='text/javascript'>alert('Sessão expirada. Por favor, faça o login novamente.'); window.location.href='index.html';</script>";
        exit();
    } else {
        $tempoRestante = $tempoTotal - $tempoDecorrido;
        echo 'Sessão ativa. Tempo restante: ' . gmdate('H:i:s', $tempoRestante);
    }
} else {
    echo "Sessão não iniciada";
}
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Clientes</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <h1>Cadastro de Clientes</h1>
        <form action="cadastroCliente.php" method="post">
            <div>
                <label for="nome">Nome:</label>
                <input type="text" name="nome" id="nome">
            </div>
            <div>
                <label for="sobrenome">Sobrenome:</label>
                <input type="text" name="sobrenome" id="sobrenome">
            </div>
            <div>
                <label for="data_nascimento">Data de Nascimento:</label>
                <input type="date" name="data_nascimento" id="data_nascimento">
            </div>
            <div>
                <label for="email">E-mail:</label>
                <input type="email" name="email" id="email">
            </div>
            <input type="submit" value="Cadastrar">
        </form>
        <a href="buscaCliente.php">Consultar Cadastro Cliente</a>
        </a>
    </div>
</body>
</html>

