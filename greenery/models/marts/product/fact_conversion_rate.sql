{{
    config(
        materialized='table'
    )
}}

{% set event_types = ["add_to_cart","checkout"] %}

with sessions_with_checkout as (
    select
        session_id
        {% for event_type in event_types %}
        , MAX(case when event_type = '{{ event_type }}' then 1 else 0 end) as was_{{ event_type }}
        {% endfor %}
    from {{ref('int_events')}}
    group by session_id
)

select sum(was_checkout)::numeric / count(session_id) as conv_rate
from sessions_with_checkout