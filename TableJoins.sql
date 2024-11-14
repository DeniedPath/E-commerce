-- 1. Retrieve Customer Order Details
SELECT c.customer_id, c.first_name, c.last_name, o.order_id, o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
ORDER BY o.order_date DESC;

-- 2. Get Detailed Order Items for a Specific Order
SELECT od.order_id, p.product_id, p.name, od.quantity, od.price_per_item
FROM order_details od
JOIN products p ON od.product_id = p.product_id
JOIN orders o ON od.order_id = o.order_id
WHERE od.order_id = 1  -- Replace with a specific order_id
ORDER BY p.product_id ASC;

-- 3. List Orders with Customer Information
SELECT o.order_id, o.order_date, o.order_status, c.first_name, c.last_name, c.email
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'Pending'
ORDER BY o.order_date DESC;

-- 4. Calculate Total Sales per Customer
SELECT c.customer_id, c.first_name, c.last_name, 
       SUM(od.quantity * od.price_per_item) AS total_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_sales DESC;

-- 5. Find Products Ordered by Multiple Customers
SELECT p.product_id, p.name, COUNT(DISTINCT o.customer_id) AS customer_count
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
GROUP BY p.product_id, p.name
HAVING customer_count > 1
ORDER BY customer_count DESC;

-- 6. Display All Product Sales with Quantities and Customers
SELECT p.product_id, p.name, od.quantity, c.customer_id, c.first_name
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY p.product_id ASC, c.customer_id ASC;

-- 7. Bonus: Complex Join with Aggregation
SELECT c.customer_id, c.first_name, c.last_name, 
       COUNT(DISTINCT o.order_id) AS total_orders,
       SUM(od.quantity * od.price_per_item) AS total_amount_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_amount_spent DESC;
