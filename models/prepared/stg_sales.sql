-- models/stg_sales.sql

{{ config(materialized='table',
    tags=['staged'])
    
 }}
with source as (
    select
        {{ convert_type('sale_id', 'string', 'integer') }},
        {{ convert_type('sale_date', 'string', 'date') }},
        {{ convert_type('shop_id', 'string', 'integer') }},
        {{ convert_type('consumer_id', 'string', 'integer') }},
        {{ convert_type('item_id', 'string', 'integer') }},
        {{ convert_type('offer_id', 'string', 'integer') }},
        {{ convert_type('quantity', 'string', 'integer') }},
        {{ convert_type('total_price', 'string', 'float') }},
        payment_method,
        order_status,
        {{ convert_type('delivery_date', 'string', 'date') }},
        delivery_status,
        country
    from {{ source('dbt_staged', 'sales') }}
    where sale_id is not null and
          sale_date is not null
)

select
    sale_id,
    sale_date,
    shop_id,
    consumer_id,
    item_id,
    offer_id,
    quantity,
    total_price,
    payment_method,
    order_status,
    delivery_date,
    delivery_status,
    country
from source
