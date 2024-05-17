<?php
include_once '../includes/db_connect.php';

if(isset($_POST['register'])) {
    $full_name = $_POST['full_name'];
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $address = $_POST['address'];
    $phone_number = $_POST['phone_number'];

    // Validate input

    $password_hash = password_hash($password, PASSWORD_DEFAULT);

    $sql = "INSERT INTO Customers (full_name, username, email, password_hash, address, phone_number)
            VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = $mysqli->prepare($sql);
    $stmt->bind_param("ssssss", $full_name, $username, $email, $password_hash, $address, $phone_number);
    if($stmt->execute()) {
        header("Location: ../pages/login.php");
        exit();
    } else {
        $_SESSION['error'] = "Registration failed. Please try again.";
        header("Location: ../pages/register.php");
        exit();
    }
} else {
    header("Location: ../pages/register.php");
    exit();
}
?>
