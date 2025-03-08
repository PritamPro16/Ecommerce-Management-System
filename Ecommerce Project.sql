CREATE DATABASE ecommerce_db;
USE ecommerce_db;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50),
    signup_date DATE
);

USE ecommerce_db;
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);

USE ecommerce_db;
CREATE TABLE orders (
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT,
order_date DATE,
total_amount DECIMAL (10,2),
FOREIGN KEY (customer_id) REFERENCES customers(customers_id)
);

USE ecommerce_db;
CREATE TABLE order_Details (
order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
product_id INT,
quantity INT,
subtotal DECIMAL(10,2),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

USE ecommerce_db;
CREATE TABLE payments (
payment_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
payment_method VARCHAR(50),
payment_status VARCHAR(50),
payment_date DATE,
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

USE ecommerce_db;
INSERT INTO Customers (name, email, phone, city, signup_date) VALUES
('Amit Sen', 'amit@example.com', '9876543210', 'Kolkata', '2024-01-10'),
('Priya Das', 'priya@example.com', '8765432109', 'Mumbai', '2023-12-05'),
('Rajesh Roy', 'rajesh@example.com', '7654321098', 'Delhi', '2023-11-15'),
('Anita Ghosh', 'anita@example.com', '6543210987', 'Bangalore', '2024-02-20');

USE ecommerce_db;
INSERT INTO Products (product_name, category, price, stock_quantity) VALUES
('Laptop', 'Electronics', 50000.00, 10),
('Smartphone', 'Electronics', 30000.00, 15),
('Headphones', 'Accessories', 2000.00, 50),
('T-Shirt', 'Clothing', 500.00, 100);

USE ecommerce_db;
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2024-02-01', 52000.00),
(2, '2024-02-10', 30000.00),
(3, '2024-02-15', 2500.00);

USE ecommerce_db;
INSERT INTO Order_Details (order_id, product_id, quantity, subtotal) VALUES
(1, 1, 1, 50000.00),
(1, 3, 1, 2000.00),
(2, 2, 1, 30000.00),
(3, 3, 1, 2000.00),
(3, 4, 1, 500.00);

USE ecommerce_db;
INSERT INTO Payments (order_id, payment_method, payment_status, payment_date) VALUES
(1, 'Credit Card', 'Completed', '2024-02-01'),
(2, 'UPI', 'Completed', '2024-02-10'),
(3, 'Cash on Delivery', 'Pending', '2024-02-15');

# Total Sales Per Month
SELECT 
    MONTH(order_date) AS month, 
    SUM(total_amount) AS total_sales 
FROM Orders 
GROUP BY MONTH(order_date);

# Top 5 Best-Selling Products
SELECT 
    p.product_name, 
    SUM(od.quantity) AS total_sold 
FROM Order_Details od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;

# Customer with the Highest Spending
USE ecommerce_db;
SELECT 
    customers.name, 
    SUM(orders.total_amount) AS total_spent 
FROM orders 
JOIN customers ON orders.customer_id = customers.customers_id 
GROUP BY customers.name 
ORDER BY total_spent DESC 
LIMIT 1;

# New vs. Returning Customers

SELECT 
    COUNT(CASE WHEN signup_date > '2024-01-01' THEN 1 END) AS new_customers,
    COUNT(CASE WHEN signup_date <= '2024-01-01' THEN 1 END) AS returning_customers
FROM Customers;

# Low Stock Products

SELECT 
    product_name, 
    stock_quantity 
FROM Products 
WHERE stock_quantity < 5;

# Most Preferred Payment Method

SELECT 
    payment_method, 
    COUNT(*) AS usage_count 
FROM Payments 
GROUP BY payment_method
ORDER BY usage_count DESC;

