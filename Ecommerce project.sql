create database ecommerce_db;
use ecommerce_db;


CREATE TABLE customers ( 
customer_id INT PRIMARY KEY, 
name VARCHAR(100), 
email VARCHAR(100), 
city VARCHAR(50), 
signup_date DATE 
);

 -- Products 
CREATE TABLE products ( 
product_id INT PRIMARY KEY, 
product_name VARCHAR(255), 
category VARCHAR(50), 
price DECIMAL(10,2), 
stock_quantity INT 
); 

-- Orders 
CREATE TABLE orders ( 
order_id INT PRIMARY KEY, 
customer_id INT, 
order_date DATE, 
status VARCHAR(20), 
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);
 -- Order Items 
CREATE TABLE order_items ( 
order_item_id INT PRIMARY KEY, 
order_id INT, 
product_id INT, 
quantity INT, 
price DECIMAL(10,2),  
FOREIGN KEY (order_id) REFERENCES orders(order_id), 
FOREIGN KEY (product_id) REFERENCES products(product_id) );

-- Payments 
CREATE TABLE payments ( 
payment_id INT PRIMARY KEY, 
order_id INT, 
payment_method VARCHAR(50), 
payment_status VARCHAR(20), 
amount DECIMAL(10,2), 
FOREIGN KEY (order_id) REFERENCES orders(order_id) 
);

 -- Shipping 
CREATE TABLE shipping ( 
shipping_id INT PRIMARY KEY, 
order_id INT, 
shipping_status VARCHAR(50), 
delivery_date DATE, 
FOREIGN KEY (order_id) REFERENCES orders(order_id) 
); 

select  *from customers;
select  *from products;
select  *from orders;
select  *from order_items;
select  *from payments;
select  *from shipping;

SET GLOBAL local_infile = 1; 

SELECT o.order_id, c.name 
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id 
LIMIT 10; 

SELECT o.order_id, p.product_name 
FROM order_items oi 
JOIN orders o ON oi.order_id = o.order_id 
JOIN products p ON oi.product_id = p.product_id 
LIMIT 10; 

CREATE INDEX idx_orders_customer ON orders(customer_id); 
CREATE INDEX idx_order_items_order ON order_items(order_id);

#1 Business Problem: 
#The company wants to understand its overall user base. As a data analyst, you are asked to calculate the total 
#number of registered customers in the system.
select count(customer_id) from customers;

#2 Business Problem: 
#The marketing team wants to run a campaign specifically in Pune. Retrieve all customers who belong to Pune so 
#they can be targeted. 
select * from customers
where city="pune";

#3 Business Problem: 
#Management wants to know how many total orders have been placed on the platform so far to measure 
#platform activity
select count(order_id) from orders;

#4 Business Problem: 
#To analyze current trends, the business wants to see all orders placed in the last 30 days.
SELECT *
FROM orders
WHERE order_date between '2024-01-07'and '2024-02-07';

#5 Business Problem: 
#The company wants to identify premium products. Retrieve all products with a price greater than ₹50,000.
select * from  products
where price>"50000";

#6 Business Problem: 
#To understand product diversity, list all unique product categories available on the platform.
select distinct category from products ;

#7 Business Problem: 
#Finance team needs to know total revenue generated from all orders using order item data. 
select sum(price)  as total_revenue from order_items;

#8 Business Problem: 
# Operations team wants to understand how orders are distributed across statuses (Delivered, Pending, 
#Cancelled). 
select shipping_status,count(order_id)
 from shipping
 group by shipping_status;
 
 #9 Business Problem: 
#Warehouse team wants to know how many products exist in each category.
 select count(product_name) as products,category 
 from products
 group by category; 
 
 #10 Business Problem: 
#To understand customer engagement, display each customer along with the orders they have placed
 select c.customer_id,
 c.name,
 o.order_id,
 o.order_date,
 o.status
 from customers c 
 join orders o 
 on c.customer_id=o.customer_id;
 
 #11 Business Problem: 
#Identify products where stock is below 20 units so that restocking can be planned
 select product_name,stock_quantity
 from products
where stock_quantity<20;

#12 Business Problem: 
#Finance team wants to analyze only successful payments. 
select * from payments
where payment_status="success";

#13 Business Problem: 
#Find all orders that have been successfully delivered to customers. 
select order_id,shipping_status,delivery_date 
from shipping 
where shipping_status="delivered";

#14 Business Problem: 
#Calculate how many orders each customer has placed.
select c.customer_id,c.name,
count(o.order_id) as total_orders
from customers c
left join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.name;


