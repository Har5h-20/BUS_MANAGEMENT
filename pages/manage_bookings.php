<?php include_once '../includes/header.php'; ?>

<main class="container">
    <h2>Manage Bookings</h2>

    <?php
    // Include the database connection file
    include_once '../includes/db_connect.php';

    // Check if the user is logged in
    if(isset($_SESSION['user_id'])) {
        // Retrieve user's bookings from the database based on the user ID
        $user_id = $_SESSION['user_id'];
        
        // Prepare and execute the SQL query to retrieve user's bookings
        $sql = "SELECT * FROM Bookings WHERE customer_id = ?";
        $stmt = $mysqli->prepare($sql);
        $stmt->bind_param("i", $user_id);
        $stmt->execute();
        $result = $stmt->get_result();

        // Check if bookings are found
        if($result->num_rows > 0) {
            // Display the bookings in a table
            echo '<div class="table-responsive">';
            echo '<table class="table table-striped">';
            echo '<thead>';
            echo '<tr>';
            echo '<th scope="col">Booking ID</th>';
            echo '<th scope="col">Travel Date</th>';
            echo '<th scope="col">Booking Date</th>';
            echo '<th scope="col">Seat Number</th>';
            echo '<th scope="col">Direction</th>';
            echo '<th scope="col">Total Fare</th>';
            echo '<th scope="col">Status</th>';
            echo '</tr>';
            echo '</thead>';
            echo '<tbody>';

            // Loop through each booking and display its details
            while($row = $result->fetch_assoc()) {
                echo '<tr>';
                echo '<td>' . $row['booking_id'] . '</td>';
                echo '<td>' . $row['travel_date'] . '</td>';
                echo '<td>' . $row['booking_date'] . '</td>';
                echo '<td>' . $row['seat_number'] . '</td>';
                echo '<td>' . ($row['direction'] == 0 ? 'Outbound' : 'Inbound') . '</td>';
                echo '<td>' . $row['total_fare'] . '</td>';
                echo '<td>' . ($row['status'] == 0 ? 'Pending' : 'Confirmed') . '</td>';
                echo '</tr>';
            }

            echo '</tbody>';
            echo '</table>';
            echo '</div>';
        } else {
            echo '<p>No bookings found.</p>';
        }
    } else {
        // If the user is not logged in, prompt them to login
        echo '<p>Please <a href="../pages/login.php">login</a> to view your bookings.</p>';
    }
    ?>

</main>

<?php include_once '../includes/footer.php'; ?>
