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
        id
        , user_id
        , first_name
        , last_name
        , email
        , phone_number
        , created_at
        , updated_at
        , address_id
    from src
),

transformed as (
    select
        *
        , split_part(email, '@', 2) as email_domain
    from renamed
),

final as (
    select * from transformed
)

select * from final