{{
    config(
        materialized='table'
    )
}}

with src as (
    select * from {{ source('tutorial', 'products') }}
),

renamed as (
    select
        product_id
        , name as product_name
        , price
        , quantity as quantity_inventory
    from src
),

transformed as (
    select * from renamed
),

final as (
    select * from transformed
)

select * from final