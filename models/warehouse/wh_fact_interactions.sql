-- models/wh_fact_interactions.sql

{{ config(materialized='table',
    tags=['warehouse'],
    schema='dbt_warehouse')
 }}
WITH enriched_interactions AS (
    SELECT
        interaction_id,
        interaction_date,
        consumer_id,
        touchpoint_id,
        interaction_type,
        resolution_status,
        comments
    FROM
        {{ ref('stg_interactions') }}
    WHERE
        interaction_id IS NOT NULL AND
        interaction_date IS NOT NULL AND
        consumer_id IS NOT NULL AND
        touchpoint_id IS NOT NULL
)

SELECT
    ei.interaction_id,
    ei.interaction_date,
    ei.consumer_id,
    c.consumer_name,
    ei.touchpoint_id,
    t.touchpoint_name,
    ei.interaction_type,
    ei.resolution_status,
    ei.comments
FROM
    enriched_interactions ei
LEFT JOIN
    {{ ref('stg_consumers') }} c ON ei.consumer_id = c.consumer_id
LEFT JOIN
    {{ ref( 'stg_touchpoints') }} t ON ei.touchpoint_id = t.touchpoint_id
