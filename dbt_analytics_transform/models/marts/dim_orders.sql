-- models/marts/dim_orders.sql

{{ config(materialized='table') }}

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

reviews AS (
    SELECT 
        order_id,
        AVG(review_score) AS average_score,
        COUNT(review_score) AS nb_reviews
    FROM {{ ref('stg_order_reviews') }}
    GROUP BY order_id
)

SELECT 
    -- FK
    o.order_id,
    
    -- order
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    -- reviews
    r.nb_reviews,
    r.average_score

FROM orders o
LEFT JOIN reviews r 
    ON o.order_id = r.order_id