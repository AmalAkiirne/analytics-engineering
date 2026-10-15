-- models/staging/stg_customers.sql 

WITH source AS (
    SELECT * FROM {{source('dataset_B', 'customers')}}
),
transformed AS (
    SELECT
        CAST(customer_id AS STRING) AS customer_id,
        CAST(customer_unique_id AS STRING) AS customer_unique_id,
        LPAD(CAST(customer_zip_code_prefix AS STRING), 5, '0') AS customer_zip_code_prefix,
        REGEXP_REPLACE(
            NORMALIZE(LOWER(TRIM(customer_city)), NFD),
            r'[\pM]|[^a-z]',
            ''
        ) AS customer_city,
        UPPER(TRIM(customer_state)) AS customer_state
    FROM source 
)
SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state

FROM transformed
WHERE customer_id IS NOT NULL
GROUP BY 1, 2, 3, 4, 5