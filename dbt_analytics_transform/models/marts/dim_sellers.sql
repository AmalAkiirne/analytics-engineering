-- models/marts/dim_sellers.sql

{{ config(materialized='table') }}

WITH sellers AS(
    SELECT * FROM {{ref("stg_sellers")}}
),
geolocation AS(
    SELECT * FROM {{ref("stg_geolocation")}}
)
SELECT 
    s.seller_id,
    s.seller_zip_code_prefix,
    s.seller_city,
    s.seller_state,
    g.latitude,
    g.longitude
FROM sellers s 
LEFT JOIN geolocation g 
    ON s.seller_zip_code_prefix = g.geolocation_zip_code_prefix