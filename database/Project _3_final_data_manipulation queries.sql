-- Customers

-- get all Customers
SELECT customer_id AS customerID, customer_name AS customerName, phone_number AS phoneNumber 
FROM Customers;

-- get all Customers that have the name "Olivia Kim". We can replace "Olivia Kim" with any customer name.
SELECT customer_id AS customerID, customer_name AS customerName, phone_number AS phoneNumber 
FROM Customers 
WHERE customerName = 'Olivia Kim';

-- insert in Customers table 
INSERT INTO Customers (customer_id, customer_name, phone_number)
VALUES (:customer_id_Input, :customer_name_Input, :phone_number_Input);

INSERT INTO Customers_has_Dietary_Restrictions (customer_id)
VALUES (:customer_id_Input);


-- update in Customers table
UPDATE Customers 
SET customer_name = :customer_name_Input, phone_number = :phone_number_Input 
WHERE customer_id = :customer_id_from_update_form;

-- delete in Customers table
DELETE FROM Customers 
WHERE customer_id = :customer_id_Input;

------------------------------------------------------------------------------------------------------

-- Orders

-- get all Orders
SELECT order_id AS orderID, time 
FROM Orders;

-- get all Orders of Hamburgers
SELECT Orders.order_id AS orderID, Customers.customer_name AS customerName, Dishes.dish_name AS dishName
FROM Orders
JOIN Customers on Orders.customer_id = Customers.customer_id 
JOIN Orders_has_Dishes on Orders.order_id = Orders_has_Dishes.order_id
JOIN Dishes on Orders_has_Dishes.dish_id = Dishes.dish_id
WHERE Dishes.dish_name = "Hamburger"
ORDER BY Dishes.dish_name;

-- insert in Orders table 
INSERT INTO Orders (order_id, time)
VALUES (:order_id_Input, :time_Input);

INSERT INTO Orders_has_Dishes (order_id)
VALUES (:order_id_Input);

-- update in Orders table
UPDATE Orders SET time = :time_Input 
WHERE order_id = :order_id_from_update_form;

-- delete in Orders table
DELETE FROM Orders 
WHERE order_id = :order_id_Input;

------------------------------------------------------------------------------------------------------

-- Orders_has_Dishes

-- get all Orders_has_Dishes
SELECT order_id AS orderID, dish_id AS dishID time 
FROM Orders_has_Dishes;

-- get all Orders_has_Dishes with Customer and Dish name
SELECT Orders_has_Dishes.order_id AS orderID, Customers.customer_name as customerName, Dishes.dish_name as dishName
FROM Orders_has_Dishes
JOIN Orders ON Orders_has_Dishes.order_id = Orders.order_id
JOIN Customers ON Orders.customer_id = Customers.customer_id
JOIN Dishes ON Orders_has_Dishes.dish_id = Dishes.dish_id
ORDER BY Orders_has_Dishes.order_id ASC;

-- insert in Orders_has_Dishes table 
INSERT INTO Orders_has_Dishes (order_id, dish_id)
VALUES (:order_id_Input, :dish_id_Input);

-- update in Orders_has_Dishes table
UPDATE Orders_has_Dishes 
SET order_id = :order_id_Input 
WHERE dish_id = :dish_id_from_update_form;

UPDATE Orders_has_Dishes 
SET dish_id = :dish_id_Input 
WHERE order_id = :order_id_from_update_form;

-- delete in Orders_has_Dishes table
DELETE FROM Orders_has_Dishes 
WHERE order_id = :order_id_Input 
AND dish_id = :dish_id_Input;


------------------------------------------------------------------------------------------------------

-- Dishes

-- get all Dishes
SELECT dish_id as dishID, dish_name as dishName, price 
FROM Dishes;

-- get the average rating of every dish
SELECT Dishes.dish_id as dishID, Dishes.dish_name as dishName, Dishes.price as dishPrice, AVG(Ratings.rating) as averageRating 
FROM Dishes
LEFT JOIN Ratings ON Ratings.dish_id = Dishes.dish_id
GROUP BY dish_name
ORDER BY dish_name ASC;


