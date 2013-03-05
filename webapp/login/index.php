<?php 

include("login.php");
$username = $_POST["username"];
$password = $_POST["password"];

$login = new Login();
$response = $login->loginAttempt($username, $password);

echo json_encode($response);

?>
