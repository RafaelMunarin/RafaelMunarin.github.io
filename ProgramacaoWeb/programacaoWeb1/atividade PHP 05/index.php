<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Atividade PHP 05</title>
<head>
<body>
    <?php
        function calcula_area_triangulo_retangulo($base, $altura) {
            try { 
                return ($base * $altura) / 2;
            } catch (Exception $e) {
                return "Houve erro no cálculo: " . $e->getMessage();    
            }
        } 
        if(isset($_POST['campo_base']) && ($_POST['campo_base'] > 0) && isset($_POST['campo_altura']) && ($_POST['campo_altura'] > 0)) {
            echo "<p>A área do triângulo/retângulo de base: " . $_POST['campo_base'] . " e altura: " . $_POST['campo_altura'] . " é: " . calcula_area_triangulo_retangulo($_POST['campo_base'], $_POST['campo_altura']) . "</p>"; 
        } else {
            echo "<script>alert('Informe apenas valores positivos')</script>";
        }
    ?>
    <form action="/exercs/05_exerc_area_triangulo_ret.php" method="post">
        <label for="campo_base">Cumprimento Base:</label>
        <input type="number" id="campo_base" name="campo_base"><br>
        
        <label for="campo_altura">Cumprimento Altura:</label>
        <input type="number" id="campo_altura" name="campo_altura"><br>

        <br><input type="submit" value="Calcular">
    </form>
</body>
</html>