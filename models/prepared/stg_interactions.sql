-- models/stg_interactions.sql

{{ config(materialized='table',
    tags=['staged'])
    
 }}
with source as (
    select
        {{ convert_type('interaction_id', 'string', 'integer') }},
        {{ convert_type('consumer_id', 'string', 'integer') }},
        {{ convert_type('touchpoint_id', 'string', 'integer') }},
        {{ convert_type('interaction_date', 'string', 'date') }},
        interaction_type,
        resolution_status,
        comments
    from {{ source('dbt_staged', 'interactions') }}
    where interaction_id is not null and
          consumer_id is not null and
          touchpoint_id is not null and
          interaction_date is not null
)

select
    interaction_id,
    consumer_id,
    touchpoint_id,
    interaction_date,
    interaction_type,
    resolution_status,
    comments
from source
