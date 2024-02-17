--PIZZA SALES ANALYSIS

--Inspecting Data
select * from pizza_sales


--Total Revenue
select SUM(total_price) AS total_revenue from pizza_sales

--Average order value
select SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value from pizza_sales

--Total Pizza Sold
select SUM(quantity) AS Total_pizza_sold from pizza_sales

--Total Orders
select COUNT(DISTINCT order_id) AS total_orders from pizza_sales

--Average pizzas per order
select cast((cast(SUM(quantity) AS DECIMAL(10,2)) /
cast(COUNT(DISTINCT order_id) AS DECIMAL (10,2))) AS DECIMAL(10,2))
AS avg_pizzas_per_order from pizza_sales

--Hourly trend for total orders
select DATEPART(HOUR, order_time) AS order_hour, SUM(quantity) as total_pizza_sold
from pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

--Weekly trend for total orders
select DATEPART(ISO_WEEK, order_date) AS order_week , YEAR(order_date) AS order_year,
COUNT(DISTINCT order_id) AS total_orders from pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)

--Percentage of sales by pizza category
select pizza_category,sum(total_price) AS total_sales, sum(total_price)*100 / (select SUM(total_price) from pizza_sales) 
AS percentage_of_sales from pizza_sales
GROUP BY pizza_category

--Percentage of sales by pizza size
select pizza_size,CAST(sum(total_price) AS DECIMAL (10,2)) AS total_sales,CAST(sum(total_price)*100 / (select SUM(total_price) from pizza_sales)
AS DECIMAL (10,2)) AS percentage_of_sales from pizza_sales
GROUP BY pizza_size
ORDER BY percentage_of_sales DESC

--Top 5 bestseller pizzas by revenue
select TOP 5 pizza_name,SUM(total_price) AS total_revenue from pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC

--Bottom 5 pizzas by revenue
select TOP 5 pizza_name,SUM(total_price) AS total_revenue from pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue

--Top 5 bestseller pizza by quantity
select TOP 5 pizza_name,SUM(quantity) AS total_quantity from pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC

--Bottom 5 pizzas by quantity
select TOP 5 pizza_name,SUM(quantity) AS total_quantity from pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity

--Top 5 pizzas wrt total orders
select TOP 5 pizza_name,COUNT(DISTINCT order_id) AS total_order from pizza_sales
GROUP BY pizza_name
ORDER BY total_order DESC

--Bottom 5 pizzas wrt total orders
select TOP 5 pizza_name,COUNT(DISTINCT order_id) AS total_order from pizza_sales
GROUP BY pizza_name
ORDER BY total_order