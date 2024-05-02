CREATE DATABASE pizza_db;

CREATE OR REPLACE TABLE pizza_sales (
    pizza_id INT,
    order_id INT,
    pizza_name_id VARCHAR(50),
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price DECIMAL(10, 2),
    total_price DECIMAL(10, 2),
    pizza_size VARCHAR(5), -- Snowflake does not support CHAR(1)
    pizza_category VARCHAR(50),
    pizza_ingredients VARCHAR(200), -- Snowflake does not support TEXT
    pizza_name VARCHAR(50)
     -- Snowflake supports PRIMARY KEY constraint
);
-------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM pizza_sales;
--------------------------------------------------------------------------------------------------------------------------
SELECT SUM(TOTAL_PRICE) AS TOT_REVENUE
FROM  pizza_sales;
--------------------------------------------------------------------------------------------------------------

SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_ord_Value 
FROM pizza_sales
----------------------------------------------------------------------------------------------
SELECT COUNT(DISTINCT order_id) AS Total_Ord 
FROM pizza_sales
-------------------------------------------------------------------------------------------------------
SELECT SUM(quantity) AS Total_pizza_sold 
FROM pizza_sales
----------------------------------------------------------------------------------------------------------

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
       CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
        AS Avg_Pizzas_per_order
FROM pizza_sales
----------------------------------------------------------------------------------------------------------

SELECT 
    ROUND(SUM(quantity) / COUNT(DISTINCT order_id), 2) 
    AS Avg_Pizzas_per_order
FROM 
    pizza_sales;

-----------------------------------------------------------------------------------------------------------------
SELECT 
    DAYNAME(order_date) AS day_name,
    COUNT(DISTINCT order_id) AS total_orders 
FROM 
    pizza_sales
GROUP BY 
    day_name;


--------------------------------------------------------------------------------------------------------------------------
SELECT 
    MONTHNAME(order_date) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders 
FROM 
    pizza_sales
GROUP BY 
    month_name;
----------------------------------------------------------------------------------------------------------------------------

SELECT pizza_category, 
SUM(total_price) AS total_sales,
ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales 
WHERE MONTH(order_date) = 1), 2) AS percentage
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;
---------------------------------------------------------------------------------------------------------------------------
SELECT 
    pizza_size, 
    SUM(total_price) AS total_revenue,
    ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS percentage
FROM 
    pizza_sales
GROUP BY 
    pizza_size
ORDER BY 
    pizza_size;

-----------------------------------------------------------------------------------------

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC
------------------------------------------------------------------------------------------
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
---------------------------------------------------------------------------------------
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
------------------------------------------------------------------------------------------------
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
-----------------------------------------------------------------------------------------------------
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
-------------------------------------------------------------------------------------------------------
SELECT Top 5 pizza_name, 
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders 
----------------------------------------------------------------------------------------------------------

SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC

------------------------------------------------------------------------------------------------------------------------









