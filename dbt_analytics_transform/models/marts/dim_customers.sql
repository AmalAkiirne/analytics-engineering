-- models/marts/dim_customers.sql
{{ config(materialized='table') }}
WITH customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
),

geolocation AS (
    SELECT * FROM {{ ref('stg_geolocation') }}
)

SELECT 
    c.customer_id,
    c.customer_unique_id,
    c.customer_zip_code_prefix,
    c.customer_city,
    c.customer_state,
    g.latitude,
    g.longitude
FROM customers c
LEFT JOIN geolocation g
    ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix