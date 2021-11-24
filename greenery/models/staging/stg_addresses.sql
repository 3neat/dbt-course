{{
    config(
        materialized='table'
    )
}}

SELECT
    id
    , address_id
    , address
    , zipcode as zip_code
    , state
    , country
FROM {{ source('staging', 'addresses') }}