<?php
    define('valor_carro', 22500);
    define('valor_parcela', 489.65);
    define('qtd_parcelas', 60);

    function calcula_valor_juros() {
        try { 
            return (valor_parcela * qtd_parcelas) - valor_carro;
        } catch (Exception $e) {
            return "Houve erro no cálculo: " . $e->getMessage();    
        }
    } 

    echo "O valor que Mariazinha irá gastar só com juros é de: R$ " . number_format(calcula_valor_juros(), 2, ",", ".");
?>