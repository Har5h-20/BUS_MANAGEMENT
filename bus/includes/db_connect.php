<?php
// Database configuration
$db_host = 'localhost';
$db_username = 'root'; // Your database username
$db_password = ''; // Your database password
$db_name = 'bus'; // Your database name

// Create a connection to the database
$mysqli = new mysqli($db_host, $db_username, $db_password, $db_name);

// Check connection
if ($mysqli->connect_errno) {
    die("Failed to connect to MySQL: " . $mysqli->connect_error);
}
?>
