-- models/data_analyst/mrt_customer_analysis.sql

{{ config(materialized='incremental',
    tags=['mrt_analyst'],
     partition_by={
      "field": "date_id",
      "data_type": "date"
    }
    )
 }}
WITH interactions AS (
    SELECT
        interaction_date AS date_id,
        consumer_id,
        COUNT(*) AS total_interactions
    FROM
        {{ ref('wh_fact_interactions') }}
    GROUP BY
        interaction_date,
        consumer_id
),
loyalty AS (
    SELECT
        activity_date AS date_id,
        consumer_id,
        SUM(points_earned) AS total_points_earned,
        SUM(points_redeemed) AS total_points_redeemed,
        AVG(balance_points) AS average_points_balance
    FROM
        {{ ref('wh_fact_loyalty') }}
    GROUP BY
        activity_date,
        consumer_id
)
SELECT
    COALESCE(i.date_id, l.date_id) AS date_id,
    COALESCE(i.consumer_id, l.consumer_id) AS consumer_id,
    COALESCE(total_interactions, 0) AS total_interactions,
    COALESCE(total_points_earned, 0) AS total_points_earned,
    COALESCE(total_points_redeemed, 0) AS total_points_redeemed,
    COALESCE(average_points_balance, 0) AS average_points_balance
FROM
    interactions i
FULL OUTER JOIN
    loyalty l ON i.consumer_id = l.consumer_id AND i.date_id = l.date_id
