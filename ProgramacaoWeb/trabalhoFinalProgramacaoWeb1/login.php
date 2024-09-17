<?php
session_start();

require_once 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['username']) && isset($_POST['password'])) {
        $username = $_POST['username'];
        $password = $_POST['password'];

        $_SESSION["inicioSessao"] = date('Y-m-d H:i:s');
        $_SESSION["requisicaoFinal"] = date('Y-m-d H:i:s');
        $_SESSION["tempoSessao"] = time();

        $sql = "SELECT * FROM users WHERE username = :username AND password = :password";
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $password);
        $stmt->execute();

        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user) {
            if ($username == $user['username'] && $password == $user['password']) {
                $_SESSION['username'] = $username;
                header("Location: cadastro.php");
                exit();
            } else {
                echo "Credenciais inválidas. Por favor, verifique suas informações.";
                header("Refresh: 5; url=index.html");
                exit();
            }
        } else {
            echo "Usuário não encontrado. Por favor, verifique suas informações.";
            header("Refresh: 5; url=index.html");
            exit();
        }
    } else {
        echo "Informações de login ausentes.";
        header("Refresh: 5; url=index.html");
        exit();
    }
}
?>
