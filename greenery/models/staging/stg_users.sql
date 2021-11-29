{{
    config(
        materialized='table'
    )
}}

with src as (
    select * from {{ source('staging', 'users') }}
),

renamed as (
    select
        user_id
        , first_name
        , last_name
        , email
        , phone_number
        , created_at as account_creation_utc
        , updated_at as updated_at_utc
        , address_id
    from src
),

transformed as (
    select * from renamed
),

final as (
    select * from transformed
)

select * from final