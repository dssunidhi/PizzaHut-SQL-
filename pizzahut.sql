select*from pizzahut.pizzas;
select*from pizzahut.pizza_types;
select*from pizzahut.orders;
select*from pizzahut.order_details;
use pizzahut;
##for comments select all ctrl slash
##select query ctrl b for beautify query

-- Basic:

-- Retrieve the total number of orders placed.
select count(order_id) as total_order from orders;
use pizzahut;
-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(pizzas.price * order_details.quantity),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
    pizzas.price, pizza_types.name
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size, COUNT(order_details.quantity) AS total_qty
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY total_qty DESC;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name, SUM(order_details.quantity) AS qty
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY qty DESC
LIMIT 5;

-- Intermediate:
-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category, SUM(order_details.quantity) as quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

-- Determine the distribution of orders by hour of the day.

select hour(order_time) ,count(order_id)
from orders
group by hour(order_time);

-- Join relevant tables to find the category-wise distribution of pizzas.
select category,count(name)
from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(quantity),0) from
(select orders.order_date,sum(order_details.quantity)as avg_pizza_order_per_day
from orders join order_details
on orders.order_id=order_details.order_id
group by orders.order_date)as order_qty;

-- Determine the top 3 most ordered pizza types based on revenue.


select pizza_types.name,sum(pizzas.price*order_details.quantity)as revenue
from  pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;

-- Advanced:
-- Calculate the percentage contribution of each pizza type to total revenue.

select pizza_types.category,sum(pizzas.price*order_details.quantity)as revenue
from  pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category order by revenue desc limit 3;



