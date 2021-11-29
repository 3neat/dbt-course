{{
    config(
        materialized='table'
    )
}}

with src as (
    select * from {{ source('staging', 'events') }}
),

renamed as (
    select
        event_id
        , created_at as ts_utc
        , event_type        
        , session_id
        , user_id
        , page_url
    from src
),

transformed as (
    select 
        *
    from renamed
),

final as (
    select * from transformed
)

select * from final