<?php
include_once("bd/pdo.php");

session_start();

if (isset($_SESSION['user'])) {
    header('Location: /pessoa');
    exit();
}


if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    $sql = "SELECT * FROM tbpessoa WHERE pesemail = ? AND pespassword = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$email, $password]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user) {
        $_SESSION['user'] = $user['pesnome'];
        $_SESSION['password'] = $user['pespassword'];
        $_SESSION['login_time'] = time();
        $_SESSION['last_req_time'] = time();
        $_SESSION['session_time'] = 0;

        setcookie('user', $user['pesnome'], (time() + 60 * 5), '/');
        setcookie('login_time', time(), (time() + 60 * 5), '/');
        header('Location: /pessoa');
        exit();
    } else {
        $error = 'E-Mail ou Senha incorrentos';
    }
}
?>

<!DOCTYPE html>
<html>

<head>
    <title>Login</title>
</head>

<body>
    <?php if (isset($error)) : ?>
        <div><?php echo $error; ?></div>
    <?php endif; ?>

    <form method="post">
        <div>
            <label for="email">E-Mail:</label>
            <input type="text" id="email" name="email">
        </div>
        <div>
            <label for="password">Senha:</label>
            <input type="password" id="password" name="password">
        </div>
        <div>
            <button type="submit">Login</button>
        </div>
        <div>
            <a href="cadastropessoa.html">Cadastrar Pessoa</a>
        </div>
    </form>
</body>

</html>