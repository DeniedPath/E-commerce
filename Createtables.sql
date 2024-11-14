-- 1. Set up a new Database for the E-commerce Store
CREATE DATABASE ecommerce_store;
USE ecommerce_store;

-- 2. Create the Customers Table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 3. Create the Products Table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    date_added DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 4. Create the Orders Table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. Create the Order Details Table
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_per_item DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 6. Populate the Tables with Sample Data
-- Insert sample customers
INSERT INTO customers (first_name, last_name, email, phone, address, city, state, zip_code)
VALUES 
('John', 'Doe', 'john.doe@email.com', '123-456-7890', '123 Main St', 'Anytown', 'CA', '12345'),
('Jane', 'Smith', 'jane.smith@email.com', '987-654-3210', '456 Oak Ave', 'Somewhere', 'NY', '67890');

-- Insert sample products
INSERT INTO products (name, description, price, stock_quantity)
VALUES 
('Laptop', 'High-performance laptop', 999.99, 50),
('Smartphone', 'Latest model smartphone', 699.99, 100),
('Headphones', 'Noise-cancelling headphones', 199.99, 75);

-- Create a sample order
INSERT INTO orders (customer_id, total_amount)
VALUES (1, 1899.97);

-- Add items to the order_details
INSERT INTO order_details (order_id, product_id, quantity, price_per_item)
VALUES 
(1, 1, 1, 999.99),
(1, 2, 1, 699.99),
(1, 3, 1, 199.99);

-- 7. Write Queries to Test Your Database
-- Retrieve all orders for a specific customer
SELECT order_id, order_date
FROM orders
WHERE customer_id = 1;

-- Retrieve all details for a specific order
SELECT p.name, od.quantity, od.price_per_item
FROM order_details od
JOIN products p ON od.product_id = p.product_id
WHERE od.order_id = 1;

-- Update stock after an order has been placed
UPDATE products p
JOIN order_details od ON p.product_id = od.product_id
SET p.stock_quantity = p.stock_quantity - od.quantity
WHERE od.order_id = 1;

-- 8. Enhancements (Optional)
-- Add a category column to the products table
ALTER TABLE products
ADD COLUMN category VARCHAR(50);

-- Create a shipping_addresses table for multiple customer addresses
CREATE TABLE shipping_addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Add shipment_date and shipping_address_id to the orders table
ALTER TABLE orders
ADD COLUMN shipment_date DATE,
ADD COLUMN shipping_address_id INT,
ADD FOREIGN KEY (shipping_address_id) REFERENCES shipping_addresses(address_id);
