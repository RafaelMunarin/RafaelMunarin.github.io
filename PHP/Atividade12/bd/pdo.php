<?php
    $host = 'localhost';
    $dbname = 'vitorhugo';
    $user = 'postgres';
    $password = '1234';

    try {
        $pdo = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
    } catch (PDOException $e) {
        echo "Connection failed: " . $e->getMessage();
    }
?>