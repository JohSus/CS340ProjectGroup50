
SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;

--
-- Table structure for table Customers
--

CREATE OR REPLACE TABLE Customers (
  customer_id int NOT NULL AUTO_INCREMENT,
  customer_name varchar(50) NOT NULL,
  phone_number varchar(15) NOT NULL,
  PRIMARY KEY (customer_id)
);

-- --------------------------------------------------------

--
-- Table structure for table Dietary_Restrictions
--

CREATE OR REPLACE TABLE Dietary_Restrictions (
  restriction_id int NOT NULL AUTO_INCREMENT,
  description varchar(255) NOT NULL,
  PRIMARY KEY (restriction_id)
);

-- --------------------------------------------------------
--
-- Table structure for table Customers_has_Dietary_Restrictions
--

CREATE OR REPLACE TABLE Customers_has_Dietary_Restrictions (
  customer_id int,
  restriction_id int,
  PRIMARY KEY (customer_id, restriction_id),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) 
  -- When either a dietary restriction or a customer is deleted, we want to delete this relationship
  ON DELETE CASCADE, 
  FOREIGN KEY (restriction_id) REFERENCES Dietary_Restrictions(restriction_id)
  ON DELETE CASCADE
);



-- --------------------------------------------------------
--
-- Table structure for table Dishes
--

CREATE OR REPLACE TABLE Dishes (
  dish_id int NOT NULL AUTO_INCREMENT,
  dish_name varchar(45) NOT NULL,
  price decimal(4,2) NOT NULL,
  PRIMARY KEY (dish_id)
);

-- --------------------------------------------------------

--
-- Table structure for table Orders
--

CREATE OR REPLACE TABLE Orders (
  order_id int NOT NULL AUTO_INCREMENT,
  time datetime NOT NULL,
  customer_id int,
  dish_quantity int NOT NULL DEFAULT 1,
  PRIMARY KEY (order_id),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
  -- if a customer is deleted, we still want to have the order logged
  ON DELETE SET NULL
);

-- --------------------------------------------------------

--
-- Table structure for table Orders_has_Dishes
--

CREATE OR REPLACE TABLE Orders_has_Dishes (
  order_id int,
  dish_id int,
  PRIMARY KEY (order_id, dish_id),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id)
  ON DELETE CASCADE,
  FOREIGN KEY (dish_id) REFERENCES Dishes(dish_id)
  ON DELETE CASCADE
);

-- --------------------------------------------------------

--
-- Table structure for table Ratings
--

CREATE OR REPLACE TABLE Ratings (
  rating_id int NOT NULL AUTO_INCREMENT,
  rating tinyint(5) NOT NULL,
  customer_id int,
  dish_id int NOT NULL,
  PRIMARY KEY (rating_id),
  -- when a customer is deleted, the ratings they gave should stay
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
  ON DELETE SET NULL,
  -- when a dish is deleted, its rating should also be deleted
  FOREIGN KEY (dish_id) REFERENCES Dishes(dish_id)
  ON DELETE CASCADE
);

-- INSERT INTO statements

INSERT INTO Customers (customer_id, customer_name, phone_number)
VALUES (1, 'John Mayer', '(212) 555-1234'),
(2, 'Ethan Wright', '(312) 555-5678'),
(3, 'Samantha Lee', '(415) 555-9012'),
(4, 'Alexander Patel', '(305) 555-6789'),
(5, 'Olivia Kim', '(206) 555-6789');


INSERT INTO Orders (order_id, time, customer_id)
VALUES (1, '2023-05-02 10:15:30', 1),
(2, '2023-05-01 10:20:45', 3),
(3, '2023-04-30 09:00:00', 3),
(4, '2023-04-29 13:59:59', 4);

INSERT INTO Dishes (dish_id, dish_name, price)
VALUES (1, 'Hamburger', 3.50),
(2, 'Cheeseburger', 3.70),
(3, 'Fries', 2.00),
(4, 'Tater Tots', 2.50);

INSERT INTO Orders_has_Dishes (order_id, dish_id)
VALUES (1, 1),
(2, 2),
(3, 1),
(3, 3),
(4, 2);

INSERT INTO Ratings (rating_id, rating, customer_id, dish_id)
VALUES (1, 5, 1, 1),
(2, 4, 3, 2),
(3, 5, 3, 1),
(4, 3, 4, 2);

INSERT INTO Customers_has_Dietary_Restrictions (customer_id, restriction_id)
VALUES (1, 2),
(1, 3),
(2, 3),
(3, 3);

INSERT INTO Dietary_Restrictions (restriction_id, description)
VALUES (1, 'Vegetarian'),
(2, 'Gluten-free'),
(3, 'Dairy-free');


SET FOREIGN_KEY_CHECKS = 1;
