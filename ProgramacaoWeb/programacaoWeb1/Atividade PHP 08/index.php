<?php
    define('valor_moto', 8654);
    define('taxa_juro', 1.5);
    define('taxa_variacao', 0.5);
    define('planos', array(24, 36, 48, 60));

    function calcula_escreve_valor_parcelas() {
        try { 
            $taxa = taxa_juro; 
            $result = '';
            for ($plano=0; $plano < 4; $plano++) { 
                $valor_parcela = (valor_moto / planos[$plano]);
                $juros = $valor_parcela * ($taxa / 100);

                $result .= "Para o plano de ".planos[$plano]." meses será de: R$ ".number_format($valor_parcela+$juros, 2, ",", ".").".<br>";
                $taxa = $taxa + taxa_variacao;
            }
            return $result;
        } catch (Exception $e) {
            return "Houve erro no cálculo: " . $e->getMessage();    
        }
    } 
    echo "Os seguintes valores de parcelas poderão ser pagos nos planos:<br><br>".calcula_escreve_valor_parcelas()
?>