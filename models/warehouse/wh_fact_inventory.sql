-- models/wh_fact_inventory.sql

{{ config(materialized='table', tags=['warehouse'], schema='dbt_warehouse') }}
WITH enriched_inventory AS (
    SELECT
        inventory_id,
        item_id,
        quantity_on_hand,
        COALESCE(reorder_level, 0) AS reorder_level,  -- Handle potential NULLs in reorder_level
        warehouse_location,
        last_updated
    FROM
        {{ ref( 'stg_inventory') }}
    WHERE
        inventory_id IS NOT NULL
),

item_details AS (
    SELECT
        item_id,
        item_name,
        category
    FROM
        {{ ref('stg_items') }}
),

warehouse_details AS (
    SELECT
        CAST(location_id AS STRING) AS warehouse_location,  -- Assuming location_id is present and correctly referenced; adjust if not applicable
        city AS warehouse_city,
        country AS warehouse_country
    FROM
        {{ ref( 'stg_location_dimension') }}
)

SELECT
    ei.inventory_id,
    ei.item_id,
    id.item_name,
    id.category,
    ei.quantity_on_hand,
    ei.reorder_level,
    ei.warehouse_location,
    wd.warehouse_city,
    wd.warehouse_country,
    ei.last_updated
FROM
    enriched_inventory ei
LEFT JOIN
    item_details id ON ei.item_id = id.item_id
LEFT JOIN
    warehouse_details wd ON ei.warehouse_location = wd.warehouse_location
