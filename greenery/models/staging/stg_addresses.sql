{{
    config(
        materialized='table'
    )
}}

with src as (
    select * from {{ source('staging', 'addresses') }}
),

renamed as (
    select
        address_id
        , address
        , zipcode as zip_code
        , state
        , country
    from src
),

transformed as (
    select * from renamed
),

final as (
    select * from transformed
)

select * from final