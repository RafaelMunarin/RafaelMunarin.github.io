<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Atividade PHP 04</title>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP - Exercício 4</title>
</head>
<body>
    <?php      
        function calcula_escreve_area_retangulo($ladoa, $ladob) {
            $area = $ladoa * $ladob;
            if($area > 10) {
                return "<h1>A área do retângulo de lados " . $_POST['campo_ladoa'] . " e " . $_POST['campo_ladob'] . " metros é " . $area . " metros quadrados.</h1>";
            } else {
                return "<h3>A área do retângulo de lados " . $_POST['campo_ladoa'] . " e " . $_POST['campo_ladob'] . " metros é " . $area . " metros quadrados.</h3>";
            };
        } 
        if(isset($_POST['campo_ladoa']) && ($_POST['campo_ladoa'] > 0) && isset($_POST['campo_ladob']) && ($_POST['campo_ladob'] > 0)) {
            echo calcula_escreve_area_retangulo($_POST['campo_ladoa'], $_POST['campo_ladob']); 
        } else {
            echo "<script>alert('Informe um valor positivo')</script>";
        }
    ?>

    <form action="/exercs/04_exerc_area_retangulo.php" method="post">
        <label for="campo_ladoa">Tamanho Lado A:</label>
        <input type="number" id="campo_ladoa" name="campo_ladoa"><br>
        
        <label for="campo_ladob">Tamanho Lado B:</label>
        <input type="number" id="campo_ladob" name="campo_ladob"><br>

        <br><input type="submit" value="Calcular">
    </form>
</body>
</html>