-- insert in Dishes table 
INSERT INTO Dishes (dish_id, dish_name, price)
VALUES (:dish_id, :dish_name_Input, :dish_id_price);

INSERT INTO Orders_has_Dishes (dish_id)
VALUES (:dish_id_Input)

-- update in Dishes table
UPDATE Dishes 
SET dish_name = :dish_name_Input, price = :price_Input 
WHERE dish_id = :dish_id_from_update_form;

-- delete in Dishes table
DELETE FROM Dishes 
WHERE dish_id = :dish_id_Input;

------------------------------------------------------------------------------------------------------

-- Ratings

-- get all Ratings
SELECT rating_id as ratingID, rating, customer_id as customerID, dish_id as dishID FROM Ratings;

-- get all Ratings of all Dishes
SELECT Dishes.dish_name as dishName, Ratings.rating as rating 
FROM Ratings
JOIN Dishes ON Ratings.dish_id = Dishes.dish_id
ORDER BY Ratings.rating DESC;

-- insert in Ratings table 
INSERT INTO Ratings (rating_id, rating, customer_id, dish_id)
VALUES (:rating_id_Input, :rating_Input, :customer_id_Input, :dish_id_Input);

-- update in Ratings table
UPDATE Ratings 
SET rating = :rating_Input, customer_id = :customer_id_Input, dish_id = :dish_id_Input 
WHERE rating_id = :rating_id_from_update_form;

-- delete in Ratings table
DELETE FROM Ratings 
WHERE rating_id = :rating_id_Input;

------------------------------------------------------------------------------------------------------

-- Customers_has_Dietary_Restrictions

-- get all Customers_has_Dietary_Restrictions
SELECT customer_id as customerID, restriction_id as restrictionID 
FROM Customers_has_Dietary_Restrictions;

-- get all Customers_has_Dietary_Restrictions, customer names, and restriction descriptions
SELECT Customers.customer_name as customerName, Dietary_Restrictions.description as dietaryRestriction
FROM Customers_has_Dietary_Restrictions
JOIN Customers ON Customers_has_Dietary_Restrictions.customer_id = Customers.customer_id
JOIN Dietary_Restrictions ON Customers_has_Dietary_Restrictions.restriction_id = Dietary_Restrictions.restriction_id
ORDER BY Customers.customer_name ASC;

-- insert in Customers_has_Dietary_Restrictions table 
INSERT INTO Customers_has_Dietary_Restrictions (customer_id, restriction_id)
VALUES (:customer_id_Input, :restriction_id_Input);

-- update in Customers_has_Dietary_Restrictions table
UPDATE Customers_has_Dietary_Restrictions 
SET customer_id = :customer_id_Input 
WHERE restriction_id = :restriction_id_Input;

-- delete in Customers_has_Dietary_Restrictions table
DELETE FROM Customers_has_Dietary_Restrictions 
WHERE customer_id = :customer_id_Input 
AND restriction_id = :restriction_id_Input;

------------------------------------------------------------------------------------------------------

-- Dietary_Restrictions

-- get all Dietary_Restrictions
SELECT restriction_id as restrictionID, description 
FROM Dietary_Restrictions;

-- insert in Dietary_Restrictions table 
INSERT INTO Dietary_Restrictions (restriction_id, description)
VALUES (:restriction_id_Input, :description_Input);

INSERT INTO Customers_has_Dietary_Restrictions (restriction_id)
VALUES (:restriction_id_Input)

-- update in Dietary_Restrictions table
UPDATE Dietary_Restrictions 
SET description = :description_Input 
WHERE restriction_id = :restriction_id_Input;

-- delete in Dietary_Restrictions table
DELETE FROM Dietary_Restrictions 
WHERE restriction_id = :restriction_id_Input;


