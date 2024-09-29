-- models/stg_offers.sql

{{ config(materialized='table',
    tags=['staged'])
    
 }}
with source as (
    select
        {{ convert_type('offer_id', 'string', 'integer') }},
        offer_name,
        {{ convert_type('discount', 'string', 'float') }},
        {{ convert_type('valid_from', 'string', 'date') }},
        {{ convert_type('valid_to', 'string', 'date') }},
        terms,
        {{ convert_type('offer_code', 'string', 'string') }}, 
        {{ convert_type('max_usage', 'string', 'integer') }},
        {{ convert_type('country', 'string', 'string') }} 
    from {{ source('dbt_staged', 'offers') }}
    where offer_id is not null and
          offer_name is not null and
          valid_from is not null and
          valid_to is not null
)

select
    offer_id,
    offer_name,
    discount,
    valid_from,
    valid_to,
    terms,
    offer_code,
    max_usage,
    country
from source
