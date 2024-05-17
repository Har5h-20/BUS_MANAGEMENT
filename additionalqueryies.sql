-- Constants
SET @target_customer_id := 1;
SET @target_bus_id := 2;
SET @target_date := '2024-04-20';

-- Operations
-- 1. Retrieve all bookings made by a specific customer
SELECT * FROM Bookings WHERE customer_id = @target_customer_id;

-- 2. Retrieve all bookings for a specific bus on a given date
SELECT * FROM Bookings WHERE bus_id = @target_bus_id AND travel_date = @target_date;

-- 3. Calculate total revenue generated by the bus service
SELECT SUM(amount_paid) AS total_revenue FROM Payments;

-- 4. Retrieve the customer with the most bookings
SELECT customer_id, COUNT(*) AS num_bookings 
FROM Bookings 
GROUP BY customer_id 
ORDER BY num_bookings DESC 
LIMIT 1;

-- 5. Find the bus with the highest total fare
SELECT bus_id, total_fare 
FROM TotalFare 
ORDER BY total_fare DESC 
LIMIT 1;

-- 6. Retrieve the number of bookings made in the last month
SELECT COUNT(*) AS num_bookings 
FROM Bookings 
WHERE MONTH(booking_date) = MONTH(CURRENT_DATE) 
AND YEAR(booking_date) = YEAR(CURRENT_DATE);

-- 7. Calculate the average fare paid per booking
SELECT AVG(amount_paid) AS avg_fare FROM Payments;

-- 8. Find the top 5 busiest routes (origin-destination pairs) based on the number of bookings
SELECT origin_city, destination_city, COUNT(*) AS num_bookings 
FROM BusInfo 
JOIN Bookings ON BusInfo.bus_id = Bookings.bus_id 
GROUP BY origin_city, destination_city 
ORDER BY num_bookings DESC 
LIMIT 5;

-- 9. Retrieve all bookings with pending payments
SELECT * FROM Bookings WHERE booking_id NOT IN (SELECT booking_id FROM Payments);

-- 10. Find the percentage of seats filled for each bus
SELECT b.bus_id, 
       (COUNT(bd.seat_number) / b.total_seats) * 100 AS percent_filled 
FROM BusInfo b 
LEFT JOIN Bookings bd ON b.bus_id = bd.bus_id 
GROUP BY b.bus_id;

--11.Retrieve all bookings made by customers who are also administrators
SELECT * 
FROM Bookings 
WHERE customer_id IN (SELECT customer_id FROM Customers WHERE is_admin = 1);

--12. Retrieve all buses that offer meals as an amenity:
SELECT * 
FROM BusInfo 
WHERE bus_id IN (SELECT bus_id FROM Amenities WHERE has_meals = 1);

--13. Find the total number of bookings made on a specific travel date for each bus:
SELECT bus_id, COUNT(*) AS num_bookings 
FROM Bookings 
WHERE travel_date = @target_date 
GROUP BY bus_id;

--14. Calculate the total revenue generated by bookings made in the last month:
SELECT SUM(amount_paid) AS total_revenue 
FROM Payments 
WHERE MONTH(payment_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH) 
AND YEAR(payment_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH);

--15. Retrieve the customers who have made bookings with pending payments:
SELECT DISTINCT c.*
FROM Customers c
JOIN Bookings b ON c.customer_id = b.customer_id
LEFT JOIN Payments p ON b.booking_id = p.booking_id
WHERE p.payment_id IS NULL;

--16. Find the average number of seats filled per bus across all routes:
SELECT b.bus_id, AVG(IFNULL((COUNT(bd.seat_number) / b.total_seats), 0)) * 100 AS avg_percent_filled 
FROM BusInfo b 
LEFT JOIN Bookings bd ON b.bus_id = bd.bus_id 
GROUP BY b.bus_id;

--17. Retrieve the customers who have made the most expensive bookings (highest total fare):
SELECT c.*
FROM Customers c
JOIN Bookings b ON c.customer_id = b.customer_id
ORDER BY b.total_fare DESC 
LIMIT 1;

--18. Find the busiest day of the week for bookings:
SELECT DAYNAME(booking_date) AS day_of_week, COUNT(*) AS num_bookings 
FROM Bookings 
GROUP BY day_of_week 
ORDER BY num_bookings DESC 
LIMIT 1;

--19. Calculate the total fare revenue generated by each bus:
SELECT b.bus_id, SUM(bd.total_fare) AS total_fare_revenue 
FROM BusInfo b 
JOIN Bookings bd ON b.bus_id = bd.bus_id 
GROUP BY b.bus_id;

--20. Retrieve the bookings with the highest total fare on a specific date:
SELECT * 
FROM Bookings 
WHERE travel_date = @target_date 
ORDER BY total_fare DESC 
LIMIT 1;


 
 -- Triggers

-- Trigger to update TotalFare table when a booking is made
DELIMITER //
CREATE TRIGGER update_total_fare
AFTER INSERT ON Bookings
FOR EACH ROW
BEGIN
    UPDATE TotalFare
    SET total_fare = total_fare + NEW.total_fare
    WHERE bus_id = NEW.bus_id;
END;
//
DELIMITER ;

