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
        id
        , created_at
        , event_type        
        , session_id
        , event_id
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