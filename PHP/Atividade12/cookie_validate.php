<?php
    if(!isset($_COOKIE["user"]) or !isset($_COOKIE["login_time"])) {
        echo "Os dados da sessão foram perdidos";
    }
?>