{{ 
    config(
        materialized='table'
        , unique_key='user_id'
    )
}}

select
    user_id
    , email
    , split_part(email, '@', 2) as email_domain
    , first_name
    , last_name
    , zip_code
    , state
    , country
    , account_creation_utc
    , extract(day from now() - account_creation_utc) as account_age_days
from {{ ref('stg_users') }} u
left join {{ ref('stg_addresses') }} a on u.address_id = a.address_id