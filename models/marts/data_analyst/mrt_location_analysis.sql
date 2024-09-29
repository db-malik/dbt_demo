-- models/data_analyst/mrt_location_analysis.sql

{{ config(materialized='incremental',
    tags=['mrt_analyst'])
 }}
WITH sales_location AS (
    SELECT
        s.shop_id AS location_id,
        sh.country,
        s.total_price AS total_sales,
        s.sale_id,
        s.total_price
    FROM
        {{ ref('wh_fact_sales') }} s
    LEFT JOIN
        {{ ref('stg_shops') }} sh ON s.shop_id = sh.shop_id
)

SELECT
    location_id,
    country,
    SUM(total_sales) AS total_sales,
    COUNT(sale_id) AS total_transactions,
    AVG(total_price) AS average_transaction_value
FROM
    sales_location
GROUP BY
    location_id,
    country
