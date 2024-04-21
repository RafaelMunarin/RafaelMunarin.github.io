<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Atividade PHP 06</title>
</head>
<body>
    <?php
        define('valor_unitario_produtos', array(9.55, 3.45, 8.64, 2.34, 5.67, 4.99));
        define('valor_joaozinho', 50);
        function calcula_escreve_valor_compra($aqtd_comprada) {
            try { 
                $valor = 0;
                for ($item=0; $item < 6; $item++) { 
                    $valor = $valor + ($aqtd_comprada[$item] * valor_unitario_produtos[$item]);
                }
                $troco = valor_joaozinho - $valor;
                if($troco > 0) {
                    return '<p style="color:blue">O valor da compra foi: '.$valor.', sendo suficiente para pagar. Joãozinho ainda tem '.$troco.' para gastar.</p>';
                }
                if($troco < 0) {
                    return '<p style="color:red">O valor da compra foi: '.$valor.', sendo insuficiente para pagar, faltou'.$troco.'.</p>';
                }
                if($troco == 0) {
                    return '<p style="color:green">O valor da compra foi: '.$valor.', sendo exatamente igual ao que Joãozinho tinha para pagar.</p>';
                }
            } catch (Exception $e) {
                return "Houve erro no cálculo: " . $e->getMessage();    
            }
        } 
        if(isset($_POST['campo_qtd_maca']) && 
           isset($_POST['campo_qtd_melancia']) && 
           isset($_POST['campo_qtd_laranja']) && 
           isset($_POST['campo_qtd_repolho']) &&
           isset($_POST['campo_qtd_cenoura']) &&
           isset($_POST['campo_qtd_batatinha'])) {
            echo "<p>" . calcula_escreve_valor_compra(array($_POST['campo_qtd_maca'], 
                                                            $_POST['campo_qtd_melancia'],
                                                            $_POST['campo_qtd_laranja'],
                                                            $_POST['campo_qtd_repolho'],
                                                            $_POST['campo_qtd_cenoura'],
                                                            $_POST['campo_qtd_batatinha'])) . "</p>"; 
        } else {
            echo "<script>alert('Informe as quantidades nos campos conforme solicitado.')</script>";
        }
    ?>

    <form action="/exercs/06_exerc_calculo_gasto.php" method="post">
        <label for="campo_qtd_maca">Quantidade Maçã:</label>
        <input type="number" id="campo_qtd_maca" name="campo_qtd_maca" step=".001"><br>
        
        <label for="campo_qtd_melancia">Quantidade Melancia:</label>
        <input type="number" id="campo_qtd_melancia" name="campo_qtd_melancia" step=".001"><br>

        <label for="campo_qtd_laranja">Quantidade Laranja:</label>
        <input type="number" id="campo_qtd_laranja" name="campo_qtd_laranja" step=".001"><br>

        <label for="campo_qtd_repolho">Quantidade Repolho:</label>
        <input type="number" id="campo_qtd_repolho" name="campo_qtd_repolho" step=".001"><br>

        <label for="campo_qtd_cenoura">Quantidade Cenoura:</label>
        <input type="number" id="campo_qtd_cenoura" name="campo_qtd_cenoura" step=".001"><br>

        <label for="campo_qtd_batatinha">Quantidade Batatinha:</label>
        <input type="number" id="campo_qtd_batatinha" name="campo_qtd_batatinha" step=".001"><br>

        <br><input type="submit" value="Calcular">
    </form>
</body>
</html>