<?php include_once '../includes/header.php'; ?>

<main class="container">
    <h2>User Profile</h2>

    <?php
    // Include the database connection file
    include_once '../includes/db_connect.php';

    // Check if the user is logged in
    if(isset($_SESSION['user_id'])) {
        // Retrieve user data from the database based on the user ID
        $user_id = $_SESSION['user_id'];
        
        // Prepare and execute the SQL query to retrieve user data
        $sql = "SELECT * FROM Customers WHERE customer_id = ?";
        $stmt = $mysqli->prepare($sql);
        $stmt->bind_param("i", $user_id);
        $stmt->execute();
        $result = $stmt->get_result();

        // Check if user data is found
        if($result->num_rows == 1) {
            // Fetch user data as an associative array
            $user_data = $result->fetch_assoc();

            // Display user information
            echo '<p>USER ID: '. $user_data['customer_id']. '</p>';
            echo '<p><strong>Full Name:</strong> ' . $user_data['full_name'] . '</p>';
            echo '<p><strong>Username:</strong> ' . $user_data['username'] . '</p>';
            echo '<p><strong>Email:</strong> ' . $user_data['email'] . '</p>';
            echo '<p><strong>Address:</strong> ' . $user_data['address'] . '</p>';
            echo '<p><strong>Phone Number:</strong> ' . $user_data['phone_number'] . '</p>';
        } else {
            echo '<p>User data not found.</p>';
        }
    } else {
        // If the user is not logged in, prompt them to login
        echo '<p>Please <a href="../pages/login.php">login</a> to view your profile.</p>';
    }
    ?>

</main>

<?php include_once '../includes/footer.php'; ?>
