-- models/stg_audience_segments.sql

{{ config(materialized='table',
    tags=['staged'])  
 }}
with source as (
    select
        cast(audience_segment_id as INT64) as audience_segment_id,
        segment_name,
        description
    from {{ source('dbt_staged', 'audience_segments') }}
    where segment_name is not null 
)

select
    audience_segment_id,
    segment_name,
    description
from source
