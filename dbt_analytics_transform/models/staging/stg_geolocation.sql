-- models/staging/stg_geolocation.sql

WITH source AS (
    SELECT * FROM {{ source('dataset_B', 'geolocation') }}
),

transformed AS (
    SELECT 
        LPAD(CAST(geolocation_zip_code_prefix AS STRING),5,'0') AS geolocation_zip_code_prefix,
        REGEXP_REPLACE(
            NORMALIZE(LOWER(TRIM(geolocation_city)), NFD),
            r'[\pM]|[^a-z]', 
            ''
        ) AS geolocation_city,
        
        UPPER(TRIM(geolocation_state)) AS geolocation_state,
        geolocation_lat AS latitude,
        geolocation_lng AS longitude
    FROM source
)

SELECT
    geolocation_zip_code_prefix,
    ANY_VALUE(geolocation_city) AS geolocation_city,
    ANY_VALUE(geolocation_state) AS geolocation_state,
    AVG(latitude) AS latitude,
    AVG(longitude) AS longitude
FROM transformed
WHERE geolocation_zip_code_prefix IS NOT NULL
GROUP BY geolocation_zip_code_prefix
