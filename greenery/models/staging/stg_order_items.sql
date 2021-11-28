{{
    config(
        materialized='table'
    )
}}

with src as (
    select * from {{ source('staging', 'order_items') }}
),

renamed as (
    select 
        order_id
        , product_id
        , quantity    
    from src
),

transformed as (
    select * from renamed
),

final as (
    select * from transformed
)

select * from final