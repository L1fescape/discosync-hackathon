<?php

// Import database connection
include_once("db.php");

class Login {
	public function loginAttempt($username, $password) {
		$db = new DB();
		$db->connect();

		// Response for incorrect Username
		$response = array(
			"error" => True,
			"message" => "User does not exist."
		);

		$query = "SELECT * FROM users WHERE `username`='$username';";

		$result = mysql_query($query, $db->conn);

		while ($row = mysql_fetch_array($result)) {
			if ($password == $row["password"]) {
				$response = array(
					"error" => False,
					"genre" => $row["genre"],
					"songurl" => $row["songurl"]
				);
			}
			else {
				$response = array(
					"error" => True,
					"message" => "Incorrect Password."
				);
			}
		}

		// Close database connection
		$db->close();

		return $response;
	}

}


?>
