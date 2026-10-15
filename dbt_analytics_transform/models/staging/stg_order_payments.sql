--models/staging/stg_order_payments.sql

WITH source AS(
    SELECT * FROM {{source('dataset_B','order_payments')}}
),
transform AS(
    SELECT
        CAST(order_id AS STRING) AS order_id,
        CAST(payment_sequential AS INT64) AS payment_sequential,
        CAST(payment_type AS STRING) AS payment_type,
        CAST(payment_installments AS INT64) AS payment_installments,
        CAST(payment_value AS numeric) AS payment_value
    FROM source
)

SELECT * FROM transform
    WHERE order_id IS NOT NULL