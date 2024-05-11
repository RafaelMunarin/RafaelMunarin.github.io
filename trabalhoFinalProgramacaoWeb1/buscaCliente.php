<?php

require_once 'config.php';

// Função para listar todos os clientes
function listarTodosClientes() {
    global $pdo;

    $sql = "SELECT * FROM cliente";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();

    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Inicializa a variável de clientes
$clientes = [];

// Verifica se há um termo de busca
if (isset($_GET['busca'])) {
    $termo_busca = '%' . $_GET['busca'] . '%';

    // Função para buscar clientes com filtro por nome
    function buscarClientes($filtro) {
        global $pdo;

        // Usando ILIKE para PostgreSQL ou LIKE para MySQL
        $sql = "SELECT * FROM cliente WHERE nome ILIKE :filtro";
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':filtro', $filtro);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Buscar clientes com o termo de busca
    $clientes = buscarClientes($termo_busca);
} else {
    // Listar todos os clientes se não houver termo de busca
    $clientes = listarTodosClientes();
}

?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Resultado da Busca</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Resultado da Busca</h1>
    <form action="" method="get">
        <label for="busca">Buscar Cliente:</label>
        <input type="text" id="busca" name="busca" placeholder="Digite o nome do cliente">
        <input type="submit" value="Buscar">
    </form>
    <?php if (isset($termo_busca)): ?>
        <p>Resultados para: <?= htmlspecialchars($_GET['busca']) ?></p>
    <?php endif; ?>
    <table>
        <tr>
            <th>Nome</th>
            <th>Sobrenome</th>
            <th>Data de Nascimento</th>
            <th>Email</th>
        </tr>
        <?php foreach ($clientes as $cliente): ?>
            <tr>
                <td><?= $cliente['nome'] ?></td>
                <td><?= $cliente['sobrenome'] ?></td>
                <td><?= $cliente['data_nascimento'] ?></td>
                <td><?= $cliente['email'] ?></td>
            </tr>
        <?php endforeach; ?>
    </table>

    <br>
    <a href="cadastro.php">Voltar para a tela de Cadastro</a>
</body>
</html>
            