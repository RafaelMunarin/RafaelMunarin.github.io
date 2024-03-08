<?php
    require_once("../session.php");
    require_once("../bd/pdo.php");
    require_once("../classes/pessoa.php");
    require_once("../cookie_validate.php");

    $pessoaNull = new pessoa();

    if (($_SERVER['REQUEST_METHOD'] == 'POST') and ($_POST['pesnome'] != '')) {
        $pessoas = $pessoaNull->getPessoaIlike($_POST['pesnome'], $pdo);
    } else {
        $pessoas = $pessoaNull->getPessoas($pdo);
    }
    file_put_contents("pessoas.json", "[" . "\n", FILE_APPEND);
    foreach ($pessoas as $pessoa) {
        $pessoaPersist = new pessoa();
        $pessoaPersist->setPesnome($pessoa['pesnome']);
        $pessoaPersist->setPesemail($pessoa['pesemail']);
        $pessoaPersist->setPescidade($pessoa['pescidade']);
        $pessoaPersist->setPesestado($pessoa['pesestado']);
        if ($pessoa['pesnome'] == $pessoas[count($pessoas) - 1]['pesnome']) {
            file_put_contents("pessoas.json", $pessoaPersist->toJson() . "\n", FILE_APPEND);
        } else {
            file_put_contents("pessoas.json", $pessoaPersist->toJson() . ", \n", FILE_APPEND);
        }
    }
    file_put_contents("pessoas.json", "]" . "\n", FILE_APPEND);
?>

<a href="cadastropessoa.html">Cadastrar Pessoa</a>

<form method="post">
    <div>
        <label for="pesnome">Nome:</label>
        <input type="text" id="pesnome" name="pesnome">
    </div>
    <div>
        <button type="submit">Buscar</button>
    </div>
<table border>
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($pessoas as $pessoa): ?>
            <tr>
                <td><?php echo $pessoa['pescodigo']; ?></td>
                <td><?php echo $pessoa['pesnome']; ?></td>
                <td><?php echo $pessoa['pesemail']; ?></td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>