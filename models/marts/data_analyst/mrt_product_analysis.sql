-- models/data_analyst/mrt_product_analysis.sql

{{ config(materialized='incremental',
    tags=['mrt_analyst'])
 }}
SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.brand,
    p.supplier,
    SUM(s.total_price) AS total_sales,
    SUM(s.quantity) AS total_quantity_sold,
    AVG(s.total_price / s.quantity) AS average_price
FROM
    {{ ref('wh_dim_product') }} p
JOIN
    {{ ref('wh_fact_sales') }} s ON p.product_id = s.item_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category,
    p.brand,
    p.supplier
