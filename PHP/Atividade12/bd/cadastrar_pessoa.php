<?php    
    require_once("pdo.php");
    require_once("../classes/pessoa.php");

    $pessoa = new pessoa();

    $pessoa->setPesnome($_POST['nome']);
    $pessoa->setPessobrenome($_POST['sobrenome']);
    $pessoa->setPesemail($_POST['email']);
    $pessoa->setPespassword($_POST['password']);
    $pessoa->setPescidade($_POST['cidade']);
    $pessoa->setPesestado($_POST['estado']);

    $pessoa->cadastrarPessoa($pdo);
?>