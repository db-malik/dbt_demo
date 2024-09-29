-- models/wh_fact_loyalty.sql

{{ config(materialized='table',
    tags=['warehouse'],
    schema='dbt_warehouse')
 }}
WITH enriched_loyalty_activities AS (
    SELECT
        loyalty_activity_id,
        activity_date,
        consumer_id,
        activity_type,
        points_earned,
        points_redeemed,
        (points_earned - points_redeemed) AS balance_points
    FROM
        {{ ref('stg_loyalty_activities') }}
    WHERE
        loyalty_activity_id IS NOT NULL AND
        activity_date IS NOT NULL AND
        consumer_id IS NOT NULL
)

SELECT
    la.loyalty_activity_id,
    la.activity_date,
    la.consumer_id,
    c.consumer_name,
    la.activity_type,
    la.points_earned,
    la.points_redeemed,
    la.balance_points
FROM
    enriched_loyalty_activities la
LEFT JOIN
    {{ ref( 'stg_consumers') }} c ON la.consumer_id = c.consumer_id
