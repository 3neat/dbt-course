{{
    config(
        materialized='table'
    )
}}

with src as (
    select * from {{ source('staging', 'products') }}
),

renamed as (
    select
        product_id
        , name
        , price
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