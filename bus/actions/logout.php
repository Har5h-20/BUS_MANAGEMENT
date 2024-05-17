<?php
session_start();
session_unset(); // Unset all session variables
session_destroy(); // Destroy the session data

// Redirect to the index page
header("Location: ../");
exit(); // Ensure script execution stops after redirect
?>
