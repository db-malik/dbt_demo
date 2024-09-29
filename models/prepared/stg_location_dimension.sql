-- models/stg_location_dimension.sql

{{ config(materialized='table',
    tags=['staged'])
    
 }}
with source as (
    select
        {{ convert_type('location_id', 'string', 'integer') }},
        city,
        country
    from {{ source('dbt_staged', 'location_dimension') }}
    where location_id is not null
)

select
    location_id,
    city,
    country
from source
