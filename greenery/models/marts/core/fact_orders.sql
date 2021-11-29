{{
    config(
        materialized='table'
    )
}}


select
    order_id
    , user_id
    , sa.zip_code as shipment_zip_code
    , sa.state as shipment_state
    , sa.country as shipment_country
    , o.promo_code
    , discount_amount_pct
    , order_cost
    , shipping_cost
    , round((order_cost::numeric * (discount_amount_pct::numeric/100)), 2) as order_cost_net_promo_amount
    , order_total
    , order_status
    , shipping_service
    , extract(day from estimated_delivery_at_utc - delivery_at_utc) as compare_delivery_to_estimate
    , extract(day from order_placed_at_utc - delivery_at_utc) as days_to_deliver
from {{ref('stg_orders')}} o
left join {{ref('stg_addresses')}} sa on o.address_id = sa.address_id
left join {{ref('stg_promos')}} p on p.promo_code = o.promo_code