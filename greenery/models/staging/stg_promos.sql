{{
    config(
        materialized='table'
    )
}}

with src as (
    select * from {{ source('staging', 'promos') }}
),

renamed as (
    select
        promo_id as promo_code
        , discout as discount_amount_pct
        , status as promo_status
    from src
),

transformed as (
    select * from renamed
),

final as (
    select * from transformed
)

select * from final
