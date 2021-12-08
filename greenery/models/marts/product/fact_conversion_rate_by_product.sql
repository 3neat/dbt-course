{{
    config(
        materialized='table'
    )
}}

{% set event_types = ["add_to_cart","checkout"] %}

with sessions_with_checkout as (
    select
        session_id
        , MAX(case when event_type = 'checkout' then 1 else 0 end) as has_checkout
    from {{ref('int_events')}}
    group by session_id
),

sessions_with_product as (
    select
        session_id
        , product_viewed as product_id
    from {{ref('int_events')}}
    where event_type = 'add_to_cart'
    group by session_id, product_viewed
),

conv_rate_by_product as (
    select
        product_id
        , sum(c.has_checkout)::numeric / count(p.session_id) as conv_rate
    from sessions_with_product p
    left join sessions_with_checkout c ON p.session_id = c.session_id
    group by product_id
)

select
    product_name
    , round(conv_rate,2) as conversion_rate
from conv_rate_by_product c
left join {{ref('stg_products')}} p ON c.product_id = p.product_id