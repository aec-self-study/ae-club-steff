{{ config(
    materialized = 'table'
)}}

select 
  o.customer_id,
  c.name,
  c.email,
  o.first_order_at,
  o.number_of_orders
from `analytics-engineers-club.coffee_shop.customers` c
inner join
  (select 
    customer_id,
    MIN(created_at) as first_order_at,
    COUNT(customer_id) as number_of_orders
   from `analytics-engineers-club.coffee_shop.orders`
   group by customer_id) o
on c.id = o.customer_id
order by o.first_order_at
