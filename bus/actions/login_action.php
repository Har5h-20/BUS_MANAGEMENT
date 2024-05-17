<?php
include_once '../includes/db_connect.php';

// Start the session
session_start();

if(isset($_POST['login'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Validate input

    $sql = "SELECT * FROM Customers WHERE username = ?";
    $stmt = $mysqli->prepare($sql);
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if($result->num_rows == 1) {
        $user = $result->fetch_assoc();
        if(password_verify($password, $user['password_hash'])) {
            // Start a new session if not already started
            if (session_status() == PHP_SESSION_NONE) {
                session_start();
            }
            // Set the user ID in the session
            $_SESSION['user_id'] = $user['customer_id'];
            // make a alreat for userid
            echo "<script>alert('".$_SESSION['user_id']."')</script>";
            header("Location: ../pages/dashboard.php");
            exit();
        } else {
            $_SESSION['error'] = "Invalid username or password";
            header("Location: ../pages/login.php");
            exit();
        }
    } else {
        $_SESSION['error'] = "Invalid username or password";
        header("Location: ../pages/login.php");
        exit();
    }
} else {
    header("Location: ../pages/login.php");
    exit();
}
?>
