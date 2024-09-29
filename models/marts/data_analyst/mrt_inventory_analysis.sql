-- models/data_analyst/mrt_inventory_analysis.sql

{{ config(materialized='incremental',
    tags=['mrt_analyst'],
    partition_by={
      "field": "date_id",
      "data_type": "date"
    }
    )
 }}
WITH inventory AS (
    SELECT
        last_updated AS date_id,
        item_id,
        MAX(quantity_on_hand) AS total_stock,
        SUM(reorder_level) AS total_reorders
    FROM
        {{ ref('wh_fact_inventory') }}
    GROUP BY
        last_updated,
        item_id
),
orders AS (
    SELECT
        order_date AS date_id,
        item_id,
        SUM(quantity_ordered) AS total_ordered_quantity
    FROM
        {{ ref('stg_orders') }}
    GROUP BY
        order_date,
        item_id
)
SELECT
    COALESCE(i.date_id, o.date_id) AS date_id,
    COALESCE(i.item_id, o.item_id) AS item_id,
    COALESCE(total_stock, 0) AS total_stock,
    COALESCE(total_reorders, 0) AS total_reorders,
    COALESCE(total_ordered_quantity, 0) AS total_ordered_quantity
FROM
    inventory i
FULL OUTER JOIN
    orders o ON i.item_id = o.item_id AND i.date_id = o.date_id
