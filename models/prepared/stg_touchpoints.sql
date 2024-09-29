-- models/stg_touchpoints.sql

{{ config(materialized='table',
    tags=['staged'])
 }}
with source as (
    select
        {{ convert_type('touchpoint_id', 'string', 'integer') }},
        touchpoint_name,
        description
    from {{ source('dbt_staged', 'touchpoints') }}
    where touchpoint_id is not null
)

select
    touchpoint_id,
    touchpoint_name,
    description
from source
