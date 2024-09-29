

{{ config(materialized='table',
    tags=['staged'])
    
 }}
with source as (
    select
        {{ convert_type('supplier_id', 'string', 'integer') }},
        supplier_name,
        contact_name,
        contact_email, 
        {{ convert_type('contact_phone', 'string', 'string') }}, 
        address,
        country
    from {{ source('dbt_staged', 'suppliers') }}
    where supplier_id is not null
)

select
    supplier_id,
    supplier_name,
    contact_name,
    contact_email,
    contact_phone,
    address,
    country
from source
