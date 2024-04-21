<?php
require_once "pessoa.php";

    $oPessoa = new pessoa();
    $oPessoa->setNOme("Rafael");
    $oPessoa->setSobreNome("Munarin"); 
    $nomeCompleto = $oPessoa->getNomeCompleto("Rafael", "Munarin");

    echo $nomeCompleto;
?>  