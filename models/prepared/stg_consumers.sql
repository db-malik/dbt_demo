-- models/stg_consumers.sql

{{ config(materialized='table',
    tags=['staged'])
 }}
with source as (
    select
        {{ convert_type('consumer_id', 'string', 'integer') }},
        consumer_name,
        consumer_email,
        consumer_city,
        phone_number,
        {{ convert_type('date_of_birth', 'string', 'date') }},
        address,
        {{ convert_type('loyalty_points', 'string', 'integer') }},
        country
    from  {{ source('dbt_staged', 'consumers') }}
    where consumer_id is not null     
)

select
    consumer_id,
    consumer_name,
    consumer_email,
    consumer_city,
    phone_number,
    date_of_birth,
    address,
    loyalty_points,
    country
from source
