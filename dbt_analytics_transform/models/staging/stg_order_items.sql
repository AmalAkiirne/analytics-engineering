-- models/staging/stg_order_items.sql

WITH source AS(
    SELECT * FROM {{ source('dataset_B', 'order_items')}}
),
transform AS(
    SELECT
        CAST(order_id AS STRING) AS order_id,
        CAST(order_item_id AS INT64) AS order_item_id,
        CAST(product_id AS STRING) AS product_id,
        CAST(seller_id AS STRING) AS seller_id,
        CAST(shipping_limit_date AS TIMESTAMP) AS shipping_limit_date,
        CAST(price AS numeric) AS price,
        CAST(freight_value AS numeric) AS freight_value
    FROM source
)

SELECT *
FROM transform
WHERE order_id IS NOT NULL 
  AND product_id IS NOT NULL 