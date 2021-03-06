{{
    config(
        materialized='table'
    )
}}

with src as (
    select * from {{ source('tutorial', 'order_items') }}
),

renamed as (
    select 
        order_id
        , product_id
        , quantity as order_quantity
    from src
),

transformed as (
    select * from renamed
),

final as (
    select * from transformed
)

select * from final