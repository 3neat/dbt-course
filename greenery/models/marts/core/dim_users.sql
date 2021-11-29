{{ 
    config(
        materialized='table'
    )
}}

select
    u.user_id
    , email
    , email_domain
    , first_name
    , last_name
    , zip_code
    , state
    , country
    , account_creation_utc
    , account_age_days
    , bool_or(o.promo_code is not null) as has_used_promo_code
    , count(distinct o.order_id) as total_orders_made
    , max(case when o.order_status = 'delivered' then o.order_placed_at_utc else null end) as last_delivered_order_at_utc
    , sum(o.order_cost) as total_gross_order_costs
    , sum(o.shipping_cost) as total_shipping_costs
from {{ ref('int_users') }} u
left join {{ ref('stg_orders') }} o on u.user_id = o.user_id
group by 1,2,3,4,5,6,7,8,9,10