<?php
include_once '../includes/db_connect.php';
session_start();

if(isset($_POST['book_ticket'])) {
    $customer_id = $_SESSION['user_id']; // Assuming user is logged in
    $bus_id = $_POST['bus_id'];
    $travel_date = $_POST['travel_date'];
    $booking_date = date('Y-m-d'); // Current date
    $seat_number = $_POST['seat_number'];
    $direction = $_POST['direction'];
    $total_fare = $_POST['total_fare'];
    $status = 0; // Initial status is pending


    // Insert booking data into the database
    $sql = "INSERT INTO Bookings (customer_id, bus_id, travel_date, booking_date, seat_number, direction, total_fare, status)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $mysqli->prepare($sql);
    $stmt->bind_param("iissiiii", $customer_id, $bus_id, $travel_date, $booking_date, $seat_number, $direction, $total_fare, $status);
    if($stmt->execute()) {
        // Booking successful
        $_SESSION['success'] = "Booking successful!";
        header("Location: ../pages/dashboard.php");
        exit();
    } else {
        // Booking failed
        $_SESSION['error'] = "Booking failed. Please try again.";
        header("Location: ../pages/book_ticket.php");
        exit();
    }
} else {
    // Redirect back to the booking page if form is not submitted
    header("Location: ../pages/book_ticket.php");
    exit();
}
?>
