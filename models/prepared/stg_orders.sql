-- models/stg_orders.sql

{{ config(materialized='table',
    tags=['staged'])
    
 }}
with source as (
    select
        {{ convert_type('order_id', 'string', 'integer') }},
        {{ convert_type('item_id', 'string', 'integer') }},
        {{ convert_type('supplier_id', 'string', 'integer') }},
        {{ convert_type('order_date', 'string', 'date') }},
        {{ convert_type('quantity_ordered', 'string', 'integer') }},
        order_status,
        {{ convert_type('expected_delivery_date', 'string', 'date') }}
    from {{ source('dbt_staged', 'orders') }}
    where order_id is not null and
          item_id is not null and
          supplier_id is not null and
          order_date is not null
)

select
    order_id,
    item_id,
    supplier_id,
    order_date,
    quantity_ordered,
    order_status,
    expected_delivery_date
from source
