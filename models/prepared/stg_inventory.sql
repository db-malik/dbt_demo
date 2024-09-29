-- models/stg_inventory.sql

{{ config(materialized='table',
    tags=['staged'])
    
 }}
with source as (
    select
        {{ convert_type('inventory_id', 'string', 'integer') }},
        {{ convert_type('item_id', 'string', 'integer') }},
        {{ convert_type('quantity_on_hand', 'string', 'integer') }},
        {{ convert_type('reorder_level', 'string', 'integer') }},
        warehouse_location,
        {{ convert_type('last_updated', 'string', 'date') }}
    from {{ source('dbt_staged', 'inventory') }}
    where inventory_id is not null and
          item_id is not null
)

select
    inventory_id,
    item_id,
    quantity_on_hand,
    reorder_level,
    warehouse_location,
    last_updated
from source
