-- models/mrt_marketing/mrt_offers.sql

{{ config(
    tags=['mrt_marketing'],
    schema='dbt_mrt_marketing',
    )
 }}
SELECT
    offer_id,
    offer_name,
    discount,
    valid_from,
    valid_to,
    terms,
    offer_code,
    max_usage,
    country
FROM
    {{ ref('stg_offers') }}
