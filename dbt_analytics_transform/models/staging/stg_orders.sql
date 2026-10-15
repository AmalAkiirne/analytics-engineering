--models/staging/stg_orders.sql

WITH source AS(
    SELECT * FROM {{source('dataset_B','orders')}}
),
transform AS(
    SELECT
        CAST(order_id AS STRING) AS order_id,
        CAST(customer_id AS STRING) AS customer_id,
        CAST(order_status AS STRING) AS order_status,
        CAST(order_purchase_timestamp AS TIMESTAMP) AS order_purchase_timestamp,
        CAST(order_approved_at AS TIMESTAMP) AS order_approved_at,
        CAST(order_delivered_carrier_date AS DATE) AS order_delivered_carrier_date,
        CAST(order_delivered_customer_date AS DATE) AS order_delivered_customer_date,
        CAST(order_estimated_delivery_date AS DATE) AS order_estimated_delivery_date
    FROM source
)

SELECT * FROM transform 
    WHERE order_id IS NOT NULL
