-- models/warehouse/wh_fact_sales.sql

{{ config(materialized='table',
    tags=['warehouse'],
    schema='dbt_warehouse')
 }}
SELECT
    sale_id,
    sale_date, 
    shop_id,
    consumer_id,
    item_id,
    total_price,
    quantity,
    payment_method,
    order_status
FROM
    {{ ref( 'stg_sales') }}
