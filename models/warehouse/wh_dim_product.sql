-- models/wh_dim_product.sql

{{ config(materialized='table',
    tags=['warehouse'],
    schema='dbt_warehouse')
 }}

WITH enriched_products AS (
    SELECT
        item_id AS product_id,
        item_name AS product_name,
        category,
        brand,
        supplier,
        item_price,
        weight,
        country
    FROM
        {{ ref('stg_items') }}
    WHERE
        item_id IS NOT NULL AND
        item_name IS NOT NULL AND
        category IS NOT NULL
)

SELECT
    product_id,
    product_name,
    category,
    brand,
    supplier,
    item_price,
    weight,
    country
FROM
    enriched_products
