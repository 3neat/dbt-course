{{
    config(
        materialized='table'
    )
}}

SELECT
    id
    , event_id
    , event_type
    , session_id
    , user_id
    , page_url
    , created_at
FROM {{ source('staging', 'events') }}