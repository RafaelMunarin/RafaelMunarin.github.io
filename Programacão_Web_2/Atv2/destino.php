<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PW2 - Exemplo HTTP + PHP</title>
</head>
<!-- teste de ajuste do repositóio pelo vscode  -->
<body>
    <h1>PW2 - Exemplo requisições HTTP + PHP - Response</h1>
    <hr>
    <pre><?php var_dump($_REQUEST); ?></pre>
    <hr>
    <pre><?php 
        echo $_SERVER["REQUEST_METHOD"];
        echo "<br>"; 
        var_export(apache_request_headers());
    ?></pre>
    <a href="index.php">Voltar</a>
</body>
</html>