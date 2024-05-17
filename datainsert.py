from faker import Faker
import random
import mysql.connector

# Connect to the MySQL database
connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="qwerty",
    database="bus"
)
cursor = connection.cursor()

# Instantiate Faker
fake = Faker()

# Generate and insert sample data into the Customers table
for _ in range(10):  # Insert 10 customers
    full_name = fake.name()
    username = full_name.split()[0].lower() + str(random.randint(100, 999)) 
    email = fake.email()
    is_admin = random.choice([0, 1])
    password_hash = fake.password()
    address = fake.address()
    phone_number = fake.phone_number()[:15]

    insert_customer_query = """
        INSERT INTO Customers (full_name, username, email, is_admin, password_hash, address, phone_number)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """
    cursor.execute(insert_customer_query, (full_name, username, email, is_admin, password_hash, address, phone_number))
    connection.commit()

# Generate and insert sample data into the BusInfo table
for _ in range(5):  # Insert 5 buses
    bus_name = fake.company() + " Bus"
    total_seats = random.randint(20, 60)
    origin_city = fake.city()
    destination_city = fake.city()
    base_price = random.randint(500, 1000)

    insert_bus_query = """
        INSERT INTO BusInfo (bus_name, total_seats, origin_city, destination_city, base_price)
        VALUES (%s, %s, %s, %s, %s)
    """
    cursor.execute(insert_bus_query, (bus_name, total_seats, origin_city, destination_city, base_price))
    connection.commit()

# Generate and insert sample data into the Bookings table
for _ in range(20):  # Insert 20 bookings
    customer_id = random.randint(1, 10)  # Assuming there are 10 customers
    bus_id = random.randint(1, 5)  # Assuming there are 5 buses
    travel_date = fake.date_between(start_date="-1y", end_date="+1y")
    booking_date = fake.date_time_between(start_date="-1y", end_date="now")
    seat_number = random.randint(1, 60)  # Assuming maximum seats in a bus is 60
    direction = random.choice([0, 1])
    total_fare = random.randint(50, 500)  # Assuming fare range

    insert_booking_query = """
        INSERT INTO Bookings (customer_id, bus_id, travel_date, booking_date, seat_number, direction, total_fare, status)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """
    cursor.execute(insert_booking_query, (customer_id, bus_id, travel_date, booking_date, seat_number, direction, total_fare, 1))  # Assuming all bookings are confirmed
    connection.commit()

# Generate and insert sample data into the Payments table
for booking_id in range(1, 21):  # Assuming there are 20 bookings
    payment_date = fake.date_time_between(start_date="-1y", end_date="now")
    amount_paid = random.randint(50, 500)  # Assuming payment range
    status = random.choice([0, 1, -1])

    insert_payment_query = """
        INSERT INTO Payments (booking_id, payment_date, amount_paid, status)
        VALUES (%s, %s, %s, %s)
    """
    cursor.execute(insert_payment_query, (booking_id, payment_date, amount_paid, status))
    connection.commit()

# Generate and insert sample data into the Amenities table
for bus_id in range(1, 6):  # Assuming there are 5 buses
    has_ac = random.choice([True, False])
    has_wifi = random.choice([True, False])
    has_sleeper = random.choice([True, False])
    has_washroom = random.choice([True, False])
    has_meals = random.choice([True, False])

    insert_amenities_query = """
        INSERT INTO Amenities (bus_id, has_ac, has_wifi, has_sleeper, has_washroom, has_meals)
        VALUES (%s, %s, %s, %s, %s, %s)
    """
    cursor.execute(insert_amenities_query, (bus_id, has_ac, has_wifi, has_sleeper, has_washroom, has_meals))
    connection.commit()

# Generate and insert sample data into the Schedule table
for bus_id in range(1, 6):  # Assuming there are 5 buses
    arrival_time = fake.time()
    departure_time = fake.time()
    direction = random.choice([0, 1])

    insert_schedule_query = """
        INSERT INTO Schedule (bus_id, arrival_time, departure_time, direction)
        VALUES (%s, %s, %s, %s)
    """
    cursor.execute(insert_schedule_query, (bus_id, arrival_time, departure_time, direction))
    connection.commit()

# Generate and insert sample data into the TotalFare table
for bus_id in range(1, 6):  # Assuming there are 5 buses
    total_fare = random.randint(1000, 5000)  # Assuming fare range

    insert_total_fare_query = """
        INSERT INTO TotalFare (bus_id, total_fare)
        VALUES (%s, %s)
    """
    cursor.execute(insert_total_fare_query, (bus_id, total_fare))
    connection.commit()

# Close the database connection
connection.close()
