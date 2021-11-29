{{ 
    config(
        materialized='table'
        , unique_key='product_id'
    )
}}

select
    product_id
    , product_name
    , price
    , quantity_inventory
from {{ ref('stg_products') }} p