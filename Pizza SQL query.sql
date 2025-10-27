select * from pizza_sales


---- Total_Revenue
select sum(total_price) As Total_Revenue from pizza_sales

--- Average_Order_Value
select Sum(total_price)/COUNT(DISTINCT order_id)  as Average_Order_Value from pizza_sales


----Total_Pizzas
select sum(quantity) as Total_Pizzas from pizza_sales

---Total Orders 

select count(DISTINCT order_id) as Total_Orders from pizza_sales

---Average No of Pizzas per order 

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales


SELECT 
    ROUND(SUM(quantity) * 1.0 / COUNT(DISTINCT order_id), 2) AS Avg_Pizzas_per_order
FROM pizza_sales

---Daily Trend for Total Orders ( By day)

SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

---C. Hourly Trend for Orders
SELECT DATEPART(HOUR, order_time) as order_hours, COUNT(DISTINCT order_id) as total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)

SELECT 
    CONCAT(DATEPART(HOUR, order_time), ':00') AS order_hour_label,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

--- % of Sales by Pizza Category
SELECT pizza_category, 
CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category

---% of Sales by Pizza Size

SELECT pizza_size, 
CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size


----Total Pizzas Sold by Pizza Category
SELECT pizza_category,
SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


SELECT pizza_category,
SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


--- Top 5 Best Sellers by Total Pizzas Sold

SELECT Top 5 pizza_name, 
SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

---Bottom 5 Best Sellers by Total Pizzas Sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC

SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY DATENAME(DW, order_date)


SELECT 
    DATENAME(WEEKDAY, order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders,
    DATEPART(QUARTER, order_date) AS quarter_no
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) IN (1, 2)
GROUP BY 
    DATENAME(WEEKDAY, order_date),
    DATEPART(QUARTER, order_date)
ORDER BY 
    quarter_no, order_day;

