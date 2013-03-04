<?php 

include("login.php");
include("text.php");

$method = $_POST["method"];

if ($method == "login") {
	$username = $_POST["username"];
	$password = $_POST["password"];

	$login = new Login();
	$response = $login->loginAttempt($username, $password);

	echo json_encode($response);
}

?>
