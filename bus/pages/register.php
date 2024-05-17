<?php include_once '../includes/header.php'; ?>

<main class="container">
    <div class="card mt-5 mb-3">
        <div class="card-body">
            <h2 class="card-title">Register</h2>
            
            <!-- Registration form -->
            <form action="../actions/register_action.php" method="POST">
                <div class="mb-3">
                    <label for="full_name" class="form-label">Full Name</label>
                    <input type="text" class="form-control form-control-sm" id="full_name" name="full_name" required>
                </div>
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control form-control-sm" id="username" name="username" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email Address</label>
                    <input type="email" class="form-control form-control-sm" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control form-control-sm" id="password" name="password" required>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" class="form-control form-control-sm" id="address" name="address" required>
                </div>
                <div class="mb-3">
                    <label for="phone_number" class="form-label">Phone Number</label>
                    <input type="text" class="form-control form-control-sm" id="phone_number" name="phone_number" required>
                </div>
                <button type="submit" class="btn btn-primary btn-sm" name="register">Register</button>
            </form>
            <!-- End of Registration form -->

        </div>
    </div>
</main>

<?php include_once '../includes/footer.php'; ?>