-- Trigger to update TotalFare table when a booking is canceled
DELIMITER //
CREATE TRIGGER update_total_fare_cancel
AFTER DELETE ON Bookings
FOR EACH ROW
BEGIN
    UPDATE TotalFare
    SET total_fare = total_fare - OLD.total_fare
    WHERE bus_id = OLD.bus_id;
END;
//
DELIMITER ;

-- Trigger to update status of Bookings table when payment is made
DELIMITER //
CREATE TRIGGER update_booking_status
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
    UPDATE Bookings
    SET status = 1
    WHERE booking_id = NEW.booking_id;
END;
//
DELIMITER ;

-- Trigger to update status of Bookings table when payment fails
DELIMITER //
CREATE TRIGGER update_booking_status_fail
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
    IF NEW.status = -1 THEN
        UPDATE Bookings
        SET status = -1
        WHERE booking_id = NEW.booking_id;
    END IF;
END;
//
DELIMITER ;

-- Trigger to enforce total_seats constraint
DELIMITER //
CREATE TRIGGER check_total_seats
BEFORE INSERT ON Bookings
FOR EACH ROW
BEGIN
    DECLARE booked_seats INT;
    SELECT COUNT(*) INTO booked_seats
    FROM Bookings
    WHERE bus_id = NEW.bus_id AND travel_date = NEW.travel_date;
    
    IF booked_seats >= (SELECT total_seats FROM BusInfo WHERE bus_id = NEW.bus_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bus is fully booked for the selected travel date.';
    END IF;
END;
//
DELIMITER ;



-- Trigger to update total_seats in BusInfo table when a new bus is added:

DELIMITER //
CREATE TRIGGER update_total_seats
AFTER INSERT ON BusInfo
FOR EACH ROW
BEGIN
    UPDATE BusInfo
    SET total_seats = NEW.total_seats
    WHERE bus_id = NEW.bus_id;
END;
//
DELIMITER ;
-- Trigger to update total_seats in BusInfo table when a bus's total_seats are updated:

DELIMITER //
CREATE TRIGGER update_total_seats_update
AFTER UPDATE OF total_seats ON BusInfo
FOR EACH ROW
BEGIN
    UPDATE BusInfo
    SET total_seats = NEW.total_seats
    WHERE bus_id = NEW.bus_id;
END;
//
DELIMITER ;
-- Trigger to update Amenities table when a new bus is added:

DELIMITER //
CREATE TRIGGER update_amenities
AFTER INSERT ON BusInfo
FOR EACH ROW
BEGIN
    INSERT INTO Amenities (bus_id, has_ac, has_wifi, has_sleeper, has_washroom, has_meals)
    VALUES (NEW.bus_id, FALSE, FALSE, FALSE, FALSE, FALSE);
END;
//
DELIMITER ;
--Trigger to update Amenities table when amenities are updated for a bus:

DELIMITER //
CREATE TRIGGER update_amenities_update
AFTER UPDATE ON Amenities
FOR EACH ROW
BEGIN
    IF OLD.has_ac != NEW.has_ac OR OLD.has_wifi != NEW.has_wifi OR OLD.has_sleeper != NEW.has_sleeper OR OLD.has_washroom != NEW.has_washroom OR OLD.has_meals != NEW.has_meals THEN
        UPDATE Amenities
        SET has_ac = NEW.has_ac,
            has_wifi = NEW.has_wifi,
            has_sleeper = NEW.has_sleeper,
            has_washroom = NEW.has_washroom,
            has_meals = NEW.has_meals
        WHERE bus_id = NEW.bus_id;
    END IF;
END;
//
DELIMITER ;



-- Update signup request status to Approved
UPDATE SignupRequests
SET status = 1
WHERE status = 0; -- Approve all pending signup requests

--Procedure to Retrieve Bookings by Customer ID:

DELIMITER //
CREATE PROCEDURE GetBookingsByCustomerID(IN target_customer_id INT)
BEGIN
    SELECT * FROM Bookings WHERE customer_id = target_customer_id;
END;
//
DELIMITER ;
--Procedure to Retrieve Bookings for a Specific Bus on a Given Date:

DELIMITER //
CREATE PROCEDURE GetBookingsByBusAndDate(IN target_bus_id INT, IN target_date DATE)
BEGIN
    SELECT * FROM Bookings WHERE bus_id = target_bus_id AND travel_date = target_date;
END;
//
DELIMITER ;
--Procedure to Calculate Total Revenue Generated by Bus Service:

DELIMITER //
CREATE PROCEDURE CalculateTotalRevenue()
BEGIN
    SELECT SUM(amount_paid) AS total_revenue FROM Payments;
END;
//
DELIMITER ;
--Procedure to Retrieve Number of Bookings Made in the Last Month:

DELIMITER //
CREATE PROCEDURE GetNumBookingsLastMonth()
BEGIN
    SELECT COUNT(*) AS num_bookings 
    FROM Bookings 
    WHERE MONTH(booking_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH) 
    AND YEAR(booking_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH);
END;
//
DELIMITER ;
--Procedure to Retrieve Customers Who Have Made Bookings with Pending Payments:

DELIMITER //
CREATE PROCEDURE GetCustomersWithPendingPayments()
BEGIN
    SELECT DISTINCT c.*
    FROM Customers c
    JOIN Bookings b ON c.customer_id = b.customer_id
    LEFT JOIN Payments p ON b.booking_id = p.booking_id
    WHERE p.payment_id IS NULL;
END;
//
DELIMITER ;