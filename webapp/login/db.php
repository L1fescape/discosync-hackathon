<?php

class DB {
	// Connection credentials
	private $db_user = "USERNAME";
	private $db_pass = "PASS";
	private $db_name = "DB";

	public $conn;

	// Make the connection
	public function connect() {
		$this->conn = mysql_connect('localhost', $this->db_user, $this->db_pass) or die ("Could not connect to mysql server.");
		mysql_select_db($this->db_name) or die ("Could not connect to database.");
	}

	// Close the connection
	public function close() {
		mysql_close($this->conn);
	}
}

?>
