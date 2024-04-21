<?php
    define('valor_moto', 8654);
    define('taxa_juro', 2);
    define('taxa_variacao', 0.3);
    define('planos', array(24, 36, 48, 60));

    function calcula_escreve_valor_parcelas() {
        try { 
            $taxa = taxa_juro; 
            $result = '';
            for ($plano=0; $plano < 4; $plano++) { 
                $montante = valor_moto * pow(1 + ($taxa / 100), planos[$plano]);
                $valor_parcela = $montante / planos[$plano];

                $result .= "Para o plano de ".planos[$plano]." meses será de: R$ ".number_format($valor_parcela, 2, ",", ".").".<br>";
                $taxa = $taxa + taxa_variacao;
            }
            return $result;
        } catch (Exception $e) {
            return "Houve erro no cálculo: " . $e->getMessage();    
        }
    } 
    echo "Os seguintes valores de parcelas poderão ser pagos nos planos:<br><br>".calcula_escreve_valor_parcelas()
?>