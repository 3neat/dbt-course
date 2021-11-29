{{
    config(
        materialized='table'
    )
}}


select
    ts_utc
    , event_id    
    , event_type
    , session_id
    , user_id
    , page_url
    , page_content_group
    , idx_page_views
    , product_viewed
    , case when idx_page_views = 1 then true else false end as is_session_entry
from {{ref('int_page_views')}}