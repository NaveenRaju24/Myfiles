


use PracticeDB; -- using the database to work on

-- creating sample tables 
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    signup_date DATE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Customers VALUES
(1, 'Naveen', 'Dallas', '2023-01-10'),
(2, 'Priya', 'Houston', '2023-02-15'),
(3, 'Kiran', 'Austin', '2023-03-01'),
(4, 'Swathi', 'Dallas', '2023-04-25'),
(5, 'Ravi', 'Dallas', '2023-05-10'),
(6, 'Anjali', 'Houston', '2023-07-12'),
(7, 'Deepak', 'Austin', '2023-06-08'),
(8, 'Meena', 'Houston', '2023-08-01'),
(9, 'Karthik', 'Austin', '2023-08-18');

INSERT INTO Products VALUES
(101, 'Laptop', 899.99),
(102, 'Headphones', 199.50),
(103, 'Mouse', 29.99),
(104, 'Keyboard', 49.99),
(105, 'Monitor', 159.99),
(106, 'USB Cable', 12.99),
(107, 'Webcam', 89.00),
(108, 'Charger', 34.50),
(109, 'Tablet', 499.00);

INSERT INTO Orders VALUES
(1001, 1, 101, 1, '2023-05-01'),
(1002, 1, 103, 2, '2023-05-03'),
(1003, 2, 102, 1, '2023-06-10'),
(1004, 3, 104, 1, '2023-07-12'),
(1005, 4, 101, 1, '2023-07-15'),
(1006, 5, 105, 1, '2023-09-01'),
(1007, 5, 106, 2, '2023-09-02'),
(1008, 6, 107, 1, '2023-09-03'),
(1009, 7, 108, 3, '2023-09-05'),
(1010, 8, 101, 1, '2023-09-06'),
(1011, 8, 102, 1, '2023-09-07'),
(1012, 9, 109, 1, '2023-09-08'),
(1013, 9, 104, 2, '2023-09-09'),
(1014, 5, 103, 1, '2023-09-10'),
(1015, 5, 102, 1, '2023-09-11');





-- Note- comments in SQL = --(single line) or /* xyz.. */(multiple lines)

-- Lets do practice 

--Select--
Select * from Customers;                          --selects all the data
Select * from Products;
Select * from Orders;
Select name, city from Customers;                 --to select specific columns 
Select price from Products;
Select distinct city from Customers;              -- remmoves duplicates 

--Where(to filter rows)--
Select * from Customers Where city='Dallas';                  -- filter rows with condition 
Select * from Products Where price>100;
Select * from Orders Where quantity<>1;                       -- Not equals to = <> or !=
Select * from Products Where price>30 AND product_id>=102;    -- AND, OR
Select * from Customers Where city IN ('Dallas', 'Houston')   -- IN
Select * from Customers Where name LIKE 'N%'                  -- Like (pattern match)

--Order by( to sort in ASC or DESC order) 
SELECT * FROM Products                    -- Note = ASC is default 
ORDER BY price ASC;                       -- ASC = low to high/Bottom to top , DESC = high to low/top to bottom
SELECT * FROM Customers
ORDER BY signup_date DESC;                -- Sort Customers by Signup Date (Newest First-so DESC as newest date will be higher right)
SELECT * FROM Orders
ORDER BY quantity DESC, order_date ASC;   -- Sort Orders by Quantity, then by Order Date

-- Top(To limit how many rows you want)--
SELECT TOP 2 * FROM Products
ORDER BY price DESC;                       -- Top 2 products by price DESC
SELECT TOP 1 * FROM Customers
ORDER BY signup_date DESC;                 -- Showing the most recent customer 
Select TOP 3 * from Orders
Order by quantity DESC;                    -- Showing top 3 orders with highest quantities 

-- As(Aliases - to rename the columns and tables In the Output)--
Select name as C_name, city as Location from Customers       --- Changing column names in output 
Select name C_name, city Location from Customers             --- As word is optional , this will also works *** 

/* Limit ( to restrict the number of rows in MySQL, PostgreSQL, SQLite etc.. BUT NOT IN SQL server, 
so we can use Limit here instead we can use Top function */ 

-- Expressions & Calculations ( Doing math )
SELECT product_name, price, price - 10 AS discounted_price
FROM Products;                                         /* giving 10 discount to the prices( here we are just viewing 
                                                       and not adding the column to the table, we will see that later in adding concept) */
Select price, price + 2 as New_Price From Products;            -- Add 
Select price, price - 2 as New_Price From Products;            -- Subtract 
Select price, price * 2 as New_Price From Products;            -- Multiply
Select price, Round(price/2,0) as New_Price From Products;     -- Divide 
SELECT price, CAST(price / 2 AS DECIMAL(10,2)) AS New_Price    -- Cast used to convert one data type to other=CAST(expression AS target_data_type)
FROM Products;

-- Functions/Aggregate functions ( to perform calculations on data like count, total, average, min, max ).
Select count(*) As Total_c from Customers;                      --  Total Number of Customers
SELECT COUNT(order_id) AS total_orders from Orders; 
SELECT SUM(quantity) AS total_qs from Orders;                   -- Total Quantity Ordered 
SELECT AVG(price) AS average_price from Products;               -- Avg price 
SELECT MAX(price) AS highest_price, MIN(price) AS lowest_price  -- Max and Min prices 
FROM Products; 
SELECT COUNT(*) AS dallas_customers FROM Customers              -- using functions with "where"
WHERE city = 'Dallas';

-- Group By (apply functions (like COUNT, SUM, AVG) for each group, not the whole table)
SELECT customer_id, COUNT(*) AS total_orders FROM Orders        -- Count number of orders per customer
GROUP BY customer_id;
SELECT product_id, SUM(quantity) AS total_quantity FROM Orders  -- Sum of quantity ordered per product
GROUP BY product_id;

-- Having ( filtering after grouping) - WHERE filters rows before grouping , HAVING filters groups after aggregation
SELECT customer_id, COUNT(*) AS total_orders          -- Customers with more than 1 order
FROM Orders
GROUP BY customer_id
HAVING COUNT(*) > 1;
SELECT product_id, SUM(quantity) AS total_quantity    -- Products ordered more than 2 times
FROM Orders
GROUP BY product_id
HAVING SUM(quantity) > 2;
SELECT city, COUNT(*) AS customer_count               -- Cities with more than 2 customers
FROM Customers
GROUP BY city
HAVING COUNT(*) > 2;

-- Combining Aliases + Expressions + Functions + Grouping
SELECT                                               --Total quantity and total revenue per customer
  o.customer_id AS CustomerID,
  SUM(o.quantity) AS TotalQuantity,
  SUM(o.quantity * p.price) AS TotalRevenue
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY o.customer_id;
SELECT                                               -- Total Quantity & Revenue per Product
  p.product_name AS Product,
  SUM(o.quantity) AS TotalUnitsSold,
  SUM(o.quantity * p.price) AS TotalRevenue
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY p.product_name;
SELECT                                               -- Average Order Quantity per Customer
  customer_id AS CustomerID,
  ROUND(AVG(quantity), 2) AS AvgOrderQuantity
FROM Orders
GROUP BY customer_id;

-- Joins (Combining Data from Multiple Tables) =In real-world databases, data is split across multiple tables, to analysie we join them 








































