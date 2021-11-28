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
        , promo_id
        , user_id
        , address_id
        , order_cost
        , shipping_cost
        , order_total
        , tracking_id
        , shipping_service
        , estimated_delivery_at
        , delivered_at
        , status as order_status
        , created_at    
    from src
),

transformed as (
    select * from renamed
),

final as (
    select * from transformed
)

select * from final