# Bus Booking System

This is a simple web application for booking bus tickets.

## Features

- User authentication (login and registration)
- Dashboard to view booking history and manage bookings
- Ability to book tickets for available buses
- User profile management

## Technologies Used

- HTML/CSS/JavaScript
- PHP
- MySQL
- Bootstrap 5

## Installation

1. Clone the repository to your local machine:

```
git clone <repository-url>
```

2. Import the included SQL file (`database.sql`) into your MySQL database to create the necessary tables.

3. Update the database connection details in the `includes/db_connect.php` file with your MySQL credentials.

4. Ensure that you have PHP and a web server (e.g., Apache) installed on your machine.

5. Navigate to the project directory in your terminal and start the PHP server:

```
php -S localhost:8000
```

6. Open your web browser and go to `http://localhost:8000` to access the application.

## Usage

- Visit the login page (`login.php`) to log in to your account.
- If you don't have an account, you can register by visiting the registration page (`register.php`).
- After logging in, you will be redirected to the dashboard (`dashboard.php`) where you can view your booking history and manage bookings.
- To book a ticket, visit the book ticket page (`book_ticket.php`) and follow the instructions.
- You can also view and update your profile information on the profile page (`profile.php`).
