-- models/mrt_marketing/mrt_media_channels.sql

{{ config(
    tags=['mrt_marketing'],
    schema='dbt_mrt_marketing')
 }}
SELECT
    media_channel_id,
    media_channel_name,
    description
FROM
    {{ ref('stg_media_channels') }}
