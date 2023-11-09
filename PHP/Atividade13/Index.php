<?php
    require_once "model\\pessoa.php";

    $pessoa = new \app\model\pessoa();
    $pessoa->setNome("Rafael");
    $pessoa->setSobreNome("Munarin");
    $pessoa->setDataNascimento(new DateTime("2002-01-08"));

    $pessoa->getTelefone()->setTipo(1);
    $pessoa->getTelefone()->setNome("Tel Celular");
    $pessoa->getTelefone()->setValor("(47) 99675-9690");

    $pessoa->getEndereco()->setLogradouro("Rua Regina Pasqualini");
    $pessoa->getEndereco()->setBairro("Canta Galo");
    $pessoa->getEndereco()->setCidade("Rio do Sul");
    $pessoa->getEndereco()->setCEP("89163264");
    $pessoa->getEndereco()->setEstado("SC");

    echo $pessoa->toJson();
?>