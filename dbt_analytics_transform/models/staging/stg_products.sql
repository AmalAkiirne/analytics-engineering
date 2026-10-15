--models/staging/stg_products.sql

WITH source AS(
    SELECT * FROM {{source('dataset_B','products')}}
),
transform AS(
    SELECT
        CAST(product_id AS STRING) AS product_id,
        CAST(product_category_name AS STRING) AS product_category_name,
        CAST(product_name_lenght AS INT64) AS product_name_lenght,
        CAST(product_description_lenght AS INT64) AS product_description_lenght,
        CAST(product_photos_qty AS INT64) AS product_photos_qty,
        CAST(product_weight_g AS INT64) AS product_weight_g,
        CAST(product_length_cm AS INT64) AS product_length_cm,
        CAST(product_height_cm AS INT64) AS product_height_cm,
        CAST(product_width_cm AS INT64) AS product_width_cm
    FROM source
)

SELECT * FROM transform 
    WHERE product_id IS NOT NULL