#15 Business Problem: 
#Display all products included in each order to understand order composition. 
SELECT
oi.order_id,
p.product_id,
p.product_name,
oi.quantity,
oi.price
from order_items oi
join products p
on oi.order_id=p.product_id
order by oi.order_id;

#16 Business Problem: 
#Identify top 10 customers who have contributed the highest revenue to the business. 
SELECT c.customer_id,
       c.name,
       SUM(pa.amount) AS total_revenue
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
JOIN Payments pa
    ON o.order_id = pa.order_id
GROUP BY c.customer_id, c.name
ORDER BY total_revenue DESC
LIMIT 10;

#17 Business Problem: 
#Analyze how revenue changes month by month to detect trends and seasonality.
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(p.amount) AS total_revenue
FROM Orders o
JOIN Payments p
    ON o.order_id = p.order_id
WHERE p.payment_status = 'Success'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;

#18 Business Problem: 
#Find orders where total value exceeds ₹50,000. These are considered premium orders.
select order_id,
sum(quantity*price) as total_value
from order_items
group by order_id
having total_value>50000;


#19 Business Problem: 
#Identify customers who have placed more than 5 orders. These are loyal customers.
select c.customer_id,
c.name,
count(order_id) as total_orders
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.name
having total_orders>5
order by total_orders desc;

#20 Business Problem: 
#Calculate how much revenue each product generates.
select p.product_id,
p.product_name,
sum(oi.quantity*oi.price) as total_revenue
from products p
join order_items oi
on p.product_id=oi.product_id
group by p.product_id,p.product_name
order by total_revenue desc;

#21 Business Problem: 
#Find which payment method is used most frequently by customers.
select payment_method,
count(*) as usage_count
from payments
group by payment_method
order by usage_count desc;


#22 Business Problem: 
#Identify orders that had at least one failed payment attempt.
select distinct
o.order_id,
o.order_date,
o.customer_id,
o.status
from orders o
join payments p
on o.order_id=p.order_id
where payment_status="failed";


#23 Business Problem: 
#Determine how many orders come from each city.
select c.city,
count(o.order_id) as total_orders
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.city
order by total_orders desc;

#24 Business Problem: 
#Identify which category has the highest number of items sold. 
select
p.category,
sum(oi.quantity) as total_orders
from products p
join order_items oi
on p.product_id=oi.product_id
group by p.category
order by total_orders desc
limit 1;

#25 Business Problem: 
#Calculate the average delivery time for delivered orders.
SELECT
avg(datediff(s.delivery_date,o.order_date)) as avg_delivery_time
from orders o
join shipping s
on o.order_id=s.order_id
where shipping_status="delivered";

#26 Business Problem: 
#Rank all customers based on total money spent to identify VIP customers.
select c.customer_id,
c.name,sum(p.amount) as total_spent
from customers c
 join orders o
on c.customer_id=o.customer_id
 join payments p
 on o.order_id=p.order_id
 where payment_status="success"
 group by c.customer_id,c.name
order by total_spent  desc;


#27 Business Problem: 
#Track cumulative revenue over time to understand business growth.
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(p.amount) AS monthly_revenue,
    SUM(SUM(p.amount)) OVER (
        ORDER BY DATE_FORMAT(o.order_date, '%Y-%m')
    ) AS cumulative_revenue
FROM Orders o
JOIN Payments p
    ON o.order_id = p.order_id
WHERE p.payment_status = 'Success'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;

#28 Business Problem: 
#Identify top 3 customers in each city based on spending.
select
c.customer_id,
c.name,c.city,
sum(p.amount) as total_spent
from customers c
join orders o on
c.customer_id=o.customer_id
join payments p
on o.order_id=p.order_id
group by c.customer_id,
c.name,c.city
order by total_spent desc
limit 3;

#29 Business Problem: 
#Calculate how much each product contributes to total revenue in percentage terms. 
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.price) AS product_revenue,
    ROUND(
        (SUM(oi.quantity * oi.price) * 100.0) /
        (SELECT SUM(quantity * price) FROM Order_Items),
        2
    ) AS revenue_percentage
FROM Products p
JOIN Order_Items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY revenue_percentage DESC;


#30 Business Problem: 
# Find customers who have both delivered and cancelled orders, indicating mixed behavior.
SELECT
    c.customer_id,
    c.name
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name
HAVING
    SUM(o.status = 'Delivered') > 0
    AND
    SUM(o.status = 'Cancelled') > 0;
    
    
