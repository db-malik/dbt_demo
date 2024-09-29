-- models/stg_items.sql

{{ config(materialized='table',
    tags=['staged'])
 }}
with source as (
    select
        {{ convert_type('item_id', 'string', 'integer') }},
        item_name,
        {{ convert_type('item_price', 'string', 'float') }},
        category,
        {{ convert_type('stock_quantity', 'string', 'integer') }},
        supplier,
        {{ convert_type('weight', 'string', 'float') }},
        brand,
        country
    from {{ source('dbt_staged', 'items') }}
    where item_id is not null
)

select
    item_id,
    item_name,
    item_price,
    category,
    stock_quantity,
    supplier,
    weight,
    brand,
    country
from source
