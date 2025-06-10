use db_pizza;
#to view the table 
select * from pizza_sales;

#to check total revenue
select sum(total_price) as Total_Revenue from pizza_sales;

#average order value
select sum(total_price)/count(distinct order_id) as Avg_Order_Value from pizza_sales;

#total pizzas sold
select sum(quantity) as Total_Pizzas_Sold from pizza_sales;

#total distinct orders
select count(distinct order_id) as Total_Orders from pizza_sales;

#avg pizzas per order
select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_Pizzas_Per_Order from pizza_sales;

#total orders each day of the weeek
select dayname(order_date) as Order_day, count(distinct order_id) as Total_orders
from pizza_sales 
group by Order_day ;

SET SQL_SAFE_UPDATES = 0;

#to change order-date from string to date
UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

desc pizza_sales;

alter table pizza_sales
modify column order_date date;

#total orders each month
select monthname(order_date) as Order_month, count(distinct order_id) as Total_orders
from pizza_sales 
group by Order_month
order by Total_orders desc ;

#category wise sales margin
select pizza_category, sum(total_price)*100 / (select sum(total_price) from pizza_sales) as Total_sales from pizza_sales
group by pizza_category;

#pizza size wise sales margin
select pizza_size, sum(total_price)*100 / (select sum(total_price) from pizza_sales) as Total_sales from pizza_sales
group by pizza_size;

#top 5 pizzas with highest revenue
select  pizza_name, sum(total_price) as Total_Revenue 
from pizza_sales
group by pizza_name
order by Total_Revenue desc limit 5;

#top 5 pizzas with lowest revenue
select  pizza_name, sum(total_price) as Total_Revenue 
from pizza_sales
group by pizza_name
order by Total_Revenue asc limit 5;

#top 5 pizzas with highest ordered quantities
select  pizza_name, sum(quantity) as Total_quantity
from pizza_sales
group by pizza_name
order by Total_quantity desc limit 5;

#top 5 pizzas with lowest ordered quantities
select  pizza_name, sum(quantity) as Total_quantity
from pizza_sales
group by pizza_name
order by Total_quantity asc limit 5;
