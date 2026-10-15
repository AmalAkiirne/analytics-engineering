--models/staging/stg_sellers.sql

WITH source AS(
    SELECT * FROM {{source('dataset_B','sellers')}}
),
transform AS(
    SELECT
    CAST(seller_id AS STRING) AS seller_id,
    LPAD(CAST(seller_zip_code_prefix AS STRING),5,'0') AS seller_zip_code_prefix,
    REGEXP_REPLACE(
            NORMALIZE(LOWER(TRIM(seller_city)), NFD),
            r'[\pM]|[^a-z]', 
            ''
        ) AS seller_city,
        
    UPPER(TRIM(seller_state)) AS seller_state,
    FROM source
)
SELECT * FROM transform 
    WHERE seller_id IS NOT NULL