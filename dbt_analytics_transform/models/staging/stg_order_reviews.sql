--models/staging/stg_order_reviews.sql

WITH source AS(
    SELECT * FROM {{source('dataset_B','order_reviews')}}
),
transform AS(
    SELECT
        CAST(order_id AS STRING) AS order_id,
        CAST(review_id AS STRING) AS review_id,
        CAST(review_score AS INT64) AS review_score,
        CAST(review_creation_date AS DATE) AS review_creation_date,
        CAST(review_answer_timestamp AS TIMESTAMP) AS review_answer_timestamp
    FROM source
)

SELECT * FROM transform 
    WHERE order_id IS NOT NULL 
    AND review_id IS NOT NULL