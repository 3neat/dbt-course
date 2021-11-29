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
    , case 
        when split_part(page_url, '/', 4) = '' then 'homepage' 
        else lower(split_part(page_url, '/', 4))
    end as page_content_group
    , row_number() over (partition by session_id order by ts_utc asc) as idx_page_views
    , case when split_part(page_url, '/', 4) = 'product' then split_part(page_url,'/',5) else null end as product_viewed
from {{ref('stg_events')}}
where event_type = 'page_view' and ts_utc is not null