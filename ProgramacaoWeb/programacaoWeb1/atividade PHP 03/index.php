<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Atividade PHP 3</title>
</head>
<body>
    <?php
        function calcula_area_quadrado($tamanho) {
            return $tamanho * $tamanho;
        } 
        if(isset($_POST['campo_tamanho']) && isset($_POST['campo_tamanho']) > 0) {
            echo "<p>A área do quadrado de lado " . $_POST['campo_tamanho'] . " metros é " . calcula_area_quadrado($_POST['campo_tamanho']) . " metros quadrados" . "</p>";    
        } else {
            echo "<script>alert('Informe um número positivo')</script>";
        }
    ?>
    <form action="/exercs/03_exerc_area_quadrado.php" method="post">
        <label for="campo_tamanho">Tamanho Lado:</label>
        <input type="number" id="campo_tamanho" name="campo_tamanho"><br>
        
        <br><input type="submit" value="Calcular">
    </form>
</body>
</html>