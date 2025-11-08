-- Sales Analytics Dashboard by Sohib Charkaoui
-- lazy comments but easy to follow lol

-- make the db
CREATE DATABASE IF NOT EXISTS SalesAnalyticsDB;
USE SalesAnalyticsDB;

-- drop old tables if they exist just in case
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

-- create table for products
CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  category VARCHAR(50),
  price DECIMAL(10,2)
);

-- create table for customers
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  gender ENUM('Male','Female','Other'),
  age INT,
  income_level VARCHAR(50)
);

-- create table for sales
CREATE TABLE sales (
  sale_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  customer_id INT,
  region VARCHAR(50),
  sale_date DATE,
  quantity INT,
  price DECIMAL(10,2),
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- sample product data (feel free to add your own) - AS USER CHANGE THIS 
INSERT INTO products (name, category, price) VALUES
('Wireless Mouse','Electronics',25.99),
('Gaming Keyboard','Electronics',59.99),
('Desk Chair','Furniture',120.00),
('LED Monitor','Electronics',199.99),
('Coffee Mug','Kitchen',8.50),
('Notebook','Stationery',3.50);

-- sample customers (you can replace names easily) - AS USER CHANGE THIS
INSERT INTO customers (name, gender, age, income_level) VALUES
('Ava Johnson','Female',24,'Medium'),
('Liam Chen','Male',31,'High'),
('Sophia Patel','Female',27,'Medium'),
('Noah Garcia','Male',45,'High'),
('Olivia Kim','Female',22,'Low'),
('Ethan Brown','Male',34,'Medium');

-- sample sales data (random mix of stuff)
INSERT INTO sales (product_id, customer_id, region, sale_date, quantity, price) VALUES
(1,1,'East','2025-01-15',2,25.99),
(2,2,'West','2025-01-20',1,59.99),
(3,3,'North','2025-02-01',1,120.00),
(4,4,'South','2025-02-10',1,199.99),
(5,5,'East','2025-02-15',3,8.50),
(6,6,'West','2025-02-18',5,3.50),
(2,1,'East','2025-03-01',1,59.99),
(1,3,'North','2025-03-05',1,25.99),
(4,2,'West','2025-03-15',1,199.99),
(3,5,'South','2025-03-22',2,120.00),
(5,4,'East','2025-03-30',4,8.50),
(6,6,'West','2025-04-05',10,3.50),
(2,1,'East','2025-04-10',2,59.99),
(1,2,'North','2025-04-18',1,25.99),
(4,3,'South','2025-04-25',1,199.99);

-- template area for your own data 
-- INSERT INTO customers (name, gender, age, income_level) VALUES ('YourName','Male',21,'Low');
-- INSERT INTO sales (product_id, customer_id, region, sale_date, quantity, price) VALUES (1,7,'West','2025-05-01',2,25.99);

-- ==================================================
-- now the analytics part (the fun stuff)
-- ==================================================

-- 1. total revenue overall
SELECT SUM(quantity * price) AS total_revenue
FROM sales;
-- shows total money made basically

-- 2. total revenue by region
SELECT region, SUM(quantity * price) AS region_revenue
FROM sales
GROUP BY region
ORDER BY region_revenue DESC;
-- which areas make the most money

-- 3. top 5 selling products by revenue
SELECT p.name, SUM(s.quantity * s.price) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.name
ORDER BY total_revenue DESC
LIMIT 5;
-- top dogs in sales

-- 4. average revenue per customer
SELECT c.name, ROUND(SUM(s.quantity * s.price),2) AS total_spent
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;
-- see who’s dropping the most money

-- 5. category-wise sales totals
SELECT p.category, SUM(s.quantity * s.price) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;
-- which product category does best

-- 6. monthly sales trend
SELECT 
  DATE_FORMAT(sale_date,'%Y-%m') AS month,
  SUM(quantity * price) AS monthly_revenue
FROM sales
GROUP BY month
ORDER BY month;
-- shows revenue month by month

-- 7. month-over-month revenue growth using LAG()
WITH monthly AS (
  SELECT 
    DATE_FORMAT(sale_date,'%Y-%m') AS month,
    SUM(quantity * price) AS revenue
  FROM sales
  GROUP BY month
)
SELECT 
  month,
  revenue,
  LAG(revenue,1) OVER (ORDER BY month) AS prev_month_revenue,
  ROUND(((revenue - LAG(revenue,1) OVER (ORDER BY month)) / LAG(revenue,1) OVER (ORDER BY month)) * 100,2) AS growth_percent
FROM monthly;
-- checks month to month growth, fancy but cool

-- 8. average order size
SELECT 
  ROUND(AVG(quantity * price),2) AS avg_order_value
FROM sales;
-- avg money per sale, nothing deep

-- 9. total quantity sold per product
SELECT 
  p.name,
  SUM(s.quantity) AS total_sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC;
-- just to see which item moves the most units
