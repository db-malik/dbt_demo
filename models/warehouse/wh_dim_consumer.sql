-- models/wh_dim_consumer.sql

{{ config(materialized='table', tags=['warehouse'],  schema='dbt_warehouse')
 }}

WITH enriched_consumers AS (
    SELECT
        consumer_id,
        consumer_name,
        consumer_email,
        consumer_city,
        phone_number,
        date_of_birth,
        EXTRACT(YEAR FROM CURRENT_DATE()) - EXTRACT(YEAR FROM date_of_birth) AS age,
        address,
        loyalty_points,
        country
    FROM
        {{ ref( 'stg_consumers') }}
    WHERE
        consumer_id IS NOT NULL AND
        consumer_email IS NOT NULL AND
        date_of_birth IS NOT NULL
),

transactions AS (
    SELECT
        consumer_id,
        COUNT(*) AS total_transactions,
        SUM(total_price) AS total_spend,
        AVG(total_price) AS average_transaction_value
    FROM
        {{ ref('stg_sales') }}
    GROUP BY
        consumer_id
)

SELECT
    ec.consumer_id,
    ec.consumer_name,
    ec.consumer_email,
    ec.consumer_city,
    ec.phone_number,
    ec.date_of_birth,
    ec.age,
    ec.address,
    COALESCE(t.total_transactions, 0) AS total_transactions,
    COALESCE(t.total_spend, 0.0) AS total_spend,
    COALESCE(t.average_transaction_value, 0.0) AS average_transaction_value,
    ec.loyalty_points,
    ec.country
FROM
    enriched_consumers ec
LEFT JOIN
    transactions t ON ec.consumer_id = t.consumer_id
