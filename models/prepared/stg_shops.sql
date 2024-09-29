-- models/stg_shops.sql

{{ config(materialized='table',
    tags=['staged'])
    
 }}
with source as (
    select
        {{ convert_type('shop_id', 'string', 'integer') }},
        shop_name,
        shop_location,
        {{ convert_type('shop_type', 'string', 'string') }},  -- assuming it's already a string but illustrating usage
        {{ convert_type('established_year', 'string', 'integer') }},
        owner,
        {{ convert_type('contact_email', 'string', 'string') }},  -- assuming it's already a string but illustrating usage
        {{ convert_type('country', 'string', 'string') }}  -- assuming it's already a string but illustrating usage
    from {{ source('dbt_staged', 'shops') }}
    where shop_id is not null
)

select
    shop_id,
    shop_name,
    shop_location,
    shop_type,
    established_year,
    owner,
    contact_email,
    country
from source
