-- models/stg_loyalty_activities.sql

{{ config(materialized='table',
    tags=['staged'])
    
 }}
with source as (
    select
        {{ convert_type('loyalty_activity_id', 'string', 'integer') }},
        {{ convert_type('consumer_id', 'string', 'integer') }},
        {{ convert_type('activity_date', 'string', 'date') }},
        activity_type,
        {{ convert_type('points_earned', 'string', 'integer') }},
        {{ convert_type('points_redeemed', 'string', 'integer') }},
        {{ convert_type('balance_points', 'string', 'integer') }}
    from {{ source('dbt_staged', 'loyalty_activities') }}
    where loyalty_activity_id is not null and
          consumer_id is not null and
          activity_date is not null
)

select
    loyalty_activity_id,
    consumer_id,
    activity_date,
    activity_type,
    points_earned,
    points_redeemed,
    balance_points
from source
