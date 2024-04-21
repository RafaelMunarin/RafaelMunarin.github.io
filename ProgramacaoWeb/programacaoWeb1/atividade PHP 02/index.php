<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Atividade PHP 2</title>
</head>
<body>
    <?php
        function verifica_divisivel($numero) {
            if(fmod($numero, 2) == 0) {
                return 'Valor divisível por 2';
            } else {
                return 'Valor não é divisível por 2';
            }
        } 
        if(isset($_POST['campo_numero']) && isset($_POST['campo_numero']) > 0) {
            echo "<p>" . verifica_divisivel($_POST['campo_numero']) . "</p>";    
        } else {
            echo "<script>alert('Informe um número positivo')</script>";
        }
    ?>
    <form action="/exercs/02_exerc_div_2.php" method="post">
        <label for="campo_numero">Número:</label>
        <input type="number" id="campo_numero" name="campo_numero"><br>
        
        <br><input type="submit" value="Verificar">
    </form>
</body>
</html>