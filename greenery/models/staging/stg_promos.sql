{{
    config(
        materialized='table'
    )
}}

SELECT
    promo_id as promo_code
    , discout as discount
    , status as promo_status
FROM {{ source('staging', 'promos') }}