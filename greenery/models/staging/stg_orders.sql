{{
    config(
        materialized='table'
    )
}}

with src as (
    select * from {{ source('staging', 'orders') }}
),

renamed as (
    select
        order_id
        , promo_id as promo_code
        , user_id
        , address_id
        , order_cost
        , shipping_cost
        , order_total
        , tracking_id
        , shipping_service
        , estimated_delivery_at as estimated_delivery_at_utc
        , delivered_at as delivery_at_utc
        , created_at as order_placed_at_utc        
        , status as order_status
    from src
),

transformed as (
    select * from renamed
),

final as (
    select * from transformed
)

select * from final