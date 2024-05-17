<?php include_once '../includes/header.php'; ?>

<main class="container">
    <h2>Login</h2>
    
    <!-- Login form -->
    <form action="../actions/login_action.php" method="POST">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <button type="submit" class="btn btn-primary" name="login">Login</button>
    </form>
    <!-- End of Login form -->

</main>

<?php include_once '../includes/footer.php'; ?>
