-- models/stg_media_channels.sql

{{ config(materialized='table',
    tags=['staged'])
    
 }}
with source as (
    select
        {{ convert_type('media_channel_id', 'string', 'integer') }},
        media_channel_name,
        description
    from {{ source('dbt_staged', 'media_channels') }}
    where media_channel_id is not null
)

select
    media_channel_id,
    media_channel_name,
    description
from source
