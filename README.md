# E-Commerce-Data-Analysis-Using-SQL

PROJECT OVERVIEW 
This project simulates a real-world e-commerce platform where data is stored across multiple tables such as 
customers, products, orders, payments, and shipping. 
The main objective of this project is to analyze business operations using SQL and generate meaningful insights 
related to customer behavior, sales performance, product demand, and delivery efficiency. 
As a data analyst, you are required to write SQL queries to solve real business problems and support decision
making. 
This project helps in understanding how relational databases work in real companies and how SQL is used to 
extract valuable information from large datasets. 

PROJECT OBJECTIVES 
• Analyze customer behavior and purchase patterns  
• Evaluate product performance and demand  
• Track sales and revenue trends  
• Monitor payment success and failures  
• Analyze delivery performance and delays  
• Generate insights to support business decisions  
DATASET INFORMATION 
This project uses a structured dataset similar to real e-commerce companies like Amazon. 
Dataset Size: 
• 600+ Customers  
• 300+ Products  
• 2500+ Orders  
• 5000+ Order Items  
• 2500+ Payments  
• 2500+ Shipping Records 
DATABASE TABLES 
1. Customers Table 
This table contains information about all registered users. 
Columns: 
• customer_id → Unique ID for each customer  
• name → Customer name  
• email → Email address  
• city → Customer location  
• signup_date → Registration date  
2. Products Table 
This table stores details of all products available on the platform. 
Columns: 
• product_id → Unique product ID  
• product_name → Name of the product  
• category → Product category  
• price → Product price  
• stock_quantity → Available stock  
3. Orders Table 
This table stores all order transactions placed by customers. 
Columns: 
• order_id → Unique order ID  
• customer_id → Reference to customer  
• order_date → Date of order  
• status → Order status (Delivered, Pending, Cancelled)  
4. Order_Items Table 
This table contains detailed information about products included in each order. 
Columns: 
• order_item_id → Unique ID  
• order_id → Reference to order  
• product_id → Reference to product  
• quantity → Number of items  
• price → Price at time of purchase  
5. Payments Table 
This table stores transaction details for each order. 
Columns: 
• payment_id → Unique payment ID  
• order_id → Reference to order  
• payment_method → UPI, Card, COD, etc.  
• payment_status → Success, Failed, Pending  
• amount → Payment amount  
6. Shipping Table 
This table tracks delivery and logistics information. 
Columns: 
• shipping_id → Unique ID  
• order_id → Reference to order  
• shipping_status → Delivered, In Transit, Delayed, etc.  
• delivery_date → Date of delivery (NULL if not delivered) 
TABLE RELATIONSHIPS 
• Customers → Orders (1 to Many)  
• Orders → Order_Items (1 to Many)  
• Products → Order_Items (1 to Many)  
• Orders → Payments (1 to Many)  
• Orders → Shipping (1 to 1 / Many)  
This structure represents a relational database used in real companies.

