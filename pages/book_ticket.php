<?php include_once '../includes/header.php'; ?>

<main class="container">
    <div class="card mt-5 mb-3">
        <div class="card-body">
            <h2 class="card-title">Book Ticket</h2>
            
            <!-- Booking form -->
            <form action="../actions/book_ticket_action.php" method="POST">
                <div class="mb-3">
                    <label for="customer_name" class="form-label">Customer Name</label>
                    <input type="text" class="form-control" id="customer_name" name="customer_name" required>
                </div>
                <div class="mb-3">
                    <label for="bus_id" class="form-label">Select Bus</label>
                    <select class="form-select" id="bus_id" name="bus_id" required>
                        <?php
                        // Include the database connection file
                        include_once '../includes/db_connect.php';

                        // Retrieve available buses from the database
                        $sql = "SELECT bus_id, bus_name, base_price FROM BusInfo";
                        $result = $mysqli->query($sql);

                        // Check if buses are found
                        if ($result->num_rows > 0) {
                            // Loop through each row to display bus options in the dropdown
                            while ($row = $result->fetch_assoc()) {
                                echo '<option value="' . $row['bus_id'] . '" data-base-price="' . $row['base_price'] . '">' . $row['bus_name'] . '</option>';
                            }
                        } else {
                            echo '<option value="">No buses available</option>';
                        }
                        ?>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="travel_date" class="form-label">Travel Date</label>
                    <input type="date" class="form-control" id="travel_date" name="travel_date" required>
                </div>
                <div class="mb-3">
                    <label for="seat_number" class="form-label">Seat Number</label>
                    <input type="number" class="form-control" id="seat_number" name="seat_number" min="1" required>
                </div>
                <div class="mb-3">
                    <label for="total_fare" class="form-label">Total Fare</label>
                    <input type="text" class="form-control" id="total_fare" name="total_fare" readonly required>
                </div>
                <!-- Hidden input fields for additional data -->
                <input type="hidden" name="customer_id" value="<?php echo $_SESSION['user_id']; ?>">
                <input type="hidden" name="booking_date" value="<?php echo date('Y-m-d'); ?>">
                <input type="hidden" name="direction" value="0"> <!-- Assuming outbound direction -->
                <input type="hidden" name="status" value="0"> <!-- Initial status is pending -->
                
                <button type="submit" class="btn btn-primary" name="book_ticket">Book Ticket</button>
            </form>
            <!-- End of Booking form -->

        </div>
    </div>
</main>

<?php include_once '../includes/footer.php'; ?>

<script>
// Function to calculate total fare based on selected bus and number of seats
function calculateTotalFare() {
    var busId = document.getElementById('bus_id').value;
    var basePrice = document.querySelector('option[value="' + busId + '"]').getAttribute('data-base-price');
    var seatNumber = document.getElementById('seat_number').value;
    var totalFare = basePrice * seatNumber;
    document.getElementById('total_fare').value = totalFare.toFixed(2);
}

// Event listener for changes in bus selection and seat number
document.getElementById('bus_id').addEventListener('change', calculateTotalFare);
document.getElementById('seat_number').addEventListener('input', calculateTotalFare);

// Calculate initial total fare on page load
calculateTotalFare();
</script>
