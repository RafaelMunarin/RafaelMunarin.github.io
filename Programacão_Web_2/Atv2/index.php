<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PW2 - Exemplo HTTP + PHP</title>
</head>
<body>
    <h1>PW2 - Exemplo requisições HTTP + PHP - Request</h1>
    <hr>
    <form method="POST" action="destino.php">
        <label for="inome">Nome: </label>
        <input type="text" name="inome" id="inome" placeholder="Informe seu nome">
        <br>
        <label for="ifone">Fone: </label>
        <input type="text" name="ifone" id="ifone" placeholder="(99) 9999-9999">
        <br>
        <label for="iemail">E-mail: </label>
        <input type="text" name="iemail" id="iemail" placeholder="Informe seu e-mail">
        <br>
        <label for="tmensagem">Mensagem: </label>
        <textarea name="tmensagem" id="tmensagem" placeholder="Qual sua mensagem"></textarea>
        <br>
        <br>
        <button type="submit" name="benviar" id="benviar">Enviar</button>
    </form>
</body>
</html>

<?php

require __DIR__ . '/vendor/autoload.php';

use Monolog\Level;
use Monolog\Logger;
use Monolog\Handler\StreamHandler;

// create a log channel
$log = new Logger('name');
$log->pushHandler(new StreamHandler('logApp.log', Level::Warning));

// add records to the log
$log->warning('Alerta Aplication');
$log->error('Error Aplication'); 

?>