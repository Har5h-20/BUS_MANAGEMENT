<?php
session_start();

// If the user is already logged in, redirect them to the dashboard
if(isset($_SESSION['user_id'])) {
    header("Location: ./pages/dashboard.php");
    exit();
}

// If the user is not logged in, redirect them to the login page
header("Location: ./pages/login.php");
exit();
?>
