-- models/marts/fct_order_items.sql

{{ config(materialized='table') }}

WITH order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),

orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
)

SELECT 
    -- FK
    i.order_id,
    i.order_item_id,
    o.customer_id,
    i.product_id,
    i.seller_id,
    
    -- MEASURE
    i.shipping_limit_date,
    i.price,
    i.freight_value

FROM order_items i
    JOIN orders o 
    ON i.order_id = o.order_id