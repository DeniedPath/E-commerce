-- 1. Calculate Average Order Value
SELECT AVG(total_amount) AS average_order_value
FROM orders;

-- 2. Count Orders by Status
SELECT order_status, COUNT(*) AS order_count
FROM orders
GROUP BY order_status;

-- 3. Find Highest and Lowest Priced Products
-- Highest priced product
SELECT product_id, name, price
FROM products
WHERE price = (SELECT MAX(price) FROM products);

-- Lowest priced product
SELECT product_id, name, price
FROM products
WHERE price = (SELECT MIN(price) FROM products);

-- 4. Calculate Total Quantity Sold per Product
SELECT p.product_id, p.name, SUM(od.quantity) AS total_quantity_sold
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.name
ORDER BY total_quantity_sold DESC;

-- 5. Calculate Total Sales Revenue per Day
SELECT DATE(order_date) AS order_day, SUM(total_amount) AS total_revenue
FROM orders
GROUP BY DATE(order_date)
ORDER BY order_day;

-- 6. List Customers with Total Amount Spent
SELECT c.customer_id, c.first_name, c.last_name, 
       SUM(od.quantity * od.price_per_item) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- 7. Calculate Average Order Quantity per Product
SELECT p.product_id, p.name, AVG(od.quantity) AS avg_quantity
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.name
ORDER BY avg_quantity DESC;

-- 8. Bonus: Find Top 5 Customers by Total Spending
SELECT c.customer_id, c.first_name, c.last_name, 
       SUM(od.quantity * od.price_per_item) AS total_spending
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spending DESC
LIMIT 5